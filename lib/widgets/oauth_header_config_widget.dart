import 'package:apidash/providers/oauth2/oauth_config_provider.dart';
import 'package:apidash/widgets/oauth_token_acquisition_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/oauth_config_model.dart';
import '../models/oauth_credentials_model.dart';

class OAuthHeaderConfigWidget extends ConsumerStatefulWidget {
  final void Function(Map<String, String> headers) onHeadersUpdated;
  final Map<String, String>? initialHeaders;
  const OAuthHeaderConfigWidget({
    super.key,
    required this.onHeadersUpdated,
    this.initialHeaders,
  });
  @override
  ConsumerState<OAuthHeaderConfigWidget> createState() => _OAuthHeaderConfigWidgetState();
}

class _OAuthHeaderConfigWidgetState extends ConsumerState<OAuthHeaderConfigWidget> {
  OAuthConfig? _selectedConfig;
  String _authorizationHeaderType = 'Bearer';
  final TextEditingController _customHeaderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _parseInitialHeaders();
  }

  void _parseInitialHeaders() {
    final authHeader = widget.initialHeaders?.entries.firstWhere(
      (entry) => entry.key.toLowerCase() == 'authorization',
      orElse: () => const MapEntry('', ''),
    );
    
    if (authHeader?.key.isNotEmpty == true) {
      final parts = authHeader!.value.split(' ');
      if (parts.length == 2) {
        setState(() {
          _authorizationHeaderType = parts[0];
          _customHeaderController.text = parts[1];
        });
      }
    }
  }

  Future<void> _showOAuthConfigDialog() async {
    final result = await showDialog<OAuthConfig>(
      context: context,
      builder: (context) => const OAuthConfigListDialog(),
    );
    if (result != null) {
      setState(() => _selectedConfig = result);
    }
  }

  Future<void> _acquireOAuthToken() async {
    if (_selectedConfig == null) return;
    final result = await showDialog<OAuthCredentials>(
      context: context,
      builder: (context) => OAuthTokenAcquisitionDialog(initialConfig: _selectedConfig),
    );
    
    if (result != null) {
      setState(() => _customHeaderController.text = result.accessToken!);
      _updateHeaders();
    }
  }

  void _updateHeaders() {
    final headers = Map<String, String>.from(widget.initialHeaders ?? {});
    
    _customHeaderController.text.isEmpty
      ? headers.remove('Authorization')
      : headers['Authorization'] = '$_authorizationHeaderType ${_customHeaderController.text}';
    
    widget.onHeadersUpdated(headers);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _authorizationHeaderType,
                decoration: const InputDecoration(
                  labelText: 'Authorization Type',
                  border: OutlineInputBorder(),
                ),
                items: ['Bearer', 'Basic', 'OAuth', 'Custom']
                  .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                  .toList(),
                onChanged: (value) {
                  setState(() => _authorizationHeaderType = value ?? 'Bearer');
                  _updateHeaders();
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.vpn_key),
              tooltip: 'Select OAuth Configuration',
              onPressed: _showOAuthConfigDialog,
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _customHeaderController,
          decoration: InputDecoration(
            labelText: 'Token',
            border: const OutlineInputBorder(),
            suffixIcon: _selectedConfig != null
              ? IconButton(
                  icon: const Icon(Icons.refresh),
                  tooltip: 'Acquire New Token',
                  onPressed: _acquireOAuthToken,
                )
              : null,
          ),
          onChanged: (_) => _updateHeaders(),
        ),
        if (_selectedConfig != null) ...[
          const SizedBox(height: 8),
          Text(
            'OAuth Config: ${_selectedConfig!.name ?? _selectedConfig!.clientId}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ],
    );
  }

  @override
  void dispose() {
    _customHeaderController.dispose();
    super.dispose();
  }
}

class OAuthConfigListDialog extends ConsumerWidget {
  const OAuthConfigListDialog({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configs = ref.watch(oauthConfigProvider);
    return AlertDialog(
      title: const Text('Select OAuth Configuration'),
      content: configs.isEmpty
        ? const Text('No OAuth configurations found')
        : SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: configs
                .map((config) => ListTile(
                      title: Text(config.name ?? config.clientId),
                      subtitle: Text(config.flow.name),
                      onTap: () => Navigator.of(context).pop(config),
                    ))
                .toList(),
            ),
          ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}