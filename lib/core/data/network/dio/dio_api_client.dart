import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:interviewtask/core/data/network/dio/dio_extension.dart';
import 'package:interviewtask/core/data/network/utils/base_url.dart';
import 'package:interviewtask/core/data/network/utils/base_utils.dart';
import 'package:interviewtask/ui/screens/home/model/items_model.dart';

import '../api_client.dart';

class DioApiClient extends ApiClient {
  static late DioApiClient _service;

  static Dio? _dio;

  static Dio get _dioClient => _dio!;

  DioApiClient._();

  static Future<DioApiClient> getInstance() async {
    if (_dio == null) {
      _dio = _init();
      _service = DioApiClient._();
    }
    return _service;
  }

  static Dio _init() {
    final dio = Dio();
    dio.options.baseUrl = BaseUrl.baseUrl;

    dio.options.connectTimeout = TimeOut.connectTimeout.inMilliseconds;
    dio.options.receiveTimeout = TimeOut.connectTimeout.inMilliseconds;

    //add logging interceptor with debug check
    dio.interceptors.add(LogInterceptor(
      requestBody: kDebugMode,
      request: kDebugMode,
      requestHeader: kDebugMode,
      responseBody: kDebugMode,
    ));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          return handler.next(options);
        },
      ),
    );
    return dio;
  }

  @override
  Future<List<ItemsModel>> getItems() async {
    final request = await _dioClient.getApi(UrlPath.items);

    return List<ItemsModel>.from(request.map((e) => ItemsModel.fromJson(e)));
  }
}
