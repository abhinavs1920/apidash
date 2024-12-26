// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oauth_credentials_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OAuthCredentialsImpl _$$OAuthCredentialsImplFromJson(
        Map<String, dynamic> json) =>
    _$OAuthCredentialsImpl(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String?,
      idToken: json['idToken'] as String?,
      tokenEndpoint: json['tokenEndpoint'] == null
          ? null
          : Uri.parse(json['tokenEndpoint'] as String),
      scopes: (json['scopes'] as List<dynamic>?)?.map((e) => e as String),
      expiration: json['expiration'] == null
          ? null
          : DateTime.parse(json['expiration'] as String),
      delimiter: json['delimiter'] as String?,
      configId: json['configId'] as String?,
    );

Map<String, dynamic> _$$OAuthCredentialsImplToJson(
        _$OAuthCredentialsImpl instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'idToken': instance.idToken,
      'tokenEndpoint': instance.tokenEndpoint?.toString(),
      'scopes': instance.scopes?.toList(),
      'expiration': instance.expiration?.toIso8601String(),
      'delimiter': instance.delimiter,
      'configId': instance.configId,
    };
