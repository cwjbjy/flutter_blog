import 'package:flutter/material.dart';
import 'package:flutter_blog/style/colors.dart';

/// @description :点击波纹效果Widget
// ignore: must_be_immutable
class Ripple extends StatelessWidget {
  ///点击事件
  GestureTapCallback? onTap;

  ///圆角大小
  double circular;

  ///widget
  Widget child;

  Ripple({super.key, this.onTap, this.circular = 0, required this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(
        Radius.circular(circular),
      ),
      onTap: onTap,
      splashColor: ColorStyle.color_E2E3E8_66,
      highlightColor: ColorStyle.color_E2E3E8_66,
      child: child,
    );
  }
}
