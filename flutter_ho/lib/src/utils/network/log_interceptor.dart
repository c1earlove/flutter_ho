import 'package:dio/dio.dart';
import 'package:flutter_ho/src/utils/log_util.dart';

/// dio 网络请求拦截日志
class LogInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {
    kLog("\n================== 请求数据 ==========================");
    kLog("|请求url：${options.path}");
    kLog('|请求头: ' + options.headers.toString());
    kLog('|请求参数: ' + options.queryParameters.toString());
    kLog('|请求方法: ' + options.method);
    kLog("|contentType = ${options.contentType}");
    kLog('|请求时间: ' + DateTime.now().toString());
    if (options.data != null) {
      kLog('|请求数据: ' + options.data.toString());
    }

    return Future.value(options);
  }

  @override
  onResponse(Response response) {
    kLog("\n|================== 响应数据 ==========================");
    if (response != null) {
      kLog("|url = ${response.request.path}");
      kLog("|code = ${response.statusCode}");
      kLog("|data = ${response.data}");
      kLog('|返回时间: ' + DateTime.now().toString());
      kLog("\n");
    } else {
      kLog("|data = 请求错误 E409");
      kLog('|返回时间: ' + DateTime.now().toString());
      kLog("\n");
    }

    return Future.value(response);
  }

  @override
  onError(DioError e) {
    kLog("\n================== 错误响应数据 ======================");
    kLog("|url = ${e.request.path}");
    kLog("|type = ${e.type}");
    kLog("|message = ${e.message}");

    kLog('|response = ${e.response}');
    kLog("\n");

    return Future.value(e);
  }
}
