import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:petmily/services/authentication.dart';
import 'package:petmily/screens/signin/petmily_signin_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
