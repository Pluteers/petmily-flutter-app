import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:petmily/providers/local_authenticator.dart';
import 'package:petmily/screens/signin/local_signin_screen.dart';
import 'package:petmily/screens/signup/signup_screen.dart';
import 'package:petmily/widgets/variable_text.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color surfaceColor = Theme.of(context).colorScheme.surface;

    return ChangeNotifierProvider(
      create: (context) => LocalAuthenticator(),
      child: Scaffold(
        backgroundColor: surfaceColor,
        body: const InitialContentWidget(),
      ),
    );
  }
}

class InitialContentWidget extends StatefulWidget {
  const InitialContentWidget({super.key});

  @override
  State<InitialContentWidget> createState() => _InitialContentWidgetState();
}

class _InitialContentWidgetState extends State<InitialContentWidget> {
  Color? primaryColor;
  Image? googleIcon;
  Image? naverIcon;
  Image? kakaoIcon;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    primaryColor = Theme.of(context).colorScheme.primary;
    googleIcon = Image.asset("assets/images/ic_google.png");
    naverIcon = Image.asset("assets/images/ic_naver.png");
    kakaoIcon = Image.asset("assets/images/ic_kakao.png");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            VariableText(
              value: "Petmiliy",
              size: 45.0,
              wght: 700.0,
              color: primaryColor,
            ),
            VariableText(
              value: "우리가 만드는 반려동물 캔버스",
              size: 20.0,
              wght: 300.0,
              color: primaryColor,
            ),
            const SizedBox(height: 60.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  constraints:
                      const BoxConstraints(maxWidth: 40.0, maxHeight: 40.0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LocalSigninScreen(),
                      ),
                    );
                  },
                  icon: googleIcon!,
                ),
                IconButton(
                  constraints:
                      const BoxConstraints(maxWidth: 40.0, maxHeight: 40.0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LocalSigninScreen(),
                      ),
                    );
                  },
                  icon: naverIcon!,
                ),
                IconButton(
                  constraints:
                      const BoxConstraints(maxWidth: 40.0, maxHeight: 40.0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LocalSigninScreen(),
                      ),
                    );
                  },
                  icon: kakaoIcon!,
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            OutlinedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              child: const VariableText(
                value: "Petmiliy 계정으로 로그인",
                size: 15.0,
                wght: 400.0,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LocalSigninScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20.0),
            OutlinedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              child: const VariableText(
                value: "Petmiliy 계정 생성하기",
                size: 15.0,
                wght: 400.0,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignupScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
