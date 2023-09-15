import 'package:hotelia/screens/register_page.dart';
import 'package:flutter/cupertino.dart';


import 'login_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({Key? key}) : super(key: key);

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  @override
  bool showLoginPage = true;

  void toglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  Widget build(BuildContext context) {
    if (showLoginPage){
      return LoginPage(onTap: toglePages);
    }else{
      return RegisterPage(onTap: toglePages);
    }
  }
}
