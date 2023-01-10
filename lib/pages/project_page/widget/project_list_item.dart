import 'package:flutter/material.dart';
import 'package:flutter_blog/constants/r.dart';
import 'package:flutter_blog/model/project_model.dart';
import 'package:flutter_blog/style/colors.dart';
import 'package:flutter_blog/style/style.dart';
import 'package:flutter_blog/util/web_util.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProjectListItem extends StatelessWidget {
  ProjectDetail detail;

  Function(bool)? onResult;

  ProjectListItem({super.key, required this.detail, this.onResult});

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
                  ///标题
                  Text(
                    detail.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Styles.style_black_16_bold,
                  ),
                  Box.vBox10,

                  ///部分内容
                  Text(
                    detail.desc,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: Styles.style_6A6969_14,
                  ),
                  Box.vBox10,

                  ///作者
                  Row(
                    children: [
                      SvgPicture.asset(
                        R.assetsImagesProgram,
                        width: 16,
                      ),
                      Box.hBox10,
                      Text(
                        detail.author,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Styles.style_6A6969_14,
                      )
                    ],
                  ),
                  Box.vBox10,

                  ///发布时间
                  Row(
                    children: [
                      SvgPicture.asset(
                        R.assetsImagesDateTime,
                        width: 16,
                      ),
                      Box.hBox10,
                      Text(
                        detail.niceDate,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Styles.style_6A6969_14,
                      )
                    ],
                  )
                ],
              ),
            ),
            Box.hBox5,
            Visibility(
              visible: detail.envelopePic.isNotEmpty,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  detail.envelopePic,
                  fit: BoxFit.cover,
                  width: 72,
                  height: 72,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
