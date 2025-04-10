import 'package:flutter_ui/core/network/network_manager/network_manager.dart';

abstract class IGlobalService {
  IGlobalService(this.dio);
  NetworkManager dio;

  Future<dynamic> fetchProducts();
}
