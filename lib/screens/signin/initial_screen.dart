import 'package:flutter/material.dart';
import 'package:petmily/providers/account_validator.dart';
import 'package:petmily/widgets/variable_text.dart';
import 'package:provider/provider.dart';
import 'package:petmily/screens/signin/local_signin_screen.dart';
import 'package:petmily/screens/signup/signup_screen.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color surfaceColor = Theme.of(context).colorScheme.surface;

    return ChangeNotifierProvider(
      create: (context) => AccountValidator(),
      child: Scaffold(
        backgroundColor: surfaceColor,
        body: const InitialWidget(),
      ),
    );
  }
}

class InitialWidget extends StatefulWidget {
  const InitialWidget({super.key});

  @override
  State<InitialWidget> createState() => _InitialWidgetState();
}

class _InitialWidgetState extends State<InitialWidget> {
  @override
  Widget build(BuildContext context) {
    //final accountValidator = Provider.of<AccountValidator>(context);
    Color primaryColor = Theme.of(context).colorScheme.primary;
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LocalSigninScreen()),
                    );
                  },
                  icon: Image.asset(
                    'assets/images/ic_google.png',
                    width: 30,
                    height: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LocalSigninScreen()),
                    );
                  },
                  icon: Image.asset(
                    'assets/images/ic_naver.png',
                    width: 30,
                    height: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LocalSigninScreen()),
                    );
                  },
                  icon: Image.asset(
                    'assets/images/ic_kakao.png',
                    width: 30,
                    height: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              child: const VariableText(
                value: "Petmiliy계정으로 접속",
                size: 20.0,
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
            ElevatedButton(
              child: const VariableText(
                value: "Petmiliy계정 만들기",
                size: 20.0,
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
}
