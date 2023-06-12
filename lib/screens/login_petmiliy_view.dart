import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:petmily/screens/login_view.dart';
import 'package:petmily/main.dart';
import 'package:petmily/screens/mypage_screens.dart';
import 'package:petmily/services/auth_service.dart';
import 'package:petmily/services/mypage_service.dart';
import 'package:petmily/widgets/variable_text.dart';
import 'package:provider/provider.dart';

class LoginPetmiliyView extends StatefulWidget {
  const LoginPetmiliyView({Key? key}) : super(key: key);

  @override
  State<LoginPetmiliyView> createState() => _LoginPetmiliyViewState();
}

class _LoginPetmiliyViewState extends State<LoginPetmiliyView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dynamicColor = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;
    return Consumer<AuthService>(builder: (context, authService, child) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: width,
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
                  SizedBox(
                    height: 30,
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText(
                          '우리가 만드는 반려동물 캠퍼스',
                          textStyle: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w400,
                            color: dynamicColor.primary,
                          ),
                          speed: const Duration(milliseconds: 100),
                        ),
                      ],
                      totalRepeatCount: 2,
                    ),
                  ),

                  const SizedBox(
                    height: 40.0,
                  ),

                  /// ID 입력 Form
                  SizedBox(
                    width: width * .9,
                    child: TextFormField(
                      controller: emailController,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: '이메일 형식 아이디를 입력하세요.',
                        labelText: '아이디',
                        labelStyle: TextStyle(color: dynamicColor.primary),
                        hintStyle: TextStyle(color: dynamicColor.primary),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            emailController.clear();
                          },
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                                width: 1, color: dynamicColor.primary)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  /// PW 입력 Form
                  SizedBox(
                    width: width * .9,
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: '비밀번호',
                        labelStyle: TextStyle(color: dynamicColor.primary),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            passwordController.clear();
                          },
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                                width: 1, color: dynamicColor.primary)),
                      ),
                    ),
                  ),

                  SizedBox(height: 32),
                  GestureDetector(
                    child: Container(
                        width: width * .5,
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
                          value: "로그인",
                          size: 19,
                          wght: 400,
                          color: dynamicColor.primary,
                        )),
                    onTap: () {
                      // 회원가입 화면으로 이동
                      authService.signIn(
                        email: emailController.text,
                        password: passwordController.text,
                        onSuccess: () {
                          // 로그인 성공
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("로그인 성공"),
                          ));

                          // HomePage로 이동
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyPageScreen()),
                          );
                        },
                        onError: (err) {
                          // 에러 발생
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(err),
                          ));
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
