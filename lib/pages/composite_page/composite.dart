import 'package:flutter/material.dart';
import 'package:flutter_blog/constants/r.dart';
import 'package:flutter_blog/i18/strings.dart';
import 'package:flutter_blog/routes/routes.dart';
import 'package:flutter_blog/style/colors.dart';
import 'package:flutter_blog/style/style.dart';
import 'package:flutter_blog/widget/keepAlive.dart';
import 'package:flutter_blog/widget/ripple_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'modules/ask_page/ask.dart';
import 'modules/main_page/main.dart';
import 'modules/square_page/square.dart';

class CompositePage extends StatefulWidget {
  const CompositePage({super.key});

  @override
  State<CompositePage> createState() => _CompositePageState();
}

class _CompositePageState extends State<CompositePage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    alignment: Alignment.topLeft,

                    ///导航栏
                    child: TabBar(
                      isScrollable: true,
                      labelColor: ColorStyle.color_24CF5F,
                      unselectedLabelColor: ColorStyle.color_B8C0D4,
                      controller: tabController,
                      labelStyle: Styles.style_FE8C28_24_bold,
                      unselectedLabelStyle: Styles.style_FFAE2E_16,
                      tabs: [
                        Tab(
                          text: StringStyles.tabHome.tr,
                        ),
                        Tab(
                          text: StringStyles.tabSquare.tr,
                        ),
                        Tab(
                          text: StringStyles.tabAsk.tr,
                        )
                      ],
                    ),
                  ),

                  ///间隔
                  const Expanded(child: SizedBox()),

                  ///搜索框
                  Ripple(
                      circular: 20,
                      onTap: () => Get.toNamed(Routes.searchPage),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: SvgPicture.asset(
                          R.assetsImagesSearch,
                          color: Colors.black87,
                          width: 30,
                        ),
                      )),

                  Box.hBox20
                ],
              ),
              Expanded(
                  child: TabBarView(
                controller: tabController,
                children: const [
                  KeepAliveWrapper(child: MainPage()),
                  KeepAliveWrapper(child: SquarePage()),
                  KeepAliveWrapper(child: AskPage())
                ],
              )),
            ],
          ),
        ));
  }
}
