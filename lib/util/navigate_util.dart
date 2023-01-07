import 'package:url_launcher/url_launcher.dart';

/// @description : 导航
class Navigate{



  ///打开浏览器
  ///[url] 链接
  static Future<void> launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

}