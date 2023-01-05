import 'package:flutter/material.dart';
import 'package:flutter_blog/i18/strings.dart';
import 'package:flutter_blog/pages/composite_page/composite.dart';
import 'package:flutter_blog/pages/my_page/my.dart';
import 'package:flutter_blog/pages/project_page/project.dart';
import 'package:flutter_blog/style/colors.dart';
import 'package:flutter_blog/style/shadow_style.dart';
import 'package:get/get.dart';

import 'widget/home_tab_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);

    tabController.addListener(() {
      //监听Tab切换事件
      debugPrint(tabController.index.toString());
    });
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.color_F8F9FC,
      body: TabBarView(
        controller: tabController,
        children: const [CompositePage(), ProjectPage(), MyPage()],
      ),
      bottomNavigationBar: Container(
        height: 65,
        decoration: ShadowStyle.white12TopSpread4Blur10(radius: 0),
        child: TabBar(
          indicator: const BoxDecoration(),
          labelColor: ColorStyle.color_24CF5F,
          unselectedLabelColor: ColorStyle.color_B8C0D4,
          controller: tabController,
          tabs: [
            TabTitleIcon(
              title: StringStyles.homeComplex.tr,
              icon: Icons.turned_in,
            ),
            TabTitleIcon(
              title: StringStyles.homeProject.tr,
              icon: Icons.send,
            ),
            TabTitleIcon(
              title: StringStyles.homeMy.tr,
              icon: Icons.person,
            ),
          ],
        ),
      ),
    );
  }
}
