import 'package:url_launcher/url_launcher.dart';

abstract class UrlHandler {
  void openUrl(String uri);
}

class UrlLauncher extends UrlHandler {
  @override
  void openUrl(String uri) {
    // This is a function from url_launcher: ^6.1.11
    // if we set "mode: LaunchMode.externalApplication" it cause that open uri in Chrome or Firefox ...
    launchUrl(Uri.parse(uri), mode: LaunchMode.externalApplication);
  }
}
