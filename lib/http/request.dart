import 'package:flutter/cupertino.dart';
// import 'package:flutter_blog/http/api.dart';
import 'package:flutter_blog/http/dio.dart';
import 'package:flutter_blog/model/request_result.dart';
import 'package:flutter_blog/util/toast_util.dart';
import 'package:flutter_blog/get/get_extension.dart';
import 'package:get/get.dart';

/// @description :请求发起
class Request {
  /// 发起GET请求
  /// [url] 请求url
  /// [params] 请求参数
  /// [success] 请求成功回调
  static void get<T>(
    String url, {
    dynamic params,
    bool isJson = true,
    bool dialog = true,
    Success<T>? success,
  }) {
    _request(Method.GET, url,
        params: params, isJson: isJson, dialog: dialog, success: success);
  }

  /// 发起POST请求
  /// [url] 请求url
  /// [params] 请求参数
  /// [success] 请求成功回调
  static void post<T>(
    String url, {
    dynamic params,
    bool isJson = false,
    bool dialog = true,
    Success<T>? success,
  }) {
    _request(Method.POST, url,
        params: params, isJson: isJson, dialog: dialog, success: success);
  }

  /// 发起请求
  /// [method] 请求类型
  /// [url] 请求url
  /// [params] 请求参数
  /// [success] 请求成功回调
  static void _request<T>(
    Method method,
    String url, {
    dynamic params,
    required bool isJson,
    bool dialog = true,
    Success<T>? success,
  }) {
    if (dialog) {
      Get.showLoading();
    }
    // debugPrint("request url ==============> ${RequestApi.baseurl}$url");

    ///开启请求
    HttpRequest.request(method, url, params: params, isJson: isJson,
        success: (result) {
      if (dialog) {
        Get.dismiss();
      }
      if (success != null) {
        var resultModel = Result.fromJson(result);
        // debugPrint("request success =>$resultModel");
        if (resultModel.errorCode == 0) {
          success(resultModel.data);
        } else {
          ///其他状态，弹出错误提示信息
          ToastUtils.show(resultModel.errorMsg);
        }
      }
    }, fail: (msg) {
      debugPrint("request error =>$msg");
      if (dialog) {
        Get.dismiss();
      }
      ToastUtils.show(msg);
    });
  }
}
