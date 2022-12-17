import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScreenUtil {
  //修改状态栏颜色
  static removeSystemTransparent(BuildContext context) {
    /// android 平台
    if (Theme.of(context).platform == TargetPlatform.android) {
      SystemUiOverlayStyle style = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      );
      SystemChrome.setSystemUIOverlayStyle(style);
    }
  }
}
