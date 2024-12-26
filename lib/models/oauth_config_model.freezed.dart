// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'oauth_config_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OAuthConfig _$OAuthConfigFromJson(Map<String, dynamic> json) {
  return _OAuthConfig.fromJson(json);
}

/// @nodoc
mixin _$OAuthConfig {
  /// Unique identifier for this OAuth configuration
  String? get id => throw _privateConstructorUsedError;

  /// OAuth Flow type
  OAuthFlow get flow => throw _privateConstructorUsedError;

  /// Client ID from OAuth provider
  String get clientId => throw _privateConstructorUsedError;

  /// Client Secret from OAuth provider (optional for some flows)
  String? get clientSecret => throw _privateConstructorUsedError;

  /// Authorization endpoint URL
  String get authorizationEndpoint => throw _privateConstructorUsedError;

  /// Token endpoint URL
  String get tokenEndpoint => throw _privateConstructorUsedError;

  /// Redirect URI for OAuth callback
  String get redirectUri => throw _privateConstructorUsedError;

  /// OAuth scopes
  List<String> get scopes => throw _privateConstructorUsedError;

  /// Optional state parameter for CSRF protection
  String? get state => throw _privateConstructorUsedError;

  /// Optional description for this OAuth configuration
  String? get description => throw _privateConstructorUsedError;

  /// Username for Resource Owner Password Grant flow
  String? get username => throw _privateConstructorUsedError;

  /// Password for Resource Owner Password Grant flow
  String? get password => throw _privateConstructorUsedError;

  /// Serializes this OAuthConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OAuthConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OAuthConfigCopyWith<OAuthConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OAuthConfigCopyWith<$Res> {
  factory $OAuthConfigCopyWith(
          OAuthConfig value, $Res Function(OAuthConfig) then) =
      _$OAuthConfigCopyWithImpl<$Res, OAuthConfig>;
  @useResult
  $Res call(
      {String? id,
      OAuthFlow flow,
      String clientId,
      String? clientSecret,
      String authorizationEndpoint,
      String tokenEndpoint,
      String redirectUri,
      List<String> scopes,
      String? state,
      String? description,
      String? username,
      String? password});
}

/// @nodoc
class _$OAuthConfigCopyWithImpl<$Res, $Val extends OAuthConfig>
    implements $OAuthConfigCopyWith<$Res> {
  _$OAuthConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OAuthConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? flow = null,
    Object? clientId = null,
    Object? clientSecret = freezed,
    Object? authorizationEndpoint = null,
    Object? tokenEndpoint = null,
    Object? redirectUri = null,
    Object? scopes = null,
    Object? state = freezed,
    Object? description = freezed,
    Object? username = freezed,
    Object? password = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      flow: null == flow
          ? _value.flow
          : flow // ignore: cast_nullable_to_non_nullable
              as OAuthFlow,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      clientSecret: freezed == clientSecret
          ? _value.clientSecret
          : clientSecret // ignore: cast_nullable_to_non_nullable
              as String?,
      authorizationEndpoint: null == authorizationEndpoint
          ? _value.authorizationEndpoint
          : authorizationEndpoint // ignore: cast_nullable_to_non_nullable
              as String,
      tokenEndpoint: null == tokenEndpoint
          ? _value.tokenEndpoint
          : tokenEndpoint // ignore: cast_nullable_to_non_nullable
              as String,
      redirectUri: null == redirectUri
          ? _value.redirectUri
          : redirectUri // ignore: cast_nullable_to_non_nullable
              as String,
      scopes: null == scopes
          ? _value.scopes
          : scopes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OAuthConfigImplCopyWith<$Res>
    implements $OAuthConfigCopyWith<$Res> {
  factory _$$OAuthConfigImplCopyWith(
          _$OAuthConfigImpl value, $Res Function(_$OAuthConfigImpl) then) =
      __$$OAuthConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      OAuthFlow flow,
      String clientId,
      String? clientSecret,
      String authorizationEndpoint,
      String tokenEndpoint,
      String redirectUri,
      List<String> scopes,
      String? state,
      String? description,
      String? username,
      String? password});
}

