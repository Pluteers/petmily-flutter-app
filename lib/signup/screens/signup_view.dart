import 'package:flutter/material.dart';
import 'package:petmily/utilities/dynamic_theme.dart';
import 'package:provider/provider.dart';

import 'package:petmily/signup/services/auth_service.dart';
import 'package:petmily/login/screens/login_view.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dynamicColor = Theme.of(context).colorScheme;
    return Consumer<AuthService>(builder: (context, authService, child) {
      return Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  "회원 가입",
                  style: TextStyle(
                    fontSize: 24,
                    color: dynamicColor.primary,
                  ),
                ),
              ),
              SizedBox(height: 32),

              /// 이메일
              TextField(
                controller: emailController,
                decoration: InputDecoration(hintText: "e-mail"),
              ),

              /// 닉네임
              TextField(
                controller: nicknameController,
                decoration: InputDecoration(hintText: "nickname"),
              ),

              /// 비밀번호
              TextField(
                controller: passwordController,
                obscureText: false,
                decoration: InputDecoration(hintText: "password"),
              ),
              SizedBox(height: 32),

              /// 회원가입 버튼
              ElevatedButton(
                child: Text("가입 하기", style: TextStyle(fontSize: 21)),
                onPressed: () {
                  authService.signUp(
                    email: emailController.text,
                    nickname: nicknameController.text,
                    password: passwordController.text,
                    onSuccess: () {
                      // 회원가입 성공
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginView()),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Success!"),
                      ));
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
      );
    });
  }
}
