import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Signup")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                "Sign up",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            SizedBox(height: 32),

            /// 이메일
            TextField(
              controller: emailController,
              decoration: InputDecoration(hintText: "e-mail"),
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
              child: Text("Sign up", style: TextStyle(fontSize: 21)),
              onPressed: () {
                // 회원가입
              },
            ),
          ],
        ),
      ),
    );
  }
}
