import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height:  double.infinity,
        decoration: BoxDecoration(
            image: const DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage("assets/images/main-splash.gif")
            )
        ),
      ),
    );
  }
}
