import 'package:flutter_blog/i18/strings.dart';
import 'package:get/get.dart';

/// @description :语言
class Language {
  String? name;
  String language = '';
  String country = '';
  bool? isSelect = false;

  Language(
      {this.name,
      required this.language,
      required this.country,
      this.isSelect});

  Language.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    language = json['language'];
    country = json['country'];
    isSelect = json['isSelect'];
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'language': language,
        'country': country,
        'isSelect': isSelect,
      };
}

///新增语言要在此处手动增加
final languageList = [
  Language(
      name: StringStyles.settingLanguageDefault.tr, language: '', country: ''),
  Language(name: '简体中文', language: 'zh', country: 'CN'),
  Language(name: 'English', language: 'zh', country: 'US'),
];
