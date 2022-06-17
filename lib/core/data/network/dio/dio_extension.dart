import 'package:dio/dio.dart';

extension DioEx on Dio {
  /// Top level methods

  /// common GET method
  Future<dynamic> getApi(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      Response response = await get(
        path,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioError catch (e) {
      rethrow;
    }
  }
}
