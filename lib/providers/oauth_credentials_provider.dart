import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/oauth_config_model.dart';
import '../models/oauth_credentials_model.dart';
import '../services/oauth_service.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

class OAuthCredentialsNotifier extends StateNotifier<Map<String, OAuthCredentials>> {
  final OAuthService _oauthService;

  OAuthCredentialsNotifier(this._oauthService) : super({}) {
    print('[OAuth Credentials] Initializing OAuthCredentialsNotifier');
  }

  Future<OAuthCredentials> acquireCredentials(OAuthConfig config) async {
    print('\n[OAuth Credentials] Acquiring credentials for config:');
    print('[OAuth Credentials] Config ID: ${config.id}');
    print('[OAuth Credentials] Flow type: ${config.flow}');
    
    try {
      OAuthCredentials credentials;
      
      switch (config.flow) {
        case OAuthFlow.authorizationCode:
          print('[OAuth Credentials] Using Authorization Code flow');
          credentials = await _oauthService.acquireAuthorizationCodeToken(config);
          break;
        case OAuthFlow.clientCredentials:
          print('[OAuth Credentials] Using Client Credentials flow');
          credentials = await _acquireClientCredentialsToken(config);
          break;
        case OAuthFlow.resourceOwnerPassword:
          print('[OAuth Credentials] Using Resource Owner Password Grant');
          credentials = await _acquireResourceOwnerPasswordToken(config);
          break;
        default:
          throw UnimplementedError('Unsupported OAuth flow: ${config.flow}');
      }

      print('[OAuth Credentials] Successfully acquired credentials');
      print('[OAuth Credentials] Access Token length: ${credentials.accessToken.length}');
      print('[OAuth Credentials] Has Refresh Token: ${credentials.refreshToken != null}');

      // Store credentials by config ID
      state = {
        ...state,
        config.id!: credentials
      };
      print('[OAuth Credentials] Stored credentials in state for config ID: ${config.id}');

      return credentials;
    } catch (e, stack) {
      print('[OAuth Credentials] Error acquiring credentials:');
      print('[OAuth Credentials] Error: $e');
      print('[OAuth Credentials] Stack trace:\n$stack');
      throw Exception('Failed to acquire OAuth credentials: $e');
    }
  }

  Future<OAuthCredentials> _acquireClientCredentialsToken(OAuthConfig config) async {
    if (config.clientId.isEmpty || config.tokenEndpoint.isEmpty) {
      throw ArgumentError('Client ID and Token Endpoint are required');
    }

    final client = await oauth2.clientCredentialsGrant(
      Uri.parse(config.tokenEndpoint), 
      config.clientId, 
      config.clientSecret ?? ''
    );

    return OAuthCredentials(
      accessToken: client.credentials.accessToken,
      refreshToken: client.credentials.refreshToken
    );
  }

  Future<OAuthCredentials> _acquireResourceOwnerPasswordToken(OAuthConfig config) async {
    if (config.clientId.isEmpty || 
        config.tokenEndpoint.isEmpty || 
        config.username == null || 
        config.password == null) {
      throw ArgumentError('Client ID, Token Endpoint, Username, and Password are required');
    }

    final client = await oauth2.resourceOwnerPasswordGrant(
      Uri.parse(config.tokenEndpoint), 
      config.username!, 
      config.password!,
      identifier: config.clientId,
      secret: config.clientSecret ?? ''
    );

    return OAuthCredentials(
      accessToken: client.credentials.accessToken,
      refreshToken: client.credentials.refreshToken
    );
  }

  Future<OAuthCredentials> _acquireAuthorizationCodeToken(OAuthConfig config) async {
    // Delegate to OAuth service for Authorization Code flow
    return await _oauthService.acquireAuthorizationCodeToken(config);
  }

  Future<OAuthCredentials?> getCredentials(String configId) async {
    print('\n[OAuth Credentials] Getting credentials for config ID: $configId');
    
    // First check in-memory credentials
    if (state.containsKey(configId)) {
      print('[OAuth Credentials] Found credentials in memory');
      final credentials = state[configId]!;
      print('[OAuth Credentials] Access Token length: ${credentials.accessToken.length}');
      print('[OAuth Credentials] Has Refresh Token: ${credentials.refreshToken != null}');
      return credentials;
    }
    print('[OAuth Credentials] No credentials in memory, checking secure storage');

    // Then try to retrieve from secure storage
    final storedCredentials = await _oauthService.getCredentials(configId);
    
    if (storedCredentials != null) {
      print('[OAuth Credentials] Found credentials in secure storage');
      state = {
        ...state,
        configId: storedCredentials
      };
      print('[OAuth Credentials] Loaded credentials into memory');
      return storedCredentials;
    }

    print('[OAuth Credentials] No credentials found for config ID: $configId');
    return null;
  }

  Future<void> clearCredentials(String configId) async {
    print('\n[OAuth Credentials] Clearing credentials for config ID: $configId');
    try {
      // Remove from state
      state = Map.from(state)..remove(configId);
      print('[OAuth Credentials] Removed credentials from memory');

      // Remove from secure storage
      print('[OAuth Credentials] Removed credentials from secure storage');
    } catch (e, stack) {
      print('[OAuth Credentials] Error clearing credentials:');
      print('[OAuth Credentials] Error: $e');
      print('[OAuth Credentials] Stack trace:\n$stack');
      throw Exception('Failed to clear credentials: $e');
    }
  }

  Future<OAuthCredentials> refreshCredentials(String configId) async {
    print('\n[OAuth Credentials] Refreshing credentials for config ID: $configId');
    
    final currentCredentials = state[configId];
    if (currentCredentials == null) {
      print('[OAuth Credentials] No credentials found to refresh');
      throw StateError('No credentials found for config ID: $configId');
    }

    try {
      print('[OAuth Credentials] Starting token refresh');
      final refreshedCredentials = await _oauthService.refreshToken(currentCredentials);
      
      print('[OAuth Credentials] Successfully refreshed token');
      print('[OAuth Credentials] New Access Token length: ${refreshedCredentials.accessToken.length}');
      print('[OAuth Credentials] Has New Refresh Token: ${refreshedCredentials.refreshToken != null}');
      
      // Update state with new credentials
      state = {
        ...state,
        configId: refreshedCredentials
      };
      print('[OAuth Credentials] Updated state with refreshed credentials');
      
      return refreshedCredentials;
    } catch (e, stack) {
      print('[OAuth Credentials] Error refreshing credentials:');
      print('[OAuth Credentials] Error: $e');
      print('[OAuth Credentials] Stack trace:\n$stack');
      throw Exception('Failed to refresh credentials: $e');
    }
  }

}

final oauthCredentialsProvider = StateNotifierProvider<OAuthCredentialsNotifier, Map<String, OAuthCredentials>>((ref) {
  print('[OAuth Credentials] Creating new OAuthCredentialsNotifier instance');
  final oauthService = ref.read(oauthServiceProvider);
  return OAuthCredentialsNotifier(oauthService);
});

// Provider for OAuth service
final oauthServiceProvider = Provider<OAuthService>((ref) {
  return OAuthService();
});
