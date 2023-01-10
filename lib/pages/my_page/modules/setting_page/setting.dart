import 'package:flutter/material.dart';
import 'package:flutter_blog/http/repository.dart';
import 'package:flutter_blog/i18/strings.dart';
import 'package:flutter_blog/routes/routes.dart';
import 'package:flutter_blog/style/style.dart';
import 'package:flutter_blog/util/file/cache_util.dart';
import 'package:flutter_blog/util/save/sp_util.dart';
import 'package:flutter_blog/util/toast_util.dart';
import 'package:flutter_blog/widget/toolbar.dart';
import 'package:get/get.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String cache = '';

  @override
  void initState() {
    super.initState();
    loadCache();
  }

  ///加载缓存
  loadCache() {
    CacheUtil.loadCache().then((value) {
      setState(() {
        cache = CacheUtil.byte2FitMemorySize(value);
      });
    });
  }

  ///清除缓存
  clearCacheFile() {
    CacheUtil.clearCache().then((value) {
      loadCache();
      ToastUtils.show(value
          ? StringStyles.settingCacheSuccess.tr
          : StringStyles.settingCacheFail.tr);
    });
  }

  ///退出登录
  exitLoginState() {
    SpUtil.deleteUserInfo();
    RequestRepository.exitLogin();
    Get.offAllNamed(Routes.loginPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          ToolBar(
            title: StringStyles.settingTitle.tr,
          ),
          DividerStyle.divider1Half,
          ListTile(
            onTap: () => Get.toNamed(Routes.settingLanguagePage),
            title: Text(StringStyles.settingLanguage.tr),
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
          ListTile(
            onTap: () => clearCacheFile(),
            title: Text(StringStyles.settingCache.tr),
            trailing: Text(
              cache,
              style: Styles.style_6A6969_14,
            ),
          ),
          DividerStyle.divider20Half,
          ListTile(
            onTap: () => exitLoginState(),
            title: Container(
              alignment: Alignment.center,
              child: Text(StringStyles.settingExitLogin.tr),
            ),
          ),
        ],
      ),
    );
  }
}
