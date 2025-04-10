import 'package:envied/envied.dart';
import 'package:flutter_ui/product/initial/config/app_configuration.dart';

part 'prod_env.g.dart';

@Envied(
  obfuscate: true,
  path: 'assets/env/.prod.env',
)
class ProdEnv implements AppConfiguration {
  @EnviedField(varName: 'BASE_URL')
  static final String _baseUrl = _ProdEnv._baseUrl;

  @override
  String get baseUrl => _baseUrl;
}
