import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:petmily/screens/chat/chat_box.dart';
import 'package:petmily/services/openai_connector.dart';
import 'package:provider/provider.dart';
import 'package:petmily/providers/chat_provider.dart';
import 'package:petmily/widgets/variable_text.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatProvider(),
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
  Image? gptIcon;
  bool isVisible = false;
  bool isTyping = false;

  late FocusNode inputFocusNode;
  late TextEditingController inputController;
  late ScrollController scrollController;
  late ChatProvider chatProvider;
  late OpenaiConnector openaiConnector;
  late ColorScheme dynamicColor;

  void scrollHandler() {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      showing();
    } else if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      hiding();
    }
  }

  void hiding() {
    if (isVisible) {
      setState(() => isVisible = false);
    }
  }

  void showing() {
    if (!isVisible) {
      setState(() => isVisible = true);
    }
  }

  @override
  void initState() {
    inputFocusNode = FocusNode();
    inputController = TextEditingController();
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    scrollController.addListener(scrollHandler);
    chatProvider = Provider.of<ChatProvider>(context);
    openaiConnector = OpenaiConnector();
    dynamicColor = Theme.of(context).colorScheme;
    gptIcon = Image.asset("assets/images/ic_gpt.png");
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    inputFocusNode.dispose();
    inputController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dynamicColor.surface,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerContentWidget(),
            tipContentWidget(),
            bodyContentListWidget(),
            inputField(),
          ],
        ),
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 100.0,
        child: BottomAppBar(
          color: dynamicColor.surfaceVariant,
          shape: const CircularNotchedRectangle(),
          notchMargin: 4.0,
          elevation: 2.0,
          surfaceTintColor: dynamicColor.surfaceTint,
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: dynamicColor.onSurfaceVariant,
                  size: 25.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///- 화면이 다시 그려지더라도 값의 변화가 없는 가로형 컨테이너 위젯입니다.
  ///- 해당하는 화면이 어떤 구성을 하고 있는지 대체적인 타이틀이 포함됩니다.
  Widget headerContentWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: VariableText(
          color: dynamicColor.onSurface,
          value: "채팅",
          size: 40.0,
          wght: 300.0,
        ),
      ),
    );
  }

  ///- 채팅을 시작하기 앞서 준수해야하는 규칙을 보여주는 위젯입니다.
  ///- TipContent 위젯은 화면이 다시 그려질 때마다 문장이 바뀌어야 합니다.
  ///- 규칙과 관련된 문장은 List 타입으로 저장되어 있습니다.
  Widget tipContentWidget() {
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
          children: <Widget>[
            Icon(
              Icons.tips_and_updates_rounded,
              color: dynamicColor.tertiary,
              size: 20.0,
            ),
            VariableText(
              value: "팁: 부적절한 단어나 다른 주제의 질문은 답변하지 않습니다.",
              color: dynamicColor.tertiary,
              size: 13.0,
              wght: 500.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget bodyContentListWidget() {
    return Flexible(
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: chatProvider.messages.length,
        itemBuilder: (context, index) {
          final message = Provider.of<ChatProvider>(context).messages[index];
          if (message.isUser) {
            return InputBoxWidget(message: message.text);
          } else if (!message.isUser) {
            return OutputBoxWidget(
              message: message.text,
              color: dynamicColor.surfaceVariant,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  ///- 사용자가 원하는 문장을 작성할 수 있는 위젯입니다.
  ///- [`focusNode:` FocusNode()로 지정되어 있습니다.]
  ///- [`controller:` TextEditingController()로 지정되어 있습니다.]
  ///- Capitalization 설정은 단어가 아닌 문장으로 지정되어 있습니다.
  Widget inputField() {
    return TextFormField(
      focusNode: inputFocusNode,
      controller: inputController,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.done,
      autocorrect: false,
      obscureText: false,
      decoration: InputDecoration(
        fillColor: dynamicColor.surfaceVariant,
        filled: true,
        suffixIcon: IconButton(
            onPressed: () async {
              String input = inputController.text.trim();
              chatProvider.setMessages(MessageModel(text: input, isUser: true));
              inputController.clear();

              String output = await openaiConnector.pushInput(input);
              chatProvider
                  .setMessages(MessageModel(text: output, isUser: false));
            },
            icon: const Icon(
              Icons.arrow_right_rounded,
              size: 35.0,
            )),
        hintText: "메세지를 입력하세요.",
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
    );
  }
}
