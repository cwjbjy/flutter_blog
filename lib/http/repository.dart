import 'package:flutter_blog/http/api.dart';
import 'package:flutter_blog/http/dio.dart';
import 'package:flutter_blog/model/banner_mode.dart';
import 'package:flutter_blog/model/request_register.dart';
import 'package:flutter_blog/util/save/sp_util.dart';

import 'request.dart';

typedef SuccessOver<T> = Function(T data, bool over);

class RequestRepository {
  ///注册请求
  /// [account]账号
  /// [password]密码
  /// [password]重复密码
  /// [success] 请求成功回调
  static register(
    String account,
    String password,
    String rePassword, {
    Success<UserEntity>? success,
  }) {
    Request.post<dynamic>(RequestApi.apiRegister, params: {
      "username": account,
      "password": password,
      "repassword": rePassword
    }, success: (data) {
      var registerInfo = UserEntity.fromJson(data);
      registerInfo.password = password;
      SpUtil.putUserInfo(registerInfo);
      if (success != null) {
        success(registerInfo);
      }
    });
  }

  ///登录请求
  /// [account]账号
  /// [password]密码
  /// [success] 请求成功回调
  static login(
    String account,
    String password, {
    Success<UserEntity>? success,
  }) {
    Request.post<dynamic>(
      RequestApi.apiLogin,
      params: {"username": account, "password": password},
      success: (data) {
        var loginInfo = UserEntity.fromJson(data);
        loginInfo.password = password;
        SpUtil.putUserInfo(loginInfo);
        if (success != null) {
          success(loginInfo);
        }
      },
    );
  }

  /// 分享文章到站点
  /// [title] 文章标题
  /// [link] 文章链接
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  static shareArticle(
    String title,
    String link, {
    Success<String>? success,
  }) {
    Request.post(RequestApi.apiAddArticle,
        params: {'title': title, 'link': link}, dialog: false, success: (data) {
      if (success != null) {
        success("success");
      }
    });
  }

  ///获取首页的Banner图片
  static getBanner({
    Success<List<Banners>>? success,
    Fail? fail,
  }) {
    Request.get<List<dynamic>>(RequestApi.apiBanner, dialog: false,
        success: (data) {
      if (success != null) {
        var list = data.map((value) {
          return Banners.fromJson(value);
        }).toList();
        success(list);
      }
    });
  }
}
