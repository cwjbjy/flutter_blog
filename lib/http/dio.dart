import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_blog/model/request_register.dart';
import 'package:flutter_blog/util/save/sp_util.dart';

import 'api.dart';
import 'exception.dart';

typedef Success<T> = Function(T data);
typedef Fail = Function(int code, String msg);

/// @description :请求工具
class HttpRequest {
  ///全局Dia对象
  static Dio? _dio;

  /// 创建 dio 实例对象
  static Dio createInstance([bool isJson = false]) {
    if (_dio == null) {
      var options = BaseOptions(
        ///提交方式：1.表单提交 2.JSON方式提交
        /// 请求的Content-Type，默认值是"application/json; charset=utf-8".
        /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
        /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]就会自动编码请求体.
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
  /// [error]：请求失败回调
  static Future request<T>(Method method, String path, dynamic params,
      {bool isJson = false, Success? success, required Fail? fail}) async {
    try {
      ///请求前先检查网络连接
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        _onError(HttpException.netError, '网络异常，请检查你的网络！', fail);
        return;
      }
      Dio dio = createInstance(isJson);
      Response response = await dio.request(path,
          data: params,
          options:
              Options(method: _methodValues[method], headers: _headerToken()));
      if (success != null) {
        success(response.data);
      }
    } on DioError catch (e) {
      final NetError netError = HttpException.handleException(e);
      _onError(netError.code, netError.msg, fail);
      debugPrint("异常=====>$e");
    }
  }
}

/// 请求时添加cookie
Map<String, dynamic>? _headerToken() {
  /// 自定义Header,如需要添加token信息请调用此参数
  UserEntity? info = SpUtil.getUserInfo();
  if (info == null) {
    return null;
  }
  Map<String, dynamic> httpHeaders = {
    'Cookie':
        'loginUserName=${info.username};loginUserPassword=${info.password}',
  };
  return httpHeaders;
}

/// 错误回调
/// [code] 错误代码
/// [msg] 错误信息
/// [fail] 错误回调
void _onError(int code, String msg, Fail? fail) {
  if (code == 0) {
    code = HttpException.unknownError;
    msg = '未知异常';
  }
  if (fail != null) {
    fail(code, msg);
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
