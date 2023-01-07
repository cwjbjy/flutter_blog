
import 'package:flutter/material.dart';
import 'package:flutter_blog/widget/over_scroll_behavior.dart';

/// @description : 弹窗基类
// ignore: must_be_immutable
class BaseDialog extends StatefulWidget {
  ///child
  Widget child;

  ///圆角
  double shape;

  ///左右边距
  double horizontal = 25;

  BaseDialog({
    super.key,
    this.shape = 10,
    this.horizontal = 25,
    required this.child,
  });

  @override
  State<BaseDialog> createState() => _BaseDialogState();
}

class _BaseDialogState extends State<BaseDialog> with TickerProviderStateMixin {

  ///动画加载控制器
  AnimationController? scaleController;
  Animation<double>? scaleAnimation;

  ///初始化动画控制器
  @override
  void initState() {
    super.initState();
    scaleController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 360));
    scaleAnimation = Tween(begin: 0.0, end: 1.0)
        .animate(
        CurvedAnimation(parent: scaleController!, curve: Curves.easeIn));
  }



  @override
  Widget build(BuildContext context) {
    scaleController?.forward();
    return Material(
        ///透明样式
        type: MaterialType.transparency,
        ///dialog居中
        child: Center(
            ///取消ListView滑动阴影
            child: ScrollConfiguration(
                behavior: OverScrollBehavior(),

                ///ListView 的shrinkWrap属性可适应高度（有多少占多少）
                child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: scaleController!,
                    child:ListView(shrinkWrap: true, children: [
                  ///背景及内容、边距、圆角等，必须包裹在ListView中
                  Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: widget.horizontal),
                      child: Container(
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(widget.shape),
                            ),
                          ),
                        ),
                        child: widget.child,
                      ))
                ])))));
  }

  @override
  void dispose() {
    super.dispose();
     scaleController?.dispose();
  }
}
