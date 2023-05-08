import 'package:flutter/material.dart';

import 'package:petmily/login/screens/login_view.dart';
import 'package:petmily/main.dart';
import 'package:petmily/signup/services/auth_service.dart';
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
    return Consumer<AuthService>(builder: (context, authService, child) {
      return Scaffold(
        appBar: AppBar(title: Text("Login")),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  "Log in",
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

              /// 로그인 버튼
              ElevatedButton(
                child: Text("Log in", style: TextStyle(fontSize: 21)),
                onPressed: () {
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
                        MaterialPageRoute(builder: (context) => HomeWidget()),
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
      );
    });
  }
}
