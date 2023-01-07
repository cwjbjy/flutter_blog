import 'package:flutter_blog/model/banner_mode.dart';
import 'package:flutter_blog/model/collect_model.dart';
import 'package:flutter_blog/model/project_model.dart';
import 'package:flutter_blog/model/web_model.dart';
import 'package:flutter_blog/routes/routes.dart';
import 'package:flutter_blog/util/save/sp_util.dart';
import 'package:get/get.dart';

/// @description :Web工具类
class WebUtil {
  ///普通页面进入Web页面1
  static toWebPage(ProjectDetail detail, {Function(bool)? onResult}) {
    Get.toNamed(Routes.webViewPage,
        arguments: WebEntity(
          title: detail.title,
          link: detail.link,
          id: detail.id,
          isCollect: detail.collect,
        ))?.then((value) async {
      if (value is bool && onResult != null) {
        onResult(value);
      }
    });

    ///存储浏览记录
    SpUtil.saveBrowseHistory(detail);
  }

  ///收藏页面进入Web页面2
  static Future<dynamic>? toWebPageCollect(CollectDetail detail) {
    return Get.toNamed(Routes.webViewPage,
        arguments: WebEntity(
          title: detail.title,
          link: detail.link,
          id: detail.id,
          originId: detail.originId,
          isCollect: true,
        ));
  }

  ///普通页面进入Web页面2
  static toWebPageBanners(Banners detail) {
    Get.toNamed(Routes.webViewPage,
        arguments: WebEntity(
          title: detail.title,
          link: detail.url,
          id: 0,
          isCollect: false,
        ));
  }

  ///其他页面进入Web页面2
  static toWebPageOther({String title = '', String link = ''}) {
    Get.toNamed(Routes.webViewPage,
        arguments: WebEntity(
          title: title,
          link: link,
          id: 0,
          isCollect: false,
        ));
  }
}
