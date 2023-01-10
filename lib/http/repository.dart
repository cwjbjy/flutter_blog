import 'package:flutter_blog/http/api.dart';
import 'package:flutter_blog/http/dio.dart';
import 'package:flutter_blog/model/banner_mode.dart';
import 'package:flutter_blog/model/project_model.dart';
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

  ///请求首页文章列表接口
  ///[id]文章ID
  /// [success] 请求成功回调
  static requestHomeArticle(
    int page, {
    SuccessOver<List<ProjectDetail>>? success,
  }) {
    Request.get<dynamic>(
        RequestApi.apiHome.replaceFirst(RegExp('page'), page.toString()),
        dialog: false, success: (data) {
      ProjectPage pageData = ProjectPage.fromJson(data);
      var list = pageData.datas.map((value) {
        return ProjectDetail.fromJson(value);
      }).toList();
      if (success != null) {
        success(list, pageData.over);
      }
    });
  }

  ///请求项目列表接口
  ///[page]文章页数
  /// [success] 请求成功回调
  static requestTabModule(
    int page, {
    SuccessOver<List<ProjectDetail>>? success,
  }) {
    Request.get<dynamic>(
        RequestApi.apiProject.replaceFirst(RegExp('page'), '$page'),
        dialog: false, success: (data) {
      ProjectPage pageData = ProjectPage.fromJson(data);
      var list = pageData.datas.map((value) {
        return ProjectDetail.fromJson(value);
      }).toList();
      if (success != null) {
        success(list, pageData.over);
      }
    });
  }

  /// 用户信息
  /// [success] 请求成功回调
  static getUserInfo({
    Success<UserEntity>? success,
  }) {
    Request.get<dynamic>(RequestApi.apiUserInfo, dialog: false,
        success: (data) {
      if (success != null) {
        var userInfo = data["userInfo"];
        userInfo = UserEntity.fromJson(userInfo);
        success(userInfo);
      }
    });
  }

  ///退出登录
  static exitLogin({
    Success<bool>? success,
    Fail? fail,
  }) {
    Request.post<dynamic>(RequestApi.apiLogout, dialog: false, success: (data) {
      if (success != null) {
        success(true);
      }
    });
  }
}
