import 'package:flutter/material.dart';
import 'package:flutter_blog/routes/routes.dart';
import 'package:flutter_blog/util/save/sp_util.dart';
import 'package:flutter_blog/constants/r.dart';
import 'package:flutter_blog/i18/strings.dart';
import 'package:flutter_blog/style/style.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double opacityLevel = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        opacityLevel = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //预缓存背景图片
    precacheImage(const AssetImage(R.assetsImagesLoginBackground), context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: AnimatedOpacity(
          onEnd: () {
            Get.offNamed(SpUtil.getUserInfo() == null
                ? Routes.loginPage
                : Routes.homePage);
          },
          duration: const Duration(milliseconds: 2000),
          opacity: opacityLevel,
          child: Container(
            margin: const EdgeInsets.only(top: 120),
            alignment: Alignment.center,
            child: Column(
              children: [
                Image.asset(
                  R.assetsImagesApplication,
                  fit: BoxFit.fitWidth,
                  width: 110,
                  height: 110,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: Text(
                    StringStyles.appName.tr,
                    style: Styles.style_black_36,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
