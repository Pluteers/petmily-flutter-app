import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:petmily/utilities/dynamic_theme.dart';
import 'package:petmily/widgets/variable_text.dart';
import 'package:provider/provider.dart';

import 'package:petmily/services/auth_service.dart';
import 'package:petmily/screens/login_view.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController checkPasswordController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  String passwordText = "";

  @override
  Widget build(BuildContext context) {
    final dynamicColor = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<AuthService>(builder: (context, authService, child) {
      return Scaffold(
        body: SafeArea(
          child: Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            child: SingleChildScrollView(
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
                      totalRepeatCount: 1,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  /**회원가입 아이디 입력 */
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: SizedBox(
                      width: width * .9,
                      child: TextFormField(
                        controller: emailController,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: '이메일 형식 아이디를 입력하세요.',
                          labelText: '아이디',
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
                  ),

                  /**회원가입 닉네임 입력 */
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: SizedBox(
                      width: width * .9,
                      child: TextFormField(
                        controller: nicknameController,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: '사용할 닉네임을 입력하세요.',
                          labelText: '닉네임',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              nicknameController.clear();
                            },
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                  width: 1, color: dynamicColor.primary)),
                        ),
                      ),
                    ),
                  ),

                  /// 비밀번호
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: SizedBox(
                      width: width * .9,
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: '사용할 비밀번호를 입력하세요.',
                          labelText: '비밀번호',
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
                        onChanged: (value) {
                          setState(() {
                            passwordText = value;
                          });
                        },
                      ),
                    ),
                  ),
                  /**비밀번호 확인 */
                  passwordText == ""
                      ? SizedBox(height: 32)
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: SizedBox(
                            width: width * .9,
                            child: TextFormField(
                              controller: checkPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: '비밀번호 한번 더 입력하세요.',
                                labelText: '비밀번호 확인',
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    checkPasswordController.clear();
                                  },
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(
                                        width: 1, color: dynamicColor.primary)),
                              ),
                            ),
                          ),
                        ),

                  /// 회원가입 버튼
                  GestureDetector(
                    child: Container(
                        width: width * .5,
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
                          value: "회원가입",
                          size: 19,
                          wght: 400,
                          color: dynamicColor.primary,
                        )),
                    onTap: () {
                      if (emailController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("아이디를 입력해주세요!"),
                        ));
                      }
                      if (nicknameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("닉네임은 공백으로 사용할 수 없어요!"),
                        ));
                      }
                      if (passwordController.text !=
                          checkPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("입력한 비밀번호가 일치하지 않아요!"),
                        ));
                      } else {
                        // 회원가입 화면으로 이동
                        authService.signUp(
                          email: emailController.text,
                          nickname: nicknameController.text,
                          password: passwordController.text,
                          onSuccess: () {
                            // 로그인 성공
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("회원가입 성공"),
                            ));

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginView()),
                            );
                          },
                          onError: (err) {
                            // 에러 발생
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(err),
                            ));
                          },
                        );
                      }
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
