import 'package:flutter/material.dart';
import 'package:petmily/main.dart';
import 'package:petmily/widgets/variable_text.dart';

class ChannelScreen extends StatelessWidget {
  final channelId;
  const ChannelScreen({super.key, this.channelId});

  @override
  Widget build(BuildContext context) {
    final dynamicColor = Theme.of(context).colorScheme;
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Container(
              width: _width,
              alignment: Alignment.center,
              child: VariableText(
                value: channelId,
                size: 35,
                wght: 900,
                wdth: 100,
                color: dynamicColor.primary,
              )),
        ]),
      ),
      bottomNavigationBar: BottomAppBar(
        color: dynamicColor.surfaceVariant,
      ),
    );
  }
}
