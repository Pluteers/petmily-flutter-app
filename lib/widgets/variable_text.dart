import 'dart:ui';
import 'package:flutter/material.dart';

/// - Variable 폰트 파일을 Font Variation으로 적용한 텍스트 위젯입니다.
/// - `wght: double` 인자로 폰트의 굵기를 조절할 수 있습니다.
/// - [100.0, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 900.0] 중 선택할 수 있습니다.
class VariableText extends StatelessWidget {
  final String value;
  final double size;
  final Color? color;
  final double? wght;

  const VariableText({
    Key? key,
    required this.value,
    required this.size,
    this.color,
    this.wght,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontVariations: <FontVariation>[FontVariation('wght', wght!)],
      ),
    );
  }
}
