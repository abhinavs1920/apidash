import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../models/oauth_config_model.dart';

class OAuthConfigNotifier extends StateNotifier<List<OAuthConfig>> {
  OAuthConfigNotifier() : super([]) {
    print('[OAuth Config] Initializing OAuthConfigNotifier');
  }

  void addConfig(OAuthConfig config) {
    print('\n[OAuth Config] Adding new OAuth configuration');
    // Assign a unique ID if not provided
    final configToAdd = config.id == null 
        ? config.copyWith(id: const Uuid().v4()) 
        : config;
    
    print('[OAuth Config] Config details:');
    print('[OAuth Config] ID: ${configToAdd.id}');
    print('[OAuth Config] Flow: ${configToAdd.flow}');
    print('[OAuth Config] Auth Endpoint: ${configToAdd.authorizationEndpoint}');
    print('[OAuth Config] Token Endpoint: ${configToAdd.tokenEndpoint}');
    print('[OAuth Config] Scopes: ${configToAdd.scopes}');
    
    state = [...state, configToAdd];
    print('[OAuth Config] Configuration added successfully');
  }

  void updateConfig(OAuthConfig config) {
    print('\n[OAuth Config] Updating OAuth configuration');
    print('[OAuth Config] Config ID: ${config.id}');
    print('[OAuth Config] Updated details:');
    print('[OAuth Config] Flow: ${config.flow}');
    print('[OAuth Config] Auth Endpoint: ${config.authorizationEndpoint}');
    print('[OAuth Config] Token Endpoint: ${config.tokenEndpoint}');
    print('[OAuth Config] Scopes: ${config.scopes}');

    state = [
      for (final existingConfig in state)
        if (existingConfig.id == config.id) config
        else existingConfig
    ];
    print('[OAuth Config] Configuration updated successfully');
  }

  void removeConfig(String configId) {
    print('\n[OAuth Config] Removing OAuth configuration');
    print('[OAuth Config] Config ID to remove: $configId');
    
    final initialLength = state.length;
    state = state.where((config) => config.id != configId).toList();
    
    if (state.length < initialLength) {
      print('[OAuth Config] Configuration removed successfully');
    } else {
      print('[OAuth Config] Configuration not found for removal');
    }
  }

  OAuthConfig? getConfigById(String configId) {
    print('\n[OAuth Config] Getting OAuth configuration by ID: $configId');
    try {
      final config = state.firstWhere(
        (config) => config.id == configId,
        orElse: () => throw StateError('No config found with ID: $configId'),
      );
      print('[OAuth Config] Configuration found:');
      print('[OAuth Config] Flow: ${config.flow}');
      return config;
    } catch (e) {
      print('[OAuth Config] Error getting configuration: $e');
      rethrow;
    }
  }
}

final oauthConfigProvider = StateNotifierProvider<OAuthConfigNotifier, List<OAuthConfig>>((ref) {
  print('[OAuth Config] Creating new OAuthConfigNotifier instance');
  return OAuthConfigNotifier();
});
