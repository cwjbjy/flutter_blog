import 'package:flutter_blog/pages/login_page/login.dart';
import 'package:get/get.dart';
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

  static final routePage = [
    GetPage(
      name: splashPage,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: loginPage,
      page: () => const LoginPage(),
    ),
  ];
}
