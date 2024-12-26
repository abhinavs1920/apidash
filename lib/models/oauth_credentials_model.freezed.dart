// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'oauth_credentials_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OAuthCredentials _$OAuthCredentialsFromJson(Map<String, dynamic> json) {
  return _OAuthCredentials.fromJson(json);
}

/// @nodoc
mixin _$OAuthCredentials {
  /// The access token
  String get accessToken => throw _privateConstructorUsedError;

  /// Refresh token (if available)
  String? get refreshToken => throw _privateConstructorUsedError;

  /// ID token for OpenID Connect
  String? get idToken => throw _privateConstructorUsedError;

  /// Token endpoint URL
  Uri? get tokenEndpoint => throw _privateConstructorUsedError;

  /// Scopes associated with the token
  Iterable<String>? get scopes => throw _privateConstructorUsedError;

  /// Expiration time of the access token
  DateTime? get expiration => throw _privateConstructorUsedError;

  /// Delimiter for token scopes
  String? get delimiter => throw _privateConstructorUsedError;

  /// ID of the associated OAuth configuration
  String? get configId => throw _privateConstructorUsedError;

  /// Serializes this OAuthCredentials to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OAuthCredentials
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OAuthCredentialsCopyWith<OAuthCredentials> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OAuthCredentialsCopyWith<$Res> {
  factory $OAuthCredentialsCopyWith(
          OAuthCredentials value, $Res Function(OAuthCredentials) then) =
      _$OAuthCredentialsCopyWithImpl<$Res, OAuthCredentials>;
  @useResult
  $Res call(
      {String accessToken,
      String? refreshToken,
      String? idToken,
      Uri? tokenEndpoint,
      Iterable<String>? scopes,
      DateTime? expiration,
      String? delimiter,
      String? configId});
}

/// @nodoc
class _$OAuthCredentialsCopyWithImpl<$Res, $Val extends OAuthCredentials>
    implements $OAuthCredentialsCopyWith<$Res> {
  _$OAuthCredentialsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OAuthCredentials
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = freezed,
    Object? idToken = freezed,
    Object? tokenEndpoint = freezed,
    Object? scopes = freezed,
    Object? expiration = freezed,
    Object? delimiter = freezed,
    Object? configId = freezed,
  }) {
    return _then(_value.copyWith(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      idToken: freezed == idToken
          ? _value.idToken
          : idToken // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenEndpoint: freezed == tokenEndpoint
          ? _value.tokenEndpoint
          : tokenEndpoint // ignore: cast_nullable_to_non_nullable
              as Uri?,
      scopes: freezed == scopes
          ? _value.scopes
          : scopes // ignore: cast_nullable_to_non_nullable
              as Iterable<String>?,
      expiration: freezed == expiration
          ? _value.expiration
          : expiration // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      delimiter: freezed == delimiter
          ? _value.delimiter
          : delimiter // ignore: cast_nullable_to_non_nullable
              as String?,
      configId: freezed == configId
          ? _value.configId
          : configId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OAuthCredentialsImplCopyWith<$Res>
    implements $OAuthCredentialsCopyWith<$Res> {
  factory _$$OAuthCredentialsImplCopyWith(_$OAuthCredentialsImpl value,
          $Res Function(_$OAuthCredentialsImpl) then) =
      __$$OAuthCredentialsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String accessToken,
      String? refreshToken,
      String? idToken,
      Uri? tokenEndpoint,
      Iterable<String>? scopes,
      DateTime? expiration,
      String? delimiter,
      String? configId});
}

/// @nodoc
class __$$OAuthCredentialsImplCopyWithImpl<$Res>
    extends _$OAuthCredentialsCopyWithImpl<$Res, _$OAuthCredentialsImpl>
    implements _$$OAuthCredentialsImplCopyWith<$Res> {
  __$$OAuthCredentialsImplCopyWithImpl(_$OAuthCredentialsImpl _value,
      $Res Function(_$OAuthCredentialsImpl) _then)
      : super(_value, _then);

  /// Create a copy of OAuthCredentials
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = freezed,
    Object? idToken = freezed,
    Object? tokenEndpoint = freezed,
    Object? scopes = freezed,
    Object? expiration = freezed,
    Object? delimiter = freezed,
    Object? configId = freezed,
  }) {
    return _then(_$OAuthCredentialsImpl(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      idToken: freezed == idToken
          ? _value.idToken
          : idToken // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenEndpoint: freezed == tokenEndpoint
          ? _value.tokenEndpoint
          : tokenEndpoint // ignore: cast_nullable_to_non_nullable
              as Uri?,
      scopes: freezed == scopes
          ? _value.scopes
          : scopes // ignore: cast_nullable_to_non_nullable
              as Iterable<String>?,
      expiration: freezed == expiration
          ? _value.expiration
          : expiration // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      delimiter: freezed == delimiter
          ? _value.delimiter
          : delimiter // ignore: cast_nullable_to_non_nullable
              as String?,
      configId: freezed == configId
          ? _value.configId
          : configId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$OAuthCredentialsImpl extends _OAuthCredentials {
  const _$OAuthCredentialsImpl(
      {required this.accessToken,
      this.refreshToken,
      this.idToken,
      this.tokenEndpoint,
      this.scopes,
      this.expiration,
      this.delimiter,
      this.configId})
      : super._();

  factory _$OAuthCredentialsImpl.fromJson(Map<String, dynamic> json) =>
      _$$OAuthCredentialsImplFromJson(json);

  /// The access token
  @override
  final String accessToken;

  /// Refresh token (if available)
  @override
  final String? refreshToken;

  /// ID token for OpenID Connect
  @override
  final String? idToken;

  /// Token endpoint URL
  @override
  final Uri? tokenEndpoint;

  /// Scopes associated with the token
  @override
  final Iterable<String>? scopes;

  /// Expiration time of the access token
  @override
  final DateTime? expiration;

  /// Delimiter for token scopes
  @override
  final String? delimiter;

  /// ID of the associated OAuth configuration
  @override
  final String? configId;

  @override
  String toString() {
    return 'OAuthCredentials(accessToken: $accessToken, refreshToken: $refreshToken, idToken: $idToken, tokenEndpoint: $tokenEndpoint, scopes: $scopes, expiration: $expiration, delimiter: $delimiter, configId: $configId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OAuthCredentialsImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.idToken, idToken) || other.idToken == idToken) &&
            (identical(other.tokenEndpoint, tokenEndpoint) ||
                other.tokenEndpoint == tokenEndpoint) &&
            const DeepCollectionEquality().equals(other.scopes, scopes) &&
            (identical(other.expiration, expiration) ||
                other.expiration == expiration) &&
            (identical(other.delimiter, delimiter) ||
                other.delimiter == delimiter) &&
            (identical(other.configId, configId) ||
                other.configId == configId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      accessToken,
      refreshToken,
      idToken,
      tokenEndpoint,
      const DeepCollectionEquality().hash(scopes),
      expiration,
      delimiter,
      configId);

  /// Create a copy of OAuthCredentials
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OAuthCredentialsImplCopyWith<_$OAuthCredentialsImpl> get copyWith =>
      __$$OAuthCredentialsImplCopyWithImpl<_$OAuthCredentialsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OAuthCredentialsImplToJson(
      this,
    );
  }
}

abstract class _OAuthCredentials extends OAuthCredentials {
  const factory _OAuthCredentials(
      {required final String accessToken,
      final String? refreshToken,
      final String? idToken,
      final Uri? tokenEndpoint,
      final Iterable<String>? scopes,
      final DateTime? expiration,
      final String? delimiter,
      final String? configId}) = _$OAuthCredentialsImpl;
  const _OAuthCredentials._() : super._();

  factory _OAuthCredentials.fromJson(Map<String, dynamic> json) =
      _$OAuthCredentialsImpl.fromJson;

  /// The access token
  @override
  String get accessToken;

  /// Refresh token (if available)
  @override
  String? get refreshToken;

  /// ID token for OpenID Connect
  @override
  String? get idToken;

  /// Token endpoint URL
  @override
  Uri? get tokenEndpoint;

  /// Scopes associated with the token
  @override
  Iterable<String>? get scopes;

  /// Expiration time of the access token
  @override
  DateTime? get expiration;

  /// Delimiter for token scopes
  @override
  String? get delimiter;

  /// ID of the associated OAuth configuration
  @override
  String? get configId;

  /// Create a copy of OAuthCredentials
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OAuthCredentialsImplCopyWith<_$OAuthCredentialsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
