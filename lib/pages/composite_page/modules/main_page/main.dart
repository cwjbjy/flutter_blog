import 'package:flutter/material.dart';
import 'package:flutter_blog/constants/r.dart';
import 'package:flutter_blog/http/repository.dart';
import 'package:flutter_blog/model/banner_mode.dart';
import 'package:flutter_blog/model/project_model.dart';
import 'package:flutter_blog/routes/routes.dart';
import 'package:flutter_blog/util/web_util.dart';
import 'package:flutter_blog/widget/ripple_widget.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'widget/banner_widget.dart';
import 'widget/main_article_item.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ///首页Banner轮播图
  List<Banners> banner = [];

  //首页数据
  List<ProjectDetail> projectData = [];

  //页数
  int page = 0;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    getBanner();
    getProject();
  }

  void getProject() {
    RequestRepository.requestHomeArticle(page, success: (data, over) {
      projectData.addAll(data);
      setState(() {});
    });
  }

  void _onRefresh() {
    projectData.clear();
    page = 0;
    getProject();
    _refreshController.refreshCompleted();
  }

  void _onLoading() {
    page++;
    getProject();
    _refreshController.loadComplete();
  }

  void getBanner() {
    RequestRepository.getBanner(success: (data) {

      banner.addAll(data);
      setState(() {});

      ///预缓存banner图片
      for (var element in data) {
        precacheImage(NetworkImage(element.imagePath), context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          top: true,
          child: Column(
            children: [
              Expanded(
                  child: Container(
                color: Colors.white,
                child: SmartRefresher(
                  enablePullUp: true,
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemBuilder: (c, i) {
                      if (i == 0) {
                        return Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          width: double.infinity,
                          height: 140,
                          child: BannerWidget(
                            banner,
                            height: 140,
                            onTap: (index) {
                              WebUtil.toWebPageBanners(banner[index]);
                            },
                          ),
                        );
                      } else {
                        return Material(
                          color: Colors.transparent,
                          child: Ripple(
                              onTap: () => WebUtil.toWebPage(projectData[i-1],
                                      onResult: (value) {
                                    projectData[i-1].collect = value;
                                  }),
                              child: MainArticleItem(
                                item: projectData[i-1],
                                index: i,
                              )),
                        );
                      }
                    },
                    itemCount: projectData.length,
                  ),
                ),
              ))
            ],
          )),
    );
  }
}
