

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hotelia/utils/Styles.dart';

import '../widgets/my_button.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key,required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signUserIn() async {
    showDialog(
        context: context,
        builder: (context){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
    );
    try{

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e){
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String error){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
              backgroundColor: Colors.deepPurple,
              title: Center(
                child: Text(
                    error,
                    style: const TextStyle(color: Colors.white)
                ),
              )
          );
        }
    );
  }
  void wrongPasswordMessage(){
    showDialog(
        context: context,
        builder: (context){
          return const AlertDialog(
            title: Text("Incorrect Password"),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mirage,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                Container(
                  padding: EdgeInsets.all(4), // Border width
                  decoration: BoxDecoration(color: Colors.blueAccent, shape: BoxShape.circle),
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(48), // Image radius
                      child: Image.asset('assets/images/Hotelia-logo.png'),
                    ),
                  ),
                ),

                const SizedBox(height: 50),

                Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: emailController,
                    decoration: InputDecoration(
                        prefixStyle: TextStyle(
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'email or username',
                        labelStyle: TextStyle(
                          color: Colors.white
                        ),
                        hintText: 'Enter valid email id as abc@gmail.com',
                        hintStyle: TextStyle(color: Colors.white)
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    controller: passwordController,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(),
                        labelText: 'password',
                        labelStyle: TextStyle(
                            color: Colors.white
                        ),
                        hintText: 'Enter valid email id as abc@gmail.com'),
                  ),
                ),

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                MyButton(
                  text: "Sign in",
                  onTap: signUserIn,
                ),

                const SizedBox(height: 35),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}