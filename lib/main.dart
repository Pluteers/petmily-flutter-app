import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, fontFamily: "PretendardVariation",),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              testVariableFonts("이런 폰트를 사용할 수 있다고? 대박아니야?", 100.0, 100.0, 100.0),
              testVariableFonts("이런 폰트를 사용할 수 있다고? 대박아니야?", 300.0, 300.0, 300.0),
              testVariableFonts("이런 폰트를 사용할 수 있다고? 대박아니야?", 500.0, 500.0, 500.0),
              testVariableFonts("이런 폰트를 사용할 수 있다고? 대박아니야?", 700.0, 700.0, 700.0),
              testVariableFonts("이런 폰트를 사용할 수 있다고? 대박아니야?", 900.0, 900.0, 900.0),
            ],
          ),
        ),
      ),
    );
  }
}

Widget testVariableFonts(String text, double wght, double wdth, double grad) {
  return Text(
    text,
    style: TextStyle(fontFamily: "PretendardVariation", fontSize: 20.0, fontVariations: <FontVariation>[FontVariation('wght', wght), FontVariation("wdth", wdth), FontVariation("GRAD", grad)],),
  );
}