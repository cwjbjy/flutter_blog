import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';
import 'api.dart';
import 'package:flutter_blog/util/toast_util.dart';

typedef Success<T> = Function(T data);

/// @description :请求工具
class HttpRequest {
  ///全局Dia对象
  static Dio? _dio;

  /// 创建 dio 实例对象
  static Dio createInstance(bool isJson) {
    if (_dio == null) {
      var options = BaseOptions(
        ///提交方式：1.JSON方式提交 2.表单提交
        contentType: isJson
            ? Headers.jsonContentType
            : Headers.formUrlEncodedContentType,
        baseUrl: RequestApi.baseurl,
      );
      _dio = Dio(options);
    }
    _dio?.options.contentType =
        isJson ? Headers.jsonContentType : Headers.formUrlEncodedContentType;
    return _dio!;
  }

  /// 请求，返回参数为 T
  /// [method]：请求方法，Method.POST等
  /// [path]：请求地址
  /// [params]：请求参数
  /// [success]：请求成功回调
  static Future request<T>(
    Method method,
    String path, {
    dynamic params,
    bool isJson = true,
    required Success success,
  }) async {
    try {
      ///请求前先检查网络连接
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        ToastUtils.show('网络异常，请检查你的网络！');
        return;
      }
      Dio dio = createInstance(isJson);
      Response response = await dio.request(path,
          data: params, options: Options(method: _methodValues[method]));
      success(response.data);
    } on DioError catch (e) {
      debugPrint("异常=====>$e");
    }
  }
}

///请求类型枚举
enum Method { GET, POST, DELETE, PUT, PATCH, HEAD }

///请求类型值
const _methodValues = {
  Method.GET: "get",
  Method.POST: "post",
  Method.DELETE: "delete",
  Method.PUT: "put",
  Method.PATCH: "patch",
  Method.HEAD: "head",
};
