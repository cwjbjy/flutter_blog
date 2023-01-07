import 'dart:convert';
import 'package:flutter_blog/model/project_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_blog/model/request_register.dart';
import 'package:flutter_blog/model/language.dart';
import 'sp_key.dart';

class SpUtil {
  ///获取语言选项
  ///[Language] 语言
  static Language? getLanguage() {
    SharedPreferences sp = Get.find<SharedPreferences>();
    try {
      var json = sp.getString(SPKey.language);
      if (json == null) {
        return null;
      } else {
        return Language.fromJson(jsonDecode(json));
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  ///存储语言
  ///[Language] 语言
  static updateLanguage(Language language) {
    Get.find<SharedPreferences>().remove(SPKey.language);
    Get.find<SharedPreferences>()
        .setString(SPKey.language, jsonEncode(language));
  }

  ///获取用户信息
  ///[UserEntity] 用户信息
  static UserEntity? getUserInfo() {
    SharedPreferences sp = Get.find<SharedPreferences>();
    try {
      var json = sp.getString(SPKey.keyUserInfo);
      if (json == null) {
        return null;
      } else {
        return UserEntity.fromJson(jsonDecode(json));
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  ///存储用户信息
  ///[userInfo] 用户信息
  static putUserInfo(UserEntity userInfo) {
    Get.find<SharedPreferences>()
        .setString(SPKey.keyUserInfo, jsonEncode(userInfo));
  }

  /// 浏览历史记录
  /// [detail] 浏览记录
  static saveBrowseHistory(ProjectDetail detail) {
    var history = getBrowseHistory();
    for (var element in history) {
      Map<String, dynamic> map = jsonDecode(element);
      var convert = ProjectDetail.fromJson(map);
      if (convert.id == detail.id) {
        return;
      }
    }
    var toJson = jsonEncode(detail.toJson());
    history.insert(0, toJson);
    Get.find<SharedPreferences>().setStringList(SPKey.browseHistory, history);
  }

  ///获取浏览历史记录
  static List<String> getBrowseHistory() {
    SharedPreferences sp = Get.find<SharedPreferences>();
    try {
      var json = sp.getStringList(SPKey.browseHistory);
      if (json == null) {
        return [];
      } else {
        return json;
      }
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
