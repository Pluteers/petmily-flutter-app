import 'dart:io';

import 'package:flutter/material.dart';

class PetmiliyGPTScreen extends StatelessWidget {
  const PetmiliyGPTScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamicColor = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    if (Platform.isIOS) {
      ///쿠퍼티노 디자인을 적용합니다.
      return const Scaffold(
        body: Text("iOS"),
      );
    } else {
      ///머티리얼 디자인을 적용합니다.
      return Scaffold(
        backgroundColor: dynamicColor.surface,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            HeaderWidget(
              color: dynamicColor.surfaceVariant,
            ),
            const Text("Android"),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: dynamicColor.surfaceVariant,
          elevation: 2.0,
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_back_rounded),
              ),
            ],
          ),
        ),
      );
    }
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key, required this.color}) : super(key: key);
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: color),
      child: const Text("GPT"),
    );
  }
}
