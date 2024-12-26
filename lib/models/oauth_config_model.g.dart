// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oauth_config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OAuthConfigImpl _$$OAuthConfigImplFromJson(Map<String, dynamic> json) =>
    _$OAuthConfigImpl(
      id: json['id'] as String?,
      flow: $enumDecodeNullable(_$OAuthFlowEnumMap, json['flow']) ??
          OAuthFlow.authorizationCode,
      clientId: json['clientId'] as String? ?? '',
      clientSecret: json['clientSecret'] as String?,
      authorizationEndpoint: json['authorizationEndpoint'] as String? ?? '',
      tokenEndpoint: json['tokenEndpoint'] as String? ?? '',
      redirectUri:
          json['redirectUri'] as String? ?? 'http://localhost:8080/callback',
      scopes: (json['scopes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      state: json['state'] as String?,
      description: json['description'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$$OAuthConfigImplToJson(_$OAuthConfigImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'flow': _$OAuthFlowEnumMap[instance.flow]!,
      'clientId': instance.clientId,
      'clientSecret': instance.clientSecret,
      'authorizationEndpoint': instance.authorizationEndpoint,
      'tokenEndpoint': instance.tokenEndpoint,
      'redirectUri': instance.redirectUri,
      'scopes': instance.scopes,
      'state': instance.state,
      'description': instance.description,
      'username': instance.username,
      'password': instance.password,
    };

const _$OAuthFlowEnumMap = {
  OAuthFlow.clientCredentials: 'clientCredentials',
  OAuthFlow.authorizationCode: 'authorizationCode',
  OAuthFlow.resourceOwnerPassword: 'resourceOwnerPassword',
};
