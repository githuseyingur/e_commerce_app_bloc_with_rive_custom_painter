import 'package:dio/dio.dart';

class BadNetworkApiError extends DioException {
  BadNetworkApiError({
    required this.dioError,
  }) : super(requestOptions: dioError.requestOptions);
  final DioException dioError;
}
