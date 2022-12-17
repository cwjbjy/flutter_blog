import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants/strings.dart';
import 'routes/routes.dart';
import 'util/screen_util.dart';
import 'util/injection_init.dart';
import 'util/locale_util.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //有异步操作，调用ensureInitialized以确保拥有WidgetsBinding
  await Injection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.removeSystemTransparent(context); //修改系统状态栏颜色
    return GetMaterialApp(
      getPages: Routes.routePage,
      initialRoute: Routes.splashPage,
      debugShowCheckedModeBanner: false,

      //国际化支持-来源配置
      translations: Messages(),

      //国际化支持-默认语言
      locale: LocaleOptions.getDefault(),

      //国际化支持-备用语言
      fallbackLocale: const Locale('en', 'US'),

      defaultTransition: Transition.fade,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
