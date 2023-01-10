import 'package:flutter/material.dart';
import 'package:flutter_blog/model/project_model.dart';
import 'package:flutter_blog/style/colors.dart';
import 'package:flutter_blog/style/style.dart';
import 'package:flutter_blog/util/web_util.dart';
import 'package:flutter_blog/widget/head_circle_widget.dart';

class AskListItem extends StatelessWidget {
  ProjectDetail detail;

  Function(bool)? onResult;

  AskListItem({super.key, required this.detail, this.onResult});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => WebUtil.toWebPage(detail, onResult: onResult),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom:
                    BorderSide(width: 0.5, color: ColorStyle.color_EFF1F8))),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    detail.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Styles.style_black_16_bold,
                  ),
                  Box.vBox10,
                  Row(
                    children: [
                      HeadCircleWidget(
                        width: 22,
                        height: 22,
                      ),
                      Box.hBox5,
                      Text(
                        detail.shareUser.isEmpty
                            ? detail.author
                            : detail.shareUser,
                        style: Styles.style_B8C0D4_13,
                      ),
                      Box.hBox15,
                      Text(
                        detail.niceDate,
                        style: Styles.style_B8C0D4_13,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Box.hBox5,
          ],
        ),
      ),
    );
  }
}
