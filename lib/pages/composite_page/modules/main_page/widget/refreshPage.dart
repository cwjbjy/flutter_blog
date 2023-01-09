import 'package:flutter/material.dart';
import 'package:flutter_blog/http/repository.dart';
import 'package:flutter_blog/pages/composite_page/modules/main_page/widget/main_article_item.dart';
import 'package:flutter_blog/util/web_util.dart';
import 'package:flutter_blog/widget/ripple_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_blog/model/project_model.dart';

class RefreshPage extends StatefulWidget {
  const RefreshPage({Key? key}) : super(key: key);

  @override
  State<RefreshPage> createState() => _RefreshPageState();
}

class _RefreshPageState extends State<RefreshPage> {
  //首页数据
  List<ProjectDetail> projectData = [];

  //页数
  int page = 0;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullUp: true,
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemBuilder: (c, i) => Material(
          color: Colors.transparent,
          child: Ripple(
              onTap: () => WebUtil.toWebPage(projectData[i], onResult: (value) {
                    projectData[i].collect = value;
                  }),
              child: MainArticleItem(
                item: projectData[i],
                index: i,
              )),
        ),
        itemCount: projectData.length,
      ),
    );
  }
}
