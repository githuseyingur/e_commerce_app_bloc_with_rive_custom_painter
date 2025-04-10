import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui/main.dart';
import 'package:flutter_ui/product/initial/config/app_enviroment.dart';
import 'package:flutter_ui/product/initial/config/env_dev.dart';

@immutable

/// initialize
class ApplicationInitialize {
  /// Uygulama ilk açıldığında çalışacak olan fonksiyon
  static Future<void> make() async {
    await runZonedGuarded<Future<void>>(() {
      return _initialize();
    }, (error, stack) {
      runApp(const MyApp());
    });
  }

  static Future<void> _initialize() async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]); // Uygulama dikey modda çalışsın diye.
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: [SystemUiOverlay.bottom]); // close status bar

    AppEnvironment.setup(config: DevEnv());
  }
}
