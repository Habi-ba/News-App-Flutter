import 'package:dio/dio.dart';
import 'package:news/api/api_constants.dart';

class DioInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    print('onErrorInterceptor:${err.error.toString()}');
    print('onErrorInterceptor:${err.message}');

    super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    print('baseUrl:${options.baseUrl}');

    options.headers.addAll({'X-Api-Key': ApiConstants.baseUrl});

    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }
}
