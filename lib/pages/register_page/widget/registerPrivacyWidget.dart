import 'package:flutter/material.dart';
import 'package:flutter_blog/i18/strings.dart';
import 'package:flutter_blog/style/colors.dart';
import 'package:flutter_blog/style/style.dart';
import 'package:get/get.dart';

import '../register_controller.dart';

class RegisterPrivacyWidget extends StatefulWidget {
  const RegisterPrivacyWidget({super.key});

  @override
  State<RegisterPrivacyWidget> createState() => _RegisterPrivacyWidgetState();
}

class _RegisterPrivacyWidgetState extends State<RegisterPrivacyWidget> {
  final RegisterController controller = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16),
      child: Row(
        children: [
          Obx(() => Checkbox(
              value: controller.isCheckPrivacy.value,
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.all(ColorStyle.color_24CF5F),
              onChanged: (select) {
                controller.updateCheck();
              })),
          Text(
            StringStyles.registerServiceTerms.tr,
            style: Styles.style_white_14,
          )
        ],
      ),
    );
  }
}
