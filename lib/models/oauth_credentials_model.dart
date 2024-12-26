import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

part 'oauth_credentials_model.freezed.dart';
part 'oauth_credentials_model.g.dart';

/// Represents OAuth 2.0 Credentials with additional metadata
@freezed
class OAuthCredentials with _$OAuthCredentials {
  const OAuthCredentials._();

  @JsonSerializable(explicitToJson: true)
  const factory OAuthCredentials({
    /// The access token
    required String accessToken,

    /// Refresh token (if available)
    String? refreshToken,

    /// ID token for OpenID Connect
    String? idToken,

    /// Token endpoint URL
    Uri? tokenEndpoint,

    /// Scopes associated with the token
    Iterable<String>? scopes,

    /// Expiration time of the access token
    DateTime? expiration,

    /// Delimiter for token scopes
    String? delimiter,

    /// ID of the associated OAuth configuration
    String? configId,
  }) = _OAuthCredentials;

  factory OAuthCredentials.fromJson(Map<String, dynamic> json) => 
      _$OAuthCredentialsFromJson(json);

  /// Convert from oauth2 Credentials
  factory OAuthCredentials.fromOAuth2Credentials(oauth2.Credentials credentials) {
    return OAuthCredentials(
      accessToken: credentials.accessToken,
      refreshToken: credentials.refreshToken,
      idToken: credentials.idToken,
      tokenEndpoint: credentials.tokenEndpoint,
      scopes: credentials.scopes,
      expiration: credentials.expiration,
      );
  }

  /// Check if the token is expired
  bool get isExpired {
    if (expiration == null) return false;
    return DateTime.now().isAfter(expiration!);
  }

  /// Convert to oauth2 Credentials
  oauth2.Credentials toOAuth2Credentials() {
    return oauth2.Credentials(
      accessToken,
      refreshToken: refreshToken,
      idToken: idToken,
      tokenEndpoint: tokenEndpoint,
      scopes: scopes,
      expiration: expiration,
      delimiter: delimiter,
    );
  }
}
