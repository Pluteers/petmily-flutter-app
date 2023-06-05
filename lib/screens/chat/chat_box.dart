import 'package:flutter/material.dart';
import 'package:petmily/widgets/variable_text.dart';

class InputBoxWidget extends StatelessWidget {
  final Color? color;
  final String message;

  const InputBoxWidget({
    super.key,
    this.color,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Icon(
              Icons.person,
              size: 30.0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: VariableText(
                  value: message.trim(),
                  size: 15.0,
                  wght: 300.0,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OutputBoxWidget extends StatelessWidget {
  final Color? color;
  final String message;

  const OutputBoxWidget({
    super.key,
    this.color,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset(
              "assets/images/gpt_ic.png",
              height: 30.0,
              width: 30.0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: VariableText(
                  value: message.trim(),
                  size: 15.0,
                  wght: 700.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
