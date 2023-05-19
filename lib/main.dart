import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import 'package:petmily/screens/initial_screen.dart';
import 'package:petmily/utilities/dynamic_theme.dart';

void main() {
  KakaoSdk.init(nativeAppKey: 'c906dc51f4a859838fa4b82caae37a41');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightColorScheme, ColorScheme? darkColorScheme) =>
          MaterialApp(
        theme: DynamicTheme.lightTheme(lightColorScheme),
        darkTheme: DynamicTheme.darkTheme(darkColorScheme),
        themeMode: ThemeMode.light,
        home: const InitialScreen(),
      ),
    );
  }
}
