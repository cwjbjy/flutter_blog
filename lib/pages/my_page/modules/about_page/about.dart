import 'package:flutter/material.dart';
import 'package:flutter_blog/app/package_info.dart';
import 'package:flutter_blog/constants/constant.dart';
import 'package:flutter_blog/constants/r.dart';
import 'package:flutter_blog/i18/strings.dart';
import 'package:flutter_blog/style/style.dart';
import 'package:flutter_blog/util/web_util.dart';
import 'package:flutter_blog/widget/toolbar.dart';
import 'package:get/get.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        child: Column(
          children: [
            ToolBar(
              title: StringStyles.aboutTitle.tr,
            ),
            Box.vBox30,
            Image.asset(
              R.assetsImagesApplication,
              width: 120,
            ),
            Box.vBox12,
            Text(
              StringStyles.appName.tr,
              style: Styles.style_black_30,
            ),
            Box.vBox5,
            Text(
              '${StringStyles.aboutVersion.tr}${PackageInfo.versionName}',
              style: Styles.style_black_12,
            ),
            Box.vBox5,
            Text(
              '${StringStyles.aboutBuild.tr}${PackageInfo.versionCode}',
              style: Styles.style_black_12,
            ),
            Box.vBox30,
            ListTile(
              title: Text(StringStyles.aboutGithub.tr),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () => WebUtil.toWebPageOther(
                title: StringStyles.aboutGithub.tr,
                link: Constant.githubLike,
              ),
            ),
            DividerStyle.divider1HalfPadding20,
            ListTile(
              title: Text(StringStyles.aboutJueJin.tr),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () => WebUtil.toWebPageOther(
                title: StringStyles.aboutJueJin.tr,
                link: Constant.juejinLike,
              ),
            ),
            DividerStyle.divider1HalfPadding20,
            ListTile(
              title: Text(StringStyles.aboutSupport.tr),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () => WebUtil.toWebPageOther(
                title: StringStyles.aboutSupport.tr,
                link: Constant.wanAndroidLike,
              ),
            ),
            DividerStyle.divider1HalfPadding20,
            const Expanded(
              child: Text(''),
            ),
          ],
        ),
      ),
    );
  }
}
