import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/oauth_config_model.dart';
import '../providers/oauth_config_provider.dart';
import 'oauth_config_screen.dart';

class OAuthConfigListScreen extends ConsumerWidget {
  const OAuthConfigListScreen({super.key});

  void _showConfigDetails(BuildContext context, OAuthConfig config) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => OAuthConfigScreen(initialConfig: config),
      ),
    );
  }

  void _addNewConfig(BuildContext context, WidgetRef ref) async {
    final result = await Navigator.of(context).push<OAuthConfig>(
      MaterialPageRoute(
        builder: (context) => const OAuthConfigScreen(),
      ),
    );

    if (result != null) {
      ref.read(oauthConfigProvider.notifier).addConfig(result);
    }
  }

  void _editConfig(BuildContext context, WidgetRef ref, OAuthConfig config) async {
    final result = await Navigator.of(context).push<OAuthConfig>(
      MaterialPageRoute(
        builder: (context) => OAuthConfigScreen(initialConfig: config),
      ),
    );

    if (result != null) {
      ref.read(oauthConfigProvider.notifier).updateConfig(result);
    }
  }

  void _deleteConfig(BuildContext context, WidgetRef ref, OAuthConfig config) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Configuration'),
        content: Text('Are you sure you want to delete the OAuth configuration for "${config.description ?? config.clientId}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(oauthConfigProvider.notifier).removeConfig(config.id!);
              Navigator.of(context).pop(true);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configs = ref.watch(oauthConfigProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('OAuth Configurations'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _addNewConfig(context, ref),
          ),
        ],
      ),
      body: configs.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.vpn_key_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No OAuth Configurations',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _addNewConfig(context, ref),
                    child: const Text('Add Configuration'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: configs.length,
              itemBuilder: (context, index) {
                final config = configs[index];
                String flowName = '';
                switch (config.flow) {
                  case OAuthFlow.authorizationCode:
                    flowName = 'Authorization Code';
                    break;
                  case OAuthFlow.clientCredentials:
                    flowName = 'Client Credentials';
                    break;
                  case OAuthFlow.resourceOwnerPassword:
                    flowName = 'Resource Owner Password';
                    break;
                  default:
                    flowName = 'Unknown';
                }
                return ListTile(
                  title: Text(config.description ?? config.clientId),
                  subtitle: Text(flowName),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _editConfig(context, ref, config),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteConfig(context, ref, config),
                      ),
                    ],
                  ),
                  onTap: () => _showConfigDetails(context, config),
                );
              },
            ),
    );
  }
}
