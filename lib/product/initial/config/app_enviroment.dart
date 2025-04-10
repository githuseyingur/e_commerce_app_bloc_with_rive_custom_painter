import 'package:flutter/foundation.dart';
import 'package:flutter_ui/product/initial/config/app_configuration.dart';
import 'package:flutter_ui/product/initial/config/env_dev.dart';
import 'package:flutter_ui/product/initial/config/prod_env.dart';

/// Uygulama ortamı için gerekli değerlerin tutulduğu sınıf
class AppEnvironment {
  /// Uygulama ortamı için gerekli değerlerin ayarlandığı metod
  AppEnvironment.setup({required AppConfiguration config}) {
    _config = config;
  }

  /// Uygulama ortamı için  prod veya dev değerlerini döndüren metod
  AppEnvironment.general() {
    if (kDebugMode) {
      _config = DevEnv();
    } else {
      _config = ProdEnv();
    }
  }

  static late final AppConfiguration _config;

  ///  network base url
}

/// Uygulama ortamı için gerekli değerlerin tutulduğu enum
enum AppEnvironmentItems {
  baseUrl;

  String get value {
    try {
      switch (this) {
        case AppEnvironmentItems.baseUrl:
          return AppEnvironment._config.baseUrl;

        // if
      }
    } catch (e) {
      throw Exception('AppEnvironmentItems is not initialize');
    }
  }
}
