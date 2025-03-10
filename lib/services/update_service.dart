import 'dart:io';

import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateService {
  static const String _githubApiUrl = 'https://api.github.com/repos/foss42/apidash/releases/latest';
  static const String _skipVersionKey = 'skipped_version';
  
  Future<Map<String, dynamic>?> checkForUpdate() async {
    try {
      // Get current app version
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;
      
      // Fetch latest release from GitHub using Dio
      final dio = Dio();
      dio.options.headers['User-Agent'] = 'APIDash';
      final response = await dio.get(_githubApiUrl);
      print(response.statusCode);
      
      if (response.statusCode == 200) {
        final data = response.data;
        print(data['tag_name'].toString());
        final latestVersion = data['tag_name'].toString().replaceAll('v', '');
        
        // Detailed version comparison logging
        final isUpdateAvailable = _shouldUpdate(currentVersion, latestVersion);
        
        if (isUpdateAvailable) {
          return {
            'currentVersion': currentVersion,
            'latestVersion': latestVersion,
            'assets': data['assets'],
            'releaseNotes': data['body'] ?? 'No release notes available.',
          };
        } 
      } 
      return null;
    } catch (e) {
      return null;
    }
  }

  bool _shouldUpdate(String currentVersion, String latestVersion) {

    // Detailed version comparison
    final current = currentVersion.split('.').map(int.parse).toList();
    final latest = latestVersion.split('.').map(int.parse).toList();
    
    // Compare each part of the version
    for (var i = 0; i < current.length; i++) {
      if (latest[i] > current[i]) {
        return true;
      }
      if (latest[i] < current[i]) {
        return false;
      }
    }
  
    return false;
  }

  Future<void> skipVersion(String version) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_skipVersionKey, version);
  }

  Future<void> downloadAndInstallUpdate(String downloadUrl) async {
    if (Platform.isWindows) {
      final uri = Uri.parse(downloadUrl);
      await launchUrl(uri);
    } else if (Platform.isLinux) {
      final uri = Uri.parse(downloadUrl);
      await launchUrl(uri);
    } else if (Platform.isMacOS) {
      final uri = Uri.parse(downloadUrl);
      await launchUrl(uri);
    }
  }
}
