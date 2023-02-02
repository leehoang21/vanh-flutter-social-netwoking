import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/web_view/web_view.dart';
import 'package:finplus/routes/finplus_routes.dart';
import 'package:finplus/utils/app_logger.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LaunchUrl {
  static Future<void> launch(String url) async {
    if (await canLaunchUrlString(url)) {
      if (url.startsWith('http') || url.startsWith('https')) {
        Get.toNamed(
          Routes.web_view,
          arguments: WebViewArgument(
            url: url,
          ),
        );
      } else {
        await launchUrlString(url);
      }
    } else {
      logD('Can\'t launch url');
    }
  }
}
