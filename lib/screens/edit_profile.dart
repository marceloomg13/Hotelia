
import 'package:gap/gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelia/screens/profile_screen.dart';

import 'bottom_bar.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () =>
            showCupertinoModalPopup(context: context, builder:
            (context) => const BottomBar ())),
        title: const Text("Edit Profile",textAlign: TextAlign.center,style: TextStyle(color: Colors.grey,fontSize: 20),),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Center(
                  child: Stack(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),child: Image.asset('assets/images/Hotelia-logo.png'),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child:
                            Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.blueAccent),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.black,
                                size: 20,
                              ),
                            ))
                    ],
                  ),
                ),
              ),
              Gap(25),
              Form(child: Column(
                children: [
                  TextField(
                      decoration: InputDecoration(
                      border: OutlineInputBorder(),
                        labelStyle: TextStyle(
                          color: Colors.white
                        ),
                        labelText: 'User Name',
                        hintText: 'Enter Your Name',
                        prefixIcon: Icon(Icons.person,color: Colors.white,),
                      ),
                    cursorColor: Colors.white,
                    ),
                  Gap(25),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(
                          color: Colors.white
                      ),
                      labelText: 'E-mail',
                      hintText: 'Enter Your E-mail',
                      prefixIcon: Icon(Icons.mail,color: Colors.white,),
                    ),
                    cursorColor: Colors.white,
                  ),
                  Gap(25),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(
                          color: Colors.white
                      ),
                      labelText: 'Phone',
                      hintText: 'Enter Your Phone Number',
                      prefixIcon: Icon(Icons.phone,color: Colors.white,),
                    ),
                    cursorColor: Colors.white,
                  ),
                  Gap(25),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(
                          color: Colors.white
                      ),
                      labelText: 'Password',
                      hintText: 'Enter Your Password',
                      prefixIcon: Icon(Icons.fingerprint,color: Colors.white,),
                    ),
                    cursorColor: Colors.white,
                  ),
                  Gap(25),
                  SizedBox(
                      width:200,
                      child: ElevatedButton(onPressed: () {},
                      child: Text("Confirm changes"),
                      )
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
