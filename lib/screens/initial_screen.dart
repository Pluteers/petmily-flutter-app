import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:petmily/screens/signin_screen.dart';
import 'package:petmily/providers/login_provider.dart';
import 'package:petmily/widgets/variable_text.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color surfaceColor = Theme.of(context).colorScheme.surface;
    return ChangeNotifierProvider(
      create: (context) => LoginProvider(),
      child: Scaffold(
        backgroundColor: surfaceColor,
        body: const InitialContentWidget(),
      ),
    );
  }
}

class InitialContentWidget extends StatefulWidget {
  const InitialContentWidget({Key? key}) : super(key: key);

  @override
  State<InitialContentWidget> createState() => _InitialContentWidgetState();
}

class _InitialContentWidgetState extends State<InitialContentWidget> {
  Color? primaryColor;
  Image? kakaoNarrow;

  late LoginProvider loginProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    loginProvider = Provider.of<LoginProvider>(context);
    primaryColor = Theme.of(context).colorScheme.primary;
    kakaoNarrow = Image.asset("assets/images/kakao_login_large_narrow.png");
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            VariableText(
              value: "Petmiliy",
              size: 50.0,
              wght: 700.0,
              color: primaryColor,
            ),
            VariableText(
              value: "우리가 만드는 반려동물 캔버스",
              size: 20.0,
              wght: 300.0,
              color: primaryColor,
            ),
            const SizedBox(height: 200.0),
            IconButton(
              constraints:
                  const BoxConstraints(maxWidth: 175.0, maxHeight: 80.0),
              onPressed: () async {
                await loginProvider.kakaoLogin();
                if (loginProvider.loginStatus == LoginStatus.success) {
                  log("카카오 로그인에 성공했습니다.");
                }
              },
              icon: kakaoNarrow!,
            ),
            const SizedBox(height: 20.0),
            OutlinedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              child: const VariableText(
                value: "이메일로 시작하기",
                size: 15.0,
                wght: 400.0,
              ),
              onPressed: () {
                Theme.of(context).platform == TargetPlatform.iOS
                    ? Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                            create: (context) => LoginProvider(),
                            child: const SignInScreen(),
                          ),
                        ),
                      )
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                            create: (context) => LoginProvider(),
                            child: const SignInScreen(),
                          ),
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
