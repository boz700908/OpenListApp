import 'dart:io';

import 'package:openlist_utils/init.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:openlist_global/l10n/generated/openlist_global_localizations.dart';
import 'package:openlist_native_ui/l10n/generated/openlist_native_ui_localizations.dart';
import 'package:openlist_web_ui/l10n/generated/openlist_web_ui_localizations.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'l10n/generated/openlist_localizations.dart';
import 'package:openlist_config/model/custom_theme.dart';
import 'package:openlist_global/pages/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
    await windowManager.ensureInitialized();
    windowManager.addListener(MyWindowListener());
  }
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CustomTheme()),
      ],
      child: const MyApp()
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpenList',
      // themeMode: ThemeMode.system,
      theme: CustomThemes.light,
      darkTheme: CustomThemes.dark,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        OpenListLocalizations.delegate,
        OpenListGlobalLocalizations.delegate,
        OpenListWebUiLocalizations.delegate,
        OpenlistNativeUiLocalizations.delegate,
      ],
      supportedLocales: OpenListLocalizations.supportedLocales,
      localeListResolutionCallback: (locales, supportedLocales) {
        print("locales:$locales");
        return;
      },
      // TODO 后面可以选界面，待原生界面完善再全面切换原生界面
      // home: const WebScreen(),
      // home: Platform.isMacOS?SplashImagePage():WebScreen(),
      // home: HomePage(),
      // home: (Platform.isIOS || Platform.isMacOS)?openlist_web_ui.LoginPage():openlist_native_ui.LoginPage(),
      // TODO 插件Linux上不支持网页
      home: LoginPage(),
      // home: openlist_native_ui.LoginPage(),
    );
  }
}


class MyWindowListener extends WindowListener {
  @override
  void onWindowClose() {
    // 处理窗口关闭事件
    print("onWindowClose");
    exit(0);
  }

  @override
  void onWindowMaximize() {
    // 处理窗口最大化事件
    print("onWindowMaximize");
  }
}
