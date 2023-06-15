import 'package:flutter/material.dart';
import 'package:petmily/widgets/variable_text.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
    context, text) {
  final dynamicColor = Theme.of(context).colorScheme;

  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: dynamicColor.secondary,
    content: VariableText(
      value: text,
      size: 13,
      wght: 300,
      color: dynamicColor.onSecondary,
    ),
  ));
}
