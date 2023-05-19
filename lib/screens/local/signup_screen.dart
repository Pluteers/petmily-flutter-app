import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:petmily/providers/login_provider.dart';
import 'package:petmily/screens/initial_screen.dart';
import 'package:petmily/widgets/variable_text.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Color? onSurfaceColor;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    onSurfaceColor = Theme.of(context).colorScheme.onSurface;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginProvider loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 150.0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: VariableText(
            value: "회원가입",
            size: 15.0,
            wght: 700,
            color: onSurfaceColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: VariableText(
                value: "정보입력",
                size: 35.0,
                wght: 300.0,
                color: onSurfaceColor,
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "이메일",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.done,
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "비밀번호",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.done,
                controller: nicknameController,
                obscureText: false,
                decoration: InputDecoration(
                    hintText: "닉네임",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              child: const VariableText(value: "확인", size: 24.0, wght: 500.0),
              onPressed: () {
                loginProvider.localAuthenticator.signUp(
                  email: emailController.text,
                  nickname: nicknameController.text,
                  password: passwordController.text,
                );
                if (loginProvider.loginStatus == LoginStatus.success) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InitialScreen(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
