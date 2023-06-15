import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:provider/provider.dart';

import 'package:petmily/providers/login_provider.dart';
import 'package:petmily/screens/home.dart';
import 'package:petmily/screens/signup_screen.dart';
import 'package:petmily/widgets/snackbar_widget.dart';
import 'package:petmily/widgets/variable_text.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Color? primaryColor;
  Color? onSurfaceColor;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    primaryColor = Theme.of(context).colorScheme.primary;
    onSurfaceColor = Theme.of(context).colorScheme.onSurface;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginProvider loginProvider = Provider.of<LoginProvider>(context);
    final dynamicColor = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;

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
                  value: "Petmily",
                  size: 50,
                  wght: 700,
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
                        '우리가 만드는 반려동물 캔버스',
                        textStyle: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300,
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
                      hintText: "이메일 형식 아이디를 입력하세요.",
                      labelText: "아이디",
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
                const SizedBox(height: 10),
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
                        borderSide:
                            BorderSide(width: 1, color: dynamicColor.primary),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),
                GestureDetector(
                  child: Container(
                    width: width * .9,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: dynamicColor.primary,
                        boxShadow: [
                          BoxShadow(
                            color: dynamicColor.primary.withOpacity(0.4),
                            blurRadius: 5.0,
                            spreadRadius: 0.0,
                            offset: const Offset(0, 5),
                          )
                        ],
                        borderRadius: BorderRadius.circular(25)),
                    child: loginProvider.loginStatus == LoginStatus.loading
                        ? CircularProgressIndicator(
                            color: dynamicColor.primary,
                          )
                        : VariableText(
                            value: "로그인",
                            wght: 500.0,
                            size: 20.0,
                            color: dynamicColor.onPrimary,
                          ),
                  ),
                  onTap: () {
                    loginProvider.localLogin(
                      emailController.text,
                      passwordController.text,
                    );
                    // HomeScreen 페이지 이동.
                    if (loginProvider.loginStatus != LoginStatus.failed) {
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              ),
                              snackBar(context, "로그인 되었습니다.")
                            }
                          : {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              ),
                              snackBar(context, "로그인 되었습니다.")
                            };
                    }
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  child: Container(
                    width: width * .9,
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
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: VariableText(
                      value: "Petmily 계정 만들기",
                      size: 19,
                      wght: 400,
                      color: dynamicColor.primary,
                    ),
                  ),
                  onTap: () {
                    // 회원가입 화면으로 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
