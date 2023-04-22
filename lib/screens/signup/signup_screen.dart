import 'package:flutter/material.dart';
import 'package:petmily/screens/signin/initial_screen.dart';
import 'package:petmily/widgets/variable_text.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: VariableText(value: "회원가입", size: 24.0, wght: 300.0),
            ),

            const SizedBox(height: 32.0),

            //TODO: Global key 필요해요.
            Form(
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    obscureText: true,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: false,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32.0),

            /// 회원가입 버튼
            ElevatedButton(
              child: const VariableText(value: "등록하기", size: 24.0, wght: 500.0),
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

class CustomTextFormFieldWidget extends StatelessWidget {
  const CustomTextFormFieldWidget({
    Key? key,
    this.labelText,
    this.hintText,
    this.errorText,
    required this.controller,
    required this.textInputType,
    required this.validater,
  }) : super(key: key);

  final String? labelText;
  final String? hintText;
  final String? errorText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final String? Function(String?) validater;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        validator: validater,
        obscureText: false,
        decoration: InputDecoration(
          labelText: labelText ?? "",
          errorText: errorText ?? "",
          hintText: hintText ?? "",
        ),
      ),
    );
  }
}
