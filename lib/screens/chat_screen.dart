
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:petmily/providers/petmily_gpt_generator.dart';
import 'package:petmily/widgets/variable_text.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PetmilyGPTGenerator(),
      child: const ChatContentWidget(),
    );
  }
}

class ChatContentWidget extends StatefulWidget {
  const ChatContentWidget({super.key});

  @override
  State<ChatContentWidget> createState() => _ChatContentWidgetState();
}

class _ChatContentWidgetState extends State<ChatContentWidget> {
  Color? kPrimaryColor;
  Color? kSurfaceColor;
  Color? kSurfaceTintColor;
  Color? kSurfaceVariantColor;

  @override
  void didChangeDependencies() {
    kPrimaryColor = Theme.of(context).colorScheme.primary;
    kSurfaceColor = Theme.of(context).colorScheme.surface;
    kSurfaceTintColor = Theme.of(context).colorScheme.surfaceTint;
    kSurfaceVariantColor = Theme.of(context).colorScheme.surfaceVariant;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSurfaceColor,
      //resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            HeaderContentWidget(
              color: kSurfaceVariantColor,
            ),
            const TipContentWidget(),
            const BodyContentWidget(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: kSurfaceVariantColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 4.0,
        elevation: 2.0,
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                //TODO: 이전 화면으로 이동하도록 구성해야 합니다.
              },
              icon: Icon(
                Icons.arrow_back_rounded,
                color: kPrimaryColor,
                size: 10.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderContentWidget extends StatelessWidget {
  const HeaderContentWidget({Key? key, required this.color}) : super(key: key);

  final Color? color;

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
        width: 360.0,
        height: 35,
        decoration: BoxDecoration(
          color: dynamicColor.tertiaryContainer,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.tips_and_updates,
              color: dynamicColor.tertiary,
              size: 20.0,
            ),
            VariableText(
              value: "부적절한 단어나 다른 주제의 질문은 답변하지 않습니다.",
              color: dynamicColor.tertiary,
              size: 12.0,
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
  TextEditingController inputController = TextEditingController();
  ScrollController bodyContentScrollController = ScrollController();
  bool isBottomAppBarVisible = true;
  bool isLoading = false;
  bool isTyping = false;

  ///스크롤의 변화를 감지할 수 있도록 합니다.
  void scrollHandler() {
    if (bodyContentScrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (isBottomAppBarVisible) {
        setState(() {
          isBottomAppBarVisible = false;
        });
      }
    } else {
      if (!isBottomAppBarVisible) {
        setState(() {
          isBottomAppBarVisible = true;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState;
    bodyContentScrollController.addListener(scrollHandler);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SingleChildScrollView(
            controller: bodyContentScrollController,
            reverse: true,
            child: inputOutputListView(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: inputFormField(),
              ),
              sendButton(),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    bodyContentScrollController.removeListener(scrollHandler);
    bodyContentScrollController.dispose();
    inputController.clear();
    super.dispose();
  }

  Widget inputFormField() {
    return Expanded(
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        controller: inputController,
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
                value: "대화를 시작하면 내용이 나타납니다.", size: 12.0, wght: 300.0),
          ),
        ),
      ],
    );
  }
}
