import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/oauth_config_model.dart';

class OAuthConfigScreen extends ConsumerStatefulWidget {
  final OAuthConfig? initialConfig;

  const OAuthConfigScreen({
    super.key, 
    this.initialConfig,
  });

  @override
  ConsumerState<OAuthConfigScreen> createState() => _OAuthConfigScreenState();
}

class _OAuthConfigScreenState extends ConsumerState<OAuthConfigScreen> {
  late TextEditingController _idController;
  late TextEditingController _clientIdController;
  late TextEditingController _clientSecretController;
  late TextEditingController _authEndpointController;
  late TextEditingController _tokenEndpointController;
  late TextEditingController _redirectUriController;
  late TextEditingController _scopesController;
  late TextEditingController _descriptionController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  OAuthFlow _selectedFlow = OAuthFlow.authorizationCode;

  @override
  void initState() {
    super.initState();
    final config = widget.initialConfig;

    print('Initializing controllers...');
    print('Username: ${config?.username}');
    print('Password: ${config?.password}');

    // Initialize all controllers with fallback values
    _idController = TextEditingController(text: config?.id ?? '');
    _clientIdController = TextEditingController(text: config?.clientId ?? '');
    _clientSecretController = TextEditingController(text: config?.clientSecret ?? '');
    _authEndpointController = TextEditingController(text: config?.authorizationEndpoint ?? '');
    _tokenEndpointController = TextEditingController(text: config?.tokenEndpoint ?? '');
    _redirectUriController = TextEditingController(text: config?.redirectUri ?? '');
    _scopesController = TextEditingController(text: config?.scopes?.join(', ') ?? '');
    _descriptionController = TextEditingController(text: config?.description ?? '');
    _usernameController = TextEditingController(text: config?.username ?? '');
    _passwordController = TextEditingController(text: config?.password ?? '');

    if (config != null) {
      _selectedFlow = config.flow;
    }
  }

  @override
  void dispose() {
    _idController.dispose();
    _clientIdController.dispose();
    _clientSecretController.dispose();
    _authEndpointController.dispose();
    _tokenEndpointController.dispose();
    _redirectUriController.dispose();
    _scopesController.dispose();
    _descriptionController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  OAuthConfig _buildOAuthConfig() {
    return OAuthConfig(
      id: _idController.text.isNotEmpty ? _idController.text : null,
      flow: _selectedFlow,
      clientId: _clientIdController.text,
      clientSecret: _clientSecretController.text.isNotEmpty 
          ? _clientSecretController.text 
          : null,
      authorizationEndpoint: _authEndpointController.text,
      tokenEndpoint: _tokenEndpointController.text,
      redirectUri: _redirectUriController.text,
      scopes: _scopesController.text.split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList(),
      description: _descriptionController.text.isNotEmpty 
          ? _descriptionController.text 
          : null,
      username: _usernameController.text.isNotEmpty 
          ? _usernameController.text 
          : null,
      password: _passwordController.text.isNotEmpty 
          ? _passwordController.text 
          : null,
    );
  }

  void _saveConfiguration() {
    final config = _buildOAuthConfig();
    Navigator.of(context).pop(config);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.initialConfig == null 
            ? 'Add OAuth Configuration' 
            : 'Edit OAuth Configuration'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<OAuthFlow>(
              value: _selectedFlow,
              decoration: const InputDecoration(
                labelText: 'OAuth Flow',
                border: OutlineInputBorder(),
              ),
              items: OAuthFlow.values
                  .map((flow) => DropdownMenuItem(
                        value: flow,
                        child: Text(flow.name.replaceAll(RegExp(r'(?<!^)(?=[A-Z])'), ' ')),
                      ))
                  .toList(),
              onChanged: (flow) {
                if (flow != null) {
                  setState(() {
                    _selectedFlow = flow;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _clientIdController,
              decoration: const InputDecoration(
                labelText: 'Client ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _clientSecretController,
              decoration: const InputDecoration(
                labelText: 'Client Secret',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _authEndpointController,
              decoration: const InputDecoration(
                labelText: 'Authorization Endpoint',
                border: OutlineInputBorder(),
                hintText: 'https://example.com/oauth/authorize',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _tokenEndpointController,
              decoration: const InputDecoration(
                labelText: 'Token Endpoint',
                border: OutlineInputBorder(),
                hintText: 'https://example.com/oauth/token',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _redirectUriController,
              decoration: const InputDecoration(
                labelText: 'Redirect URI',
                border: OutlineInputBorder(),
                hintText: 'http://localhost:8080/callback',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _scopesController,
              decoration: const InputDecoration(
                labelText: 'Scopes',
                border: OutlineInputBorder(),
                hintText: 'Comma-separated list of scopes',
              ),
            ),
            _selectedFlow == OAuthFlow.resourceOwnerPassword
                ? Column(
                    children: [
                      const SizedBox(height: 16),
                      TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                      ),
                    ],
                  )
                : const SizedBox(),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
                hintText: 'Optional description for this configuration',
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveConfiguration,
              child: const Text('Save Configuration'),
            ),
          ],
        ),
      ),
    );
  }
}
