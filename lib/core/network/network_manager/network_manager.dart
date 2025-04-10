import 'package:dio/dio.dart';
import 'package:flutter_ui/product/initial/config/app_enviroment.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NetworkManager {
  // Private constructor
  NetworkManager._() {
    _dio = Dio(_myBaseOptions());
    _addInterceptors();
  }

  // API URL, sabit değer
  final String _baseUrl = AppEnvironmentItems.baseUrl.value;

  // Dio nesnesi, late olarak tanımlanmış
  late final Dio _dio;

  // Dio nesnesini dışa açan getter
  Dio get dio => _dio;

  // Singleton instance
  static NetworkManager instance = NetworkManager._();

  static const int _maxLineWidth = 90;
  final PrettyDioLogger _prettyDioLogger = PrettyDioLogger(
    requestHeader: false,
    requestBody: false,
    responseBody: true,
    responseHeader: false,
    error: false,
    compact: false,
    maxWidth: _maxLineWidth,
  );
  //* Interceptor ekleme
  void _addInterceptors() {
    _dio.interceptors.add(_prettyDioLogger);
    // _dio.interceptors.add(AuthInterceptor());
    // _dio.interceptors.add(UnauthorizedInterceptor());
    // //  _dio.interceptors.add(BadNetworkErrorInterceptor());
    // _dio.interceptors.add(InternalServerErrorInterceptor());
  }

  Future<Response> post(
      {String? path,
      dynamic data,
      Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.post(
        path!,
        data: data,
      );
    } on DioException {
      rethrow;
    }
  }

  Future<Response> put(
      {String? path,
      dynamic data,
      Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.put(
        path!,
        data: data,
      );
    } on DioException {
      rethrow;
    }
  }

  Future<Response> delete(
      {String? path, Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.delete(
        path!,
      );
    } on DioException {
      rethrow;
    }
  }

  Future<Response> get(
      {String? path, Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(
        path!,
        options: Options(
          validateStatus: (status) => (status! < 500),
        ),
      );
    } on DioException {
      rethrow;
    }
  }

  //* Configure dio to use base url and headers
  BaseOptions _myBaseOptions() => BaseOptions(
        baseUrl: _baseUrl,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        validateStatus: (status) {
          return status != null ? status < 500 : false;
        },
        headers: _headers,
        extra: _headers,

        // connectTimeout: 10000,
        //receiveTimeout: 10000,
      );
  Map<String, dynamic>? get _headers {
    return {
      'Content-Type': 'application/json',
      'Accept': '*/*',
    };
  }
}
