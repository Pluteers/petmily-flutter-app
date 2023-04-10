import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamicColor = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
          ),
        ),
      )),
      bottomNavigationBar: BottomAppBar(
        color: dynamicColor.surfaceVariant,
      ),
    );
  }
}
