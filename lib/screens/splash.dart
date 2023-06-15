import 'dart:async';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:transition/transition.dart';

import 'package:petmily/screens/initial_screen.dart';
import 'package:petmily/widgets/variable_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(milliseconds: 5000),
      () {
        Navigator.pushReplacement(
          context,
          Transition(
              child: const InitialScreen(),
              transitionEffect: TransitionEffect.FADE),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dynamicColor = Theme.of(context).colorScheme;
    return Scaffold(
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              VariableText(
                value: "Petmily",
                size: 50.0,
                wght: 700.0,
                color: dynamicColor.primary,
              ),
              SizedBox(
                height: 30,
                child: AnimatedTextKit(
                  totalRepeatCount: 1,
                  animatedTexts: [
                    TyperAnimatedText(
                      "우리가 만드는 반려동물 캔버스",
                      speed: const Duration(milliseconds: 100),
                      textStyle: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300,
                        color: dynamicColor.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: double.infinity,
                height: 200,
                child: Lottie.network(
                    "https://assets9.lottiefiles.com/packages/lf20_syqnfe7c.json"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
