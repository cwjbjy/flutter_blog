import 'package:flutter_blog/http/api.dart';
import 'package:flutter_blog/http/dio.dart';
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
  /// [fail] 请求失败回调
  register(
    String account,
    String password,
    String rePassword, {
    Success<UserEntity>? success,
    Fail? fail,
  }) {
    Request.post<dynamic>(RequestApi.apiRegister, {
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
  /// [fail] 请求失败回调
  login(
    String account,
    String password, {
    Success<UserEntity>? success,
    Fail? fail,
  }) {
    Request.post<dynamic>(
      RequestApi.apiLogin,
      {"username": account, "password": password},
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


  banner(){
    Request.get(RequestApi.apiBanner,{});
  }
}
