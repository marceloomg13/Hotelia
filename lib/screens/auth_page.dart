import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bottom_bar.dart';
import 'login_or_register.dart';




class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          //logeado
          if(snapshot.hasData){
            return BottomBar();
          }
          else{
            return LoginOrRegisterPage();
          }
          //deslogeado
        },
      ),
    );
  }
}
