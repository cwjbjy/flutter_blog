import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';
import 'api.dart';

typedef Success<T> = Function(T data);
typedef Fail = Function(String msg);

/// 连接超时时间
const int _connectTimeout = 10000;

/// 接收超时时间
const int _receiveTimeout = 10000;

/// 发送超时时间
const int _sendTimeout = 10000;

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
        sendTimeout: _sendTimeout,
        connectTimeout: _connectTimeout,
        receiveTimeout: _receiveTimeout,
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
  static Future request<T>(Method method, String path,
      {dynamic params,
      bool isJson = true,
      required Success success,
      required Fail fail}) async {
    try {
      ///请求前先检查网络连接
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        fail('网络异常，请检查你的网络！');
        return;
      }
      Dio dio = createInstance(isJson);
      Response response = await dio.request(path,
          data: params, options: Options(method: _methodValues[method]));
      success(response.data);
    } on DioError catch (e) {
      fail('异常=====>$e');
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
