import 'package:feelhope/View/loginScreen.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}
//importante
class _SplashscreenState extends State<Splashscreen> {
  @override

  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3));

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Loginscreen()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/FeelHope_texto_logo.png",),
            CircularProgressIndicator()
          ],
        )
      ),
    );
  }
}