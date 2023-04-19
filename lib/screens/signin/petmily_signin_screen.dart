import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:petmily/screens/signin/local_signin_screen.dart';
import 'package:petmily/screens/signup/signup_screen.dart';
import 'package:petmily/services/login_viewmodel.dart';

class PetmilySigninScreen extends StatelessWidget {
  const PetmilySigninScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: _LoginView(),
      ),
    );
  }
}

class _LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);

    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Petmiliy',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45.0),
            ),
            const Text(
              '우리가 만드는 반려동물 캔버스',
              style: TextStyle(fontSize: 22.0),
            ),
            const SizedBox(
              height: 60.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPetmiliyView()),
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
                          builder: (context) => const LoginPetmiliyView()),
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
                          builder: (context) => const LoginPetmiliyView()),
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
            SizedBox(height: 20.0),
            ElevatedButton(
              child: Text("Petmiliy 계정으로 접속", style: TextStyle(fontSize: 21)),
              onPressed: () {
                // 회원가입 화면으로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPetmiliyView()),
                );
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              child: Text("Petmiliy 계정 만들기", style: TextStyle(fontSize: 21)),
              onPressed: () {
                // 회원가입 화면으로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupView()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
