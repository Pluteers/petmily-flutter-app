import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:petmily/screens/login_petmiliy_view.dart';
import 'package:petmily/main.dart';
import 'package:petmily/screens/signup_view.dart';
import 'package:petmily/widgets/variable_text.dart';
import 'package:provider/provider.dart';
import 'package:petmily/services/login_service.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: Scaffold(
        appBar: AppBar(),
        body: _LoginView(),
      ),
    );
  }
}

class _LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);
    final dynamicColor = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.all(16.0),
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
                          builder: (context) => const HomeWidget()),
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
                          builder: (context) => const LoginPetmiliyView()),
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
                          builder: (context) => const LoginPetmiliyView()),
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
            GestureDetector(
              child: Container(
                  width: width * .6,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
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
                  MaterialPageRoute(
                      builder: (context) => const LoginPetmiliyView()),
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
                      color: Colors.white,
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
                  MaterialPageRoute(builder: (context) => const SignupView()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
