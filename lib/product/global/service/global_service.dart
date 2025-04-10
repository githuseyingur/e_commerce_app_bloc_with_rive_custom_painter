import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ui/product/global/service/i_global_service.dart';

class GlobalService extends IGlobalService {
  GlobalService(super.dio);

  @override
  Future<dynamic> fetchProducts() async {
    try {
      final response = await dio.get(
        path: '/products',
      );

      print("response: $response");

      if (response.statusCode == HttpStatus.ok) {
        return response.data;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      print('error : $e');
      return null;
    }
  }
}
