import 'dart:io';
import 'package:flutter/material.dart';
import 'package:petmily/widgets/variable_text.dart';

class PetmiliyGPTScreen extends StatelessWidget {
  const PetmiliyGPTScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamicColor = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    if (Platform.isIOS) {
      ///TODO: 쿠퍼티노 디자인을 적용해야 합니다.
      return const Scaffold(
        body: Text("iOS"),
      );
    } else {
      ///머티리얼 디자인을 적용합니다.
      return Scaffold(
        backgroundColor: dynamicColor.surfaceVariant,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              HeaderContentWidget(
                color: dynamicColor.surfaceVariant,
              ),
              const BodyContentWidget()
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: dynamicColor.surfaceVariant,
          elevation: 2.0,
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  //TODO: 이전 화면으로 이동하도록 구성해야 합니다.
                },
                icon: const Icon(Icons.arrow_back_rounded),
              ),
            ],
          ),
        ),
      );
    }
  }
}

class HeaderContentWidget extends StatelessWidget {
  const HeaderContentWidget({Key? key, required this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    final dynamicColor = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: color),
      child: Center(
        child: VariableText(
          value: "GPT",
          color: dynamicColor.primary,
          size: 40.0,
          wght: 700.0,
        ),
      ),
    );
  }
}

class BodyContentWidget extends StatefulWidget {
  const BodyContentWidget({super.key});

  @override
  State<BodyContentWidget> createState() => _BodyContentWidgetState();
}

class _BodyContentWidgetState extends State<BodyContentWidget> {
  final _inputTextController = TextEditingController();
  final _bodyContentScrollController = ScrollController();
  final bool isLoading = false;
  @override
  void initState() {
    super.initState;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [inputFormField(), sendButton()],
      ),
    );
  }

  @override
  void dispose() {
    _inputTextController.clear();
    super.dispose();
  }

  Expanded inputFormField() {
    return Expanded(
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        controller: _inputTextController,
        decoration: InputDecoration(
          fillColor: Theme.of(context).colorScheme.inverseSurface,
          filled: true,
          hintText: "메세지를 입력하세요.",
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget sendButton() {
    return Visibility(
      visible: !isLoading,
      child: IconButton(
        onPressed: () {
          //TODO: inputTextController.text의 값을 감지하고, 전송 및 초기화를 담당해야 합니다.
        },
        icon: const Icon(Icons.subdirectory_arrow_left_rounded),
      ),
    );
  }
}
