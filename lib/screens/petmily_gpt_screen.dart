import 'dart:io';
import 'package:flutter/material.dart';
import 'package:petmily/widgets/variable_text.dart';

class PetmilyGPTScreen extends StatelessWidget {
  const PetmilyGPTScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamicColor = Theme.of(context).colorScheme;
    if (Platform.isIOS) {
      ///TODO: 쿠퍼티노 디자인을 적용해야 합니다.
      return const Scaffold(
        body: Text("iOS"),
      );
    } else {
      ///머티리얼 디자인을 적용합니다.
      return Scaffold(
        backgroundColor: dynamicColor.surface,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HeaderContentWidget(
                color: dynamicColor.surfaceVariant,
              ),
              const TipContentWidget(),
              const BodyContentWidget(),
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
        persistentFooterButtons: const <Widget>[
          //TODO: Form field를 적용할 수 있도록 시도해봅니다.
        ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: VariableText(
              value: "대화하기",
              color: dynamicColor.primary,
              size: 40.0,
              wght: 300.0,
            ),
          ),
        ),
      ],
    );
  }
}

class TipContentWidget extends StatelessWidget {
  const TipContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamicColor = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: 370.0,
        height: 35,
        decoration: BoxDecoration(
          color: dynamicColor.tertiaryContainer,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.tips_and_updates,
              color: dynamicColor.tertiary,
              size: 20.0,
            ),
            VariableText(
              value: "부적절한 단어나 다른 주제의 질문은 답변하지 않습니다.",
              color: dynamicColor.tertiary,
              size: 15.0,
              wght: 500.0,
            ),
          ],
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
      child: Column(
        children: [
          SingleChildScrollView(
            child: inputOutputListView(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              inputFormField(),
              sendButton(),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _inputTextController.clear();
    super.dispose();
  }

  Widget inputFormField() {
    return Expanded(
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        controller: _inputTextController,
        decoration: InputDecoration(
          fillColor: Theme.of(context).colorScheme.surfaceVariant,
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
        icon: Icon(
          Icons.subdirectory_arrow_left_rounded,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget inputOutputListView() {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: const <Widget>[
        SizedBox(
          height: 380.0,
          child: Center(
            child: VariableText(
              value: "대화를 시작하면 내용이 나타납니다.",
              size: 12.0,
              wght: 300.0,
            ),
          ),
        ),
      ],
    );
  }
}