/// @nodoc
class __$$OAuthConfigImplCopyWithImpl<$Res>
    extends _$OAuthConfigCopyWithImpl<$Res, _$OAuthConfigImpl>
    implements _$$OAuthConfigImplCopyWith<$Res> {
  __$$OAuthConfigImplCopyWithImpl(
      _$OAuthConfigImpl _value, $Res Function(_$OAuthConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of OAuthConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? flow = null,
    Object? clientId = null,
    Object? clientSecret = freezed,
    Object? authorizationEndpoint = null,
    Object? tokenEndpoint = null,
    Object? redirectUri = null,
    Object? scopes = null,
    Object? state = freezed,
    Object? description = freezed,
    Object? username = freezed,
    Object? password = freezed,
  }) {
    return _then(_$OAuthConfigImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      flow: null == flow
          ? _value.flow
          : flow // ignore: cast_nullable_to_non_nullable
              as OAuthFlow,
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      clientSecret: freezed == clientSecret
          ? _value.clientSecret
          : clientSecret // ignore: cast_nullable_to_non_nullable
              as String?,
      authorizationEndpoint: null == authorizationEndpoint
          ? _value.authorizationEndpoint
          : authorizationEndpoint // ignore: cast_nullable_to_non_nullable
              as String,
      tokenEndpoint: null == tokenEndpoint
          ? _value.tokenEndpoint
          : tokenEndpoint // ignore: cast_nullable_to_non_nullable
              as String,
      redirectUri: null == redirectUri
          ? _value.redirectUri
          : redirectUri // ignore: cast_nullable_to_non_nullable
              as String,
      scopes: null == scopes
          ? _value._scopes
          : scopes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$OAuthConfigImpl extends _OAuthConfig {
  const _$OAuthConfigImpl(
      {this.id,
      this.flow = OAuthFlow.authorizationCode,
      this.clientId = '',
      this.clientSecret,
      this.authorizationEndpoint = '',
      this.tokenEndpoint = '',
      this.redirectUri = 'http://localhost:8080/callback',
      final List<String> scopes = const [],
      this.state,
      this.description,
      this.username,
      this.password})
      : _scopes = scopes,
        super._();

  factory _$OAuthConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$OAuthConfigImplFromJson(json);

  /// Unique identifier for this OAuth configuration
  @override
  final String? id;

  /// OAuth Flow type
  @override
  @JsonKey()
  final OAuthFlow flow;

  /// Client ID from OAuth provider
  @override
  @JsonKey()
  final String clientId;

  /// Client Secret from OAuth provider (optional for some flows)
  @override
  final String? clientSecret;

  /// Authorization endpoint URL
  @override
  @JsonKey()
  final String authorizationEndpoint;

  /// Token endpoint URL
  @override
  @JsonKey()
  final String tokenEndpoint;

  /// Redirect URI for OAuth callback
  @override
  @JsonKey()
  final String redirectUri;

  /// OAuth scopes
  final List<String> _scopes;

  /// OAuth scopes
  @override
  @JsonKey()
  List<String> get scopes {
    if (_scopes is EqualUnmodifiableListView) return _scopes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_scopes);
  }

  /// Optional state parameter for CSRF protection
  @override
  final String? state;

  /// Optional description for this OAuth configuration
  @override
  final String? description;

  /// Username for Resource Owner Password Grant flow
  @override
  final String? username;

  /// Password for Resource Owner Password Grant flow
  @override
  final String? password;

  @override
  String toString() {
    return 'OAuthConfig(id: $id, flow: $flow, clientId: $clientId, clientSecret: $clientSecret, authorizationEndpoint: $authorizationEndpoint, tokenEndpoint: $tokenEndpoint, redirectUri: $redirectUri, scopes: $scopes, state: $state, description: $description, username: $username, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OAuthConfigImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.flow, flow) || other.flow == flow) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.clientSecret, clientSecret) ||
                other.clientSecret == clientSecret) &&
            (identical(other.authorizationEndpoint, authorizationEndpoint) ||
                other.authorizationEndpoint == authorizationEndpoint) &&
            (identical(other.tokenEndpoint, tokenEndpoint) ||
                other.tokenEndpoint == tokenEndpoint) &&
            (identical(other.redirectUri, redirectUri) ||
                other.redirectUri == redirectUri) &&
            const DeepCollectionEquality().equals(other._scopes, _scopes) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      flow,
      clientId,
      clientSecret,
      authorizationEndpoint,
      tokenEndpoint,
      redirectUri,
      const DeepCollectionEquality().hash(_scopes),
      state,
      description,
      username,
      password);

  /// Create a copy of OAuthConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OAuthConfigImplCopyWith<_$OAuthConfigImpl> get copyWith =>
      __$$OAuthConfigImplCopyWithImpl<_$OAuthConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OAuthConfigImplToJson(
      this,
    );
  }
}

abstract class _OAuthConfig extends OAuthConfig {
  const factory _OAuthConfig(
      {final String? id,
      final OAuthFlow flow,
      final String clientId,
      final String? clientSecret,
      final String authorizationEndpoint,
      final String tokenEndpoint,
      final String redirectUri,
      final List<String> scopes,
      final String? state,
      final String? description,
      final String? username,
      final String? password}) = _$OAuthConfigImpl;
  const _OAuthConfig._() : super._();

  factory _OAuthConfig.fromJson(Map<String, dynamic> json) =
      _$OAuthConfigImpl.fromJson;

  /// Unique identifier for this OAuth configuration
  @override
  String? get id;

  /// OAuth Flow type
  @override
  OAuthFlow get flow;

  /// Client ID from OAuth provider
  @override
  String get clientId;

  /// Client Secret from OAuth provider (optional for some flows)
  @override
  String? get clientSecret;

  /// Authorization endpoint URL
  @override
  String get authorizationEndpoint;

  /// Token endpoint URL
  @override
  String get tokenEndpoint;

  /// Redirect URI for OAuth callback
  @override
  String get redirectUri;

  /// OAuth scopes
  @override
  List<String> get scopes;

  /// Optional state parameter for CSRF protection
  @override
  String? get state;

  /// Optional description for this OAuth configuration
  @override
  String? get description;

  /// Username for Resource Owner Password Grant flow
  @override
  String? get username;

  /// Password for Resource Owner Password Grant flow
  @override
  String? get password;

  /// Create a copy of OAuthConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OAuthConfigImplCopyWith<_$OAuthConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
