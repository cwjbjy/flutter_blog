import 'package:flutter/material.dart';
import 'package:flutter_blog/i18/strings.dart';
import 'package:flutter_blog/style/colors.dart';
import 'package:flutter_blog/style/style.dart';
import 'package:get/get.dart';

class RegisterPrivacyWidget extends StatefulWidget {
  final bool isCheckPrivacy;

  final void Function() onchange;

  const RegisterPrivacyWidget(
      {super.key, required this.isCheckPrivacy, required this.onchange});

  @override
  State<RegisterPrivacyWidget> createState() => _RegisterPrivacyWidgetState();
}

class _RegisterPrivacyWidgetState extends State<RegisterPrivacyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16),
      child: Row(
        children: [
          Checkbox(
              value: widget.isCheckPrivacy,
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.all(ColorStyle.color_24CF5F),
              onChanged: (select) {
                widget.onchange();
              }),
          Text(
            StringStyles.registerServiceTerms.tr,
            style: Styles.style_white_14,
          )
        ],
      ),
    );
  }
}
