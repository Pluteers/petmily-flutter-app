import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:petmily/screens/signin_screen.dart';
import 'package:petmily/screens/signup_screen.dart';
import 'package:petmily/widgets/variable_text.dart';
import 'package:petmily/services/login_service.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);
    final dynamicColor = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;
    Color buttonColor = dynamicColor.background;

    void changeButtonColor() {
      setState(() {
        buttonColor = dynamicColor.primary; // 원하는 색상으로 변경
      });
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            VariableText(
              value: "Petmiliy",
              size: 45,
              wght: 900,
              color: dynamicColor.primary,
            ),
            const SizedBox(
              height: 20,
            ),
            VariableText(
              value: "우리가 만드는 반려동물 캠퍼스",
              size: 22,
              color: dynamicColor.primary,
              wght: 400,
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInScreen()),
                    );
                  },
                  icon: Image.asset(
                    'assets/images/ic_google.png',
                    width: 30,
                    height: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInScreen()),
                    );
                  },
                  icon: Image.asset(
                    'assets/images/ic_naver.png',
                    width: 30,
                    height: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInScreen()),
                    );
                  },
                  icon: Image.asset(
                    'assets/images/ic_kakao.png',
                    width: 30,
                    height: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            InkWell(
              focusColor: dynamicColor.error,
              child: Container(
                  width: width * .6,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: dynamicColor.background,
                      boxShadow: [
                        BoxShadow(
                          color: dynamicColor.primary.withOpacity(0.4),
                          blurRadius: 5.0,
                          spreadRadius: 0.0,
                          offset: const Offset(0, 5),
                        )
                      ],
                      borderRadius: BorderRadius.circular(25)),
                  child: VariableText(
                    value: "Petmiliy 로그인",
                    size: 19,
                    wght: 400,
                    color: dynamicColor.primary,
                  )),
              onTap: () {
                // 회원가입 화면으로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInScreen()),
                );
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              child: Container(
                  width: width * .6,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: dynamicColor.background,
                      boxShadow: [
                        BoxShadow(
                          color: dynamicColor.primary.withOpacity(0.4),
                          blurRadius: 5.0,
                          spreadRadius: 0.0,
                          offset: const Offset(0, 5),
                        )
                      ],
                      borderRadius: BorderRadius.circular(25)),
                  child: VariableText(
                    value: "Petmiliy 계정 만들기",
                    size: 19,
                    wght: 400,
                    color: dynamicColor.primary,
                  )),
              onTap: () {
                // 회원가입 화면으로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
