import 'package:freezed_annotation/freezed_annotation.dart';

part 'oauth_config_model.freezed.dart';
part 'oauth_config_model.g.dart';

/// OAuth 2.0 flow types supported by APIDash
enum OAuthFlow {
  /// Client Credentials flow (no user interaction)
  clientCredentials,

  /// Authorization Code flow (with browser redirect)
  authorizationCode,

  /// Resource Owner Password Grant flow
  resourceOwnerPassword
}

/// OAuth 2.0 Configuration Model
@freezed
class OAuthConfig with _$OAuthConfig {
  const OAuthConfig._();

  @JsonSerializable(explicitToJson: true)
  const factory OAuthConfig({
    /// Unique identifier for this OAuth configuration
    String? id,

    /// OAuth Flow type
    @Default(OAuthFlow.authorizationCode) OAuthFlow flow,

    /// Client ID from OAuth provider
    @Default('') String clientId,

    /// Client Secret from OAuth provider (optional for some flows)
    String? clientSecret,

    /// Authorization endpoint URL
    @Default('') String authorizationEndpoint,

    /// Token endpoint URL
    @Default('') String tokenEndpoint,

    /// Redirect URI for OAuth callback
    @Default('http://localhost:8080/callback') String redirectUri,

    /// OAuth scopes
    @Default([]) List<String> scopes,

    /// Optional state parameter for CSRF protection
    String? state,

    /// Optional description for this OAuth configuration
    String? description,

    /// Username for Resource Owner Password Grant flow
    String? username,

    /// Password for Resource Owner Password Grant flow
    String? password,
  }) = _OAuthConfig;

  factory OAuthConfig.fromJson(Map<String, dynamic> json) => 
      _$OAuthConfigFromJson(json);
}
