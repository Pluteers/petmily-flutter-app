import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:petmily/login/screens/login_view.dart';
import 'package:petmily/mypage/services/mypage_service.dart';
import 'package:petmily/signup/services/auth_service.dart';
import 'package:petmily/utilities/dynamic_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightColorScheme, ColorScheme? darkColorScheme) =>
          MaterialApp(
        theme: DynamicTheme.lightTheme(lightColorScheme),
        darkTheme: DynamicTheme.darkTheme(darkColorScheme),
        themeMode: ThemeMode.light,
        home: LoginView(),
        /*Scaffold(
         
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                testVariableFonts(
                    "이런 폰트를 사용할 수 있다고? 대박아니야?", 100.0, 100.0, 100.0),
                testVariableFonts(
                    "이런 폰트를 사용할 수 있다고? 대박아니야?", 300.0, 300.0, 300.0),
                testVariableFonts(
                    "이런 폰트를 사용할 수 있다고? 대박아니야?", 500.0, 500.0, 500.0),
                testVariableFonts(
                    "이런 폰트를 사용할 수 있다고? 대박아니야?", 700.0, 700.0, 700.0),
                testVariableFonts(
                    "이런 폰트를 사용할 수 있다고? 대박아니야?", 900.0, 900.0, 900.0),
              ],
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Theme.of(context).colorScheme.surface,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.circle_rounded)),
                const Spacer(),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.circle_rounded)),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.circle_rounded)),
              ],
            ),
          ),
        ),*/
      ),
    );
  }
}

Widget testVariableFonts(String text, double wght, double wdth, double grad) {
  return Text(
    text,
    style: TextStyle(
      fontFamily: "PretendardVariation",
      fontSize: 20.0,
      fontVariations: <FontVariation>[
        FontVariation('wght', wght),
        FontVariation("wdth", wdth),
        FontVariation("GRAD", grad),
      ],
    ),
  );
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("로그인 성공"),
      ),
    );
  }
}
