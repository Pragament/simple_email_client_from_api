import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pragament_mail/constants.dart';
import 'package:pragament_mail/presentation/routes/router.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

void main() async {
  await Hive.initFlutter();

  await Hive.openBox<dynamic>('settingsBox');
  WebViewPlatform.instance = WebWebViewPlatform();

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ColorScheme colorScheme({bool isDark = false}) => ColorScheme.fromSeed(
          seedColor: Colors.yellow,
          brightness: isDark ? Brightness.dark : Brightness.light,
        );

    return MaterialApp.router(
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      theme: ThemeData.from(colorScheme: colorScheme(), useMaterial3: true),
      darkTheme: ThemeData.from(
          colorScheme: colorScheme(isDark: true), useMaterial3: true),
      routerConfig: ref.watch(routerProvider),
    );
  }
}
