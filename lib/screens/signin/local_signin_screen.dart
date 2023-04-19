import 'package:flutter/material.dart';
import 'package:petmily/screens/signin/petmily_signin_screen.dart';

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PetmilySigninScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
