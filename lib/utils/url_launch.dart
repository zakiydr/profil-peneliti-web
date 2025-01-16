import 'package:url_launcher/url_launcher.dart';

class UrlLaunch {
  Future<void> redirectUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      final bool launched = await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
        webViewConfiguration:
            const WebViewConfiguration(enableJavaScript: true),
      );

      if (!launched) {
        print('Could not launch $urlString');
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }
}
