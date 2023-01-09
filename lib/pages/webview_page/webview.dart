import 'package:flutter/material.dart';
import 'package:flutter_blog/constants/r.dart';
import 'package:flutter_blog/model/web_model.dart';
import 'package:flutter_blog/style/colors.dart';
import 'package:flutter_blog/widget/toolbar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';

/// @description :WebView View层

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  ///进度条
  double progress = 0.0;

  ///是否点赞
  bool isCollect = false;

  ///加载URL
  WebEntity detail = Get.arguments;

  @override
  Widget build(BuildContext context) {
    debugPrint('detail--link----${detail.link}');
    return GetPlatform.isWindows
        ? const Text('暂不支持web打开，请在APP中打开')
        : WillPopScope(
            onWillPop: () async {
              /// 拦截用户返回，返回时携带参数
              Get.back(result: isCollect);
              return true;
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  Stack(
                    children: [
                      ToolBar(
                        backColor: ColorStyle.color_474747,
                        backOnTap: () => Get.back(result: isCollect),
                        title: detail.title,
                      ),
                      Positioned(
                        right: 20,
                        bottom: 11,
                        width: 24,
                        height: 24,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            splashColor: ColorStyle.color_E2E3E8_66,
                            onTap: () {
                              Share.share(detail.title + detail.link);
                            },
                            child: SvgPicture.asset(
                              R.assetsImagesShare,
                              width: 16,
                              height: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        WebView(
                          initialUrl: detail.link,
                          javascriptMode: JavascriptMode.unrestricted,
                          onProgress: (pro) {
                            progress = (pro / 100).toDouble();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }
}
