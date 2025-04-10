import 'package:dio/dio.dart';

class InternalServerApiError extends DioException {
  InternalServerApiError({
    required this.dioError,
  }) : super(requestOptions: dioError.requestOptions);
  final DioException dioError;
}
