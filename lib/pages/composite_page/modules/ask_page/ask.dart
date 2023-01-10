import 'package:flutter/material.dart';
import 'package:flutter_blog/http/repository.dart';
import 'package:flutter_blog/model/project_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'widget/ask_item_widget.dart';

class AskPage extends StatefulWidget {
  const AskPage({super.key});

  @override
  State<AskPage> createState() => _AskPageState();
}

class _AskPageState extends State<AskPage> {
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
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
              itemCount: projectData.length,
              itemBuilder: (BuildContext context, int index) {
                return AskListItem(
                  detail:projectData[index],
                  onResult: (value) {
                    projectData[index].collect = value;
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
