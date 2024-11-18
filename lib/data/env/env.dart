// lib/env/env.dart
// ignore_for_file: non_constant_identifier_names

import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env', obfuscate: true)
final class Env {
  @EnviedField(varName: 'GRAPHQL_URI')
  static final String GRAPHQL_URI = _Env.GRAPHQL_URI;
}
