import 'package:flutter_blog/pages/search_page/search.dart';
import 'package:flutter_blog/pages/webview_page/webview.dart';
import 'package:get/get.dart';
import 'package:flutter_blog/pages/register_page/register.dart';
import 'package:flutter_blog/pages/home_page/home.dart';
import 'package:flutter_blog/pages/login_page/login.dart';
import 'package:flutter_blog/pages/splash_page/splash.dart';

abstract class Routes {
  ///入口模块
  static const String splashPage = '/splash';

  ///登录模块
  static const String loginPage = '/login';

  ///注册
  static const String registerPage = '/register';

  ///主页
  static const String homePage = '/home';

  ///搜索页面
  static const String searchPage = '/search';

    ///积分排行榜
  static const String rankingPage = '/ranking';

  ///webView
  static const String webViewPage = '/webView';

  static final routePage = [
    GetPage(
      name: splashPage,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: loginPage,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: registerPage,
      page: () => const RegisterPage(),
    ),
    GetPage(
      name: homePage,
      page: () => const HomePage(),
    ),
    GetPage(
      name: searchPage,
      page: () => const SearchPage(),
    ),
    GetPage(
        name: webViewPage,
        page: () => const WebViewPage()),
  ];
}
