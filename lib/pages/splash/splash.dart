import 'dart:async';
import 'package:flutter/material.dart';
import '../home/home.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 2),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => HomePage(),
        ),
      ),
    );
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage(
            "assets/images/preloader.gif",
          ),
        ),
      ),
    );
  }
}
