import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:petmily/providers/login_provider.dart';
import 'package:petmily/screens/local/signup_screen.dart';
import 'package:petmily/widgets/variable_text.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  Color? primaryColor;
  Color? onSurfaceColor;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 150.0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: VariableText(
            value: "이메일로 시작하기",
            size: 15.0,
            wght: 700,
            color: onSurfaceColor,
          ),
        ),
      ),
      body: Material(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: VariableText(
                      value: "로그인",
                      size: 35.0,
                      wght: 300.0,
                      color: onSurfaceColor),
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
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FilledButton(
                    onPressed: () async {
                      loginProvider.localLogin(
                        emailController.text,
                        passwordController.text,
                      );
                    },
                    child: loginProvider.loginStatus == LoginStatus.loading
                        ? const CircularProgressIndicator()
                        : const VariableText(
                            value: "확인",
                            wght: 500.0,
                            size: 20.0,
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                    onPressed: () async {
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                  create: (context) => LoginProvider(),
                                  child: const SignUpScreen(),
                                ),
                              ),
                            )
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                  create: (context) => LoginProvider(),
                                  child: const SignUpScreen(),
                                ),
                              ),
                            );
                    },
                    child: const VariableText(
                      value: "회원가입",
                      wght: 500.0,
                      size: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
