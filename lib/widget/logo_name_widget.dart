import 'package:flutter/material.dart';
import 'package:flutter_blog/constants/r.dart';
import 'package:flutter_blog/constants/strings.dart';
import 'package:flutter_blog/constants/style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

/// @description :登录Logo
class LogoNameWidget extends StatelessWidget {
  const LogoNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            R.assetsImagesApplicationTransparent,
            color: Colors.white,
            width: 80,
          ),
          Text(
            StringStyles.appName.tr,
            style: Styles.style_white_36,
          )
        ],
      ),
    );
  }
}
