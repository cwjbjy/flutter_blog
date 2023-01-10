import 'package:flutter/material.dart';
import 'package:flutter_blog/i18/strings.dart';
import 'package:flutter_blog/model/language.dart';
import 'package:flutter_blog/style/colors.dart';
import 'package:flutter_blog/style/style.dart';
import 'package:flutter_blog/util/locale_util.dart';
import 'package:flutter_blog/util/save/sp_util.dart';
import 'package:flutter_blog/widget/over_scroll_behavior.dart';
import 'package:flutter_blog/widget/toolbar.dart';
import 'package:get/get.dart';

class SettingLanguagePage extends StatefulWidget {
  const SettingLanguagePage({super.key});

  @override
  State<SettingLanguagePage> createState() => _SettingLanguagePageState();
}

class _SettingLanguagePageState extends State<SettingLanguagePage> {
  ///应用支持的语言
  List<Language> language = languageList;

  @override
  void initState() {
    super.initState();

    ///读取语言存储
    var languageModel = SpUtil.getLanguage();
    if (languageModel == null) {
      language[0].isSelect = true;
    } else {
      ///找到当前选中的语言
      for (var item in language) {
        if (item.name == languageModel.name) {
          item.isSelect = true;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        child: Column(
          children: [
            ToolBar(
              title: StringStyles.settingLanguage.tr,
            ),
            DividerStyle.divider1Half,
            ScrollConfiguration(
                behavior: OverScrollBehavior(),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: language.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        onTap: () {
                          ///更新语言
                          language
                            ..forEach((item) {
                              item.isSelect = false;
                            })
                            ..[index].isSelect = true;
                          SpUtil.updateLanguage(language[index]);
                          LocaleOptions.updateLocale(language[index]);
                          Get.back();
                        },
                        title: Text(language[index].name),
                        trailing: Visibility(
                          visible: language[index].isSelect,
                          child: const Icon(
                            Icons.radio_button_checked,
                            color: ColorStyle.color_24CF5F,
                            size: 20,
                          ),
                        ));
                  },
                ))
          ],
        ),
      ),
    );
  }
}
