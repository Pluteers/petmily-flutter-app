import 'package:flutter/material.dart';
import 'package:petmily/screens/signin/initial_screen.dart';

class LocalSigninScreen extends StatefulWidget {
  const LocalSigninScreen({Key? key}) : super(key: key);

  @override
  State<LocalSigninScreen> createState() => _LocalSigninScreenState();
}

class _LocalSigninScreenState extends State<LocalSigninScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Text(
                "Log in",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(height: 32),

            /// 이메일
            TextField(
              controller: emailController,
              decoration: const InputDecoration(hintText: "e-mail"),
            ),

            /// 비밀번호
            TextField(
              controller: passwordController,
              obscureText: false,
              decoration: const InputDecoration(hintText: "password"),
            ),
            const SizedBox(height: 32),

            /// 로그인 버튼
            ElevatedButton(
              child: const Text("Log in", style: TextStyle(fontSize: 21)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InitialScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
