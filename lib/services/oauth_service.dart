import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../models/oauth_config_model.dart';
import '../models/oauth_credentials_model.dart';

class OAuthService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  static const _credentialsStorageKey = 'oauth_credentials_';

  /// Parse OAuth token response and convert to expected format
  Map<String, dynamic> _parseTokenResponse(http.Response response) {
    print('[OAuth Service] Parsing token response...');
    
    Map<String, dynamic> responseJson = {};
    
    if (response.headers['content-type']?.contains('json') == true) {
      // Handle JSON response (GitHub's case)
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      responseJson = {
        'accessToken': jsonResponse['access_token'],
        'tokenType': jsonResponse['token_type'],
        'scopes': jsonResponse['scope']?.split(',') ?? [],
        if (jsonResponse['refresh_token'] != null)
          'refreshToken': jsonResponse['refresh_token'],
        if (jsonResponse['expires_in'] != null)
          'expiresIn': jsonResponse['expires_in'].toString(),
      };
    } else {
      // Handle form-urlencoded response
      final params = Uri.splitQueryString(response.body);
      responseJson = {
        'accessToken': params['access_token'],
        'tokenType': params['token_type'],
        'scopes': params['scope']?.split(',') ?? [],
        if (params['refresh_token'] != null)
          'refreshToken': params['refresh_token'],
        if (params['expires_in'] != null)
          'expiresIn': params['expires_in'],
      };
    }
    
    print('[OAuth Service] Transformed response: $responseJson');
    return responseJson;
  }

  /// Acquire token using Client Credentials flow
  Future<OAuthCredentials> acquireClientCredentialsToken(OAuthConfig config) async {
    print('\n[OAuth Service] Starting Client Credentials flow...');
    print('[OAuth Service] Config ID: ${config.id}');
    print('[OAuth Service] Token Endpoint: ${config.tokenEndpoint}');
    print('[OAuth Service] Scopes: ${config.scopes}');

    if (config.flow != OAuthFlow.clientCredentials) {
      print('[OAuth Service] Error: Invalid flow type ${config.flow}');
      throw ArgumentError('Invalid flow for client credentials');
    }

    try {
      print('[OAuth Service] Creating HTTP client for token request');
      final client = http.Client();

      final requestBody = {
        'grant_type': 'client_credentials',
        'client_id': config.clientId,
        'client_secret': config.clientSecret ?? '',
        if (config.scopes.isNotEmpty) 'scope': config.scopes.join(' '),
      };
      print('[OAuth Service] Preparing token request with body: $requestBody');

      // Perform token request manually
      print('[OAuth Service] Sending token request...');
      final response = await client.post(
        Uri.parse(config.tokenEndpoint),
        body: requestBody,
      );

      print('[OAuth Service] Token response status: ${response.statusCode}');
      print('[OAuth Service] Token response body: ${response.body}');

      // Check response status
      if (response.statusCode != 200) {
        print('[OAuth Service] Token request failed');
        throw Exception('Failed to acquire token: ${response.body}');
      }

      // Parse token response
      final responseJson = _parseTokenResponse(response);
      final tokenResponse = oauth2.Credentials.fromJson(jsonEncode(responseJson));
      print('[OAuth Service] Token response parsed successfully');

      final oauthCredentials = OAuthCredentials.fromOAuth2Credentials(tokenResponse);
      print('[OAuth Service] Saving credentials for config ID: ${config.id}');
      await _saveCredentials(config.id!, oauthCredentials);
      print('[OAuth Service] Client Credentials flow completed successfully');
      
      return oauthCredentials;
    } catch (e, stack) {
      print('[OAuth Service] Error in Client Credentials flow:');
      print('[OAuth Service] Error: $e');
      print('[OAuth Service] Stack trace:\n$stack');
      throw Exception('Failed to acquire client credentials token: $e');
    }
  }

  /// Acquire token using Authorization Code flow
  Future<OAuthCredentials> acquireAuthorizationCodeToken(OAuthConfig config) async {
    print('\n[OAuth Service] Starting Authorization Code flow...');
    print('[OAuth Service] Config ID: ${config.id}');
    print('[OAuth Service] Auth Endpoint: ${config.authorizationEndpoint}');
    print('[OAuth Service] Token Endpoint: ${config.tokenEndpoint}');
    print('[OAuth Service] Scopes: ${config.scopes}');

    HttpServer? server;
    try {
      // Create a local HTTP server to handle the callback
      final baseRedirectUri = Uri.parse(config.redirectUri);
      
      // Find an available port
      print('[OAuth Service] Finding available port...');
      server = await HttpServer.bind('127.0.0.1', 0); // Let OS assign an available port
      final port = server.port;
      print('[OAuth Service] Server listening on port $port');
      
      // Create actual redirect URI with the assigned port
      final actualRedirectUri = baseRedirectUri.replace(port: port).toString();
      print('[OAuth Service] Actual redirect URI: $actualRedirectUri');
      
      final completer = Completer<String>();
      
      // Listen for the callback
      server.listen((request) async {
        print('[OAuth Service] Received callback request');
        print('[OAuth Service] Request path: ${request.uri.path}');
        print('[OAuth Service] Expected path: ${baseRedirectUri.path}');
        
        if (request.uri.path == baseRedirectUri.path) {
          final code = request.uri.queryParameters['code'];
          if (code != null) {
            print('[OAuth Service] Authorization code received');
            completer.complete(code);
            
            // Send response to browser
            request.response
              ..statusCode = 200
              ..headers.contentType = ContentType.html
              ..write('<html><body><h1>Authorization Successful</h1><p>You can close this window now.</p></body></html>');
            await request.response.close();
          } else {
            print('[OAuth Service] No code in callback parameters');
            request.response
              ..statusCode = 400
              ..headers.contentType = ContentType.html
              ..write('<html><body><h1>Authorization Failed</h1><p>No authorization code received.</p></body></html>');
            await request.response.close();
          }
        } else {
          print('[OAuth Service] Unexpected callback path');
          request.response
            ..statusCode = 404
            ..headers.contentType = ContentType.html
            ..write('<html><body><h1>Invalid Request</h1></body></html>');
          await request.response.close();
        }
      });

      // Construct the authorization URL
      print('[OAuth Service] Building authorization URL...');
      final authUrl = Uri.parse(config.authorizationEndpoint).replace(
        queryParameters: {
          'response_type': 'code',
          'client_id': config.clientId,
          if (config.scopes.isNotEmpty) 'scope': config.scopes.join(' '),
          'redirect_uri': actualRedirectUri,
        },
      );
      print('[OAuth Service] Authorization URL: $authUrl');

      // Launch the authorization URL
      print('[OAuth Service] Launching authorization URL...');
      if (!await launchUrl(authUrl, mode: LaunchMode.externalApplication)) {
        print('[OAuth Service] Failed to launch authorization URL');
        throw Exception('Could not launch authorization URL');
      }

      // Wait for the authorization code
      print('[OAuth Service] Waiting for authorization code...');
      final code = await completer.future.timeout(
        const Duration(minutes: 5),
        onTimeout: () {
          throw TimeoutException('Authorization timed out after 5 minutes');
        },
      );
      print('[OAuth Service] Authorization code received: ${code.length} characters');

      // Exchange the code for a token
      print('[OAuth Service] Exchanging code for token...');
      final client = http.Client();
      
      final tokenRequestBody = {
        'grant_type': 'authorization_code',
        'client_id': config.clientId,
        'client_secret': config.clientSecret ?? '',
        'code': code,
        'redirect_uri': actualRedirectUri,
      };
      print('[OAuth Service] Token request body: $tokenRequestBody');

      final response = await client.post(
        Uri.parse(config.tokenEndpoint),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: tokenRequestBody,
      );

      print('[OAuth Service] Token response status: ${response.statusCode}');
      print('[OAuth Service] Token response headers: ${response.headers}');
      print('[OAuth Service] Token response body: ${response.body}');

      if (response.statusCode != 200) {
        print('[OAuth Service] Token request failed');
        throw Exception('Failed to exchange code for token: ${response.body}');
      }

      // Parse the token response
      final responseJson = _parseTokenResponse(response);
      final credentials = oauth2.Credentials.fromJson(jsonEncode(responseJson));
      print('[OAuth Service] Token response parsed successfully');

      final oauthCredentials = OAuthCredentials.fromOAuth2Credentials(credentials);
      print('[OAuth Service] Saving credentials for config ID: ${config.id}');
      await _saveCredentials(config.id!, oauthCredentials);
      print('[OAuth Service] Authorization Code flow completed successfully');

      return oauthCredentials;
    } catch (e, stack) {
      print('[OAuth Service] Error in Authorization Code flow:');
      print('[OAuth Service] Error: $e');
      print('[OAuth Service] Stack trace:\n$stack');
      throw Exception('Failed to acquire authorization code token: $e');
    } finally {
      // Always ensure server is closed
      if (server != null) {
        print('[OAuth Service] Closing server...');
        await server.close(force: true);
        print('[OAuth Service] Server closed');
      }
    }
  }

  /// Save credentials to secure storage
  Future<void> _saveCredentials(String configId, OAuthCredentials credentials) async {
    print('[OAuth Service] Saving credentials to secure storage...');
    try {
      await _secureStorage.write(
        key: _credentialsStorageKey + configId,
        value: credentials.accessToken,
      );
      print('[OAuth Service] Credentials saved successfully');
    } catch (e) {
      print('[OAuth Service] Error saving credentials: $e');
      throw Exception('Failed to save credentials: $e');
    }
  }

  /// Retrieve saved credentials
  Future<OAuthCredentials?> getCredentials(String configId) async {
    print('[OAuth Service] Getting credentials for config ID: $configId');
    try {
      final storedToken = await _secureStorage.read(key: _credentialsStorageKey + configId);
      if (storedToken == null) {
        print('[OAuth Service] No credentials found');
        return null;
      }
      print('[OAuth Service] Credentials found and loaded');
      // TODO: Implement proper credentials retrieval
      return null;
    } catch (e) {
      print('[OAuth Service] Error getting credentials: $e');
      return null;
    }
  }

  /// Refresh an existing token
  Future<OAuthCredentials> refreshToken(OAuthCredentials credentials) async {
    if (credentials.refreshToken == null) {
      print('[OAuth Service] Error: No refresh token available');
      throw StateError('No refresh token available');
    }

    try {
      print('[OAuth Service] Refreshing token...');
      final oauth2Credentials = credentials.toOAuth2Credentials();
      final refreshedCredentials = await oauth2Credentials.refresh(
        identifier: null, // Use existing client ID
        secret: null,     // Use existing client secret
      );

      print('[OAuth Service] Token refreshed successfully');
      final updatedCredentials = OAuthCredentials.fromOAuth2Credentials(refreshedCredentials);
      return updatedCredentials;
    } catch (e, stack) {
      print('[OAuth Service] Error refreshing token:');
      print('[OAuth Service] Error: $e');
      print('[OAuth Service] Stack trace:\n$stack');
      throw Exception('Failed to refresh token: $e');
    }
  }
}
