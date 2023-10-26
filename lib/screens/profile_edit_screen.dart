import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelia/Data/data.dart';
import 'package:hotelia/screens/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'bottom_bar.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}


class _EditProfileState extends State<EditProfile> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void initState() {
    usernameController.text = profileData["nombre"];
    emailController.text = profileData["correo"];
    phoneController.text = profileData["telefono"];
    passwordController.text = profileData["contraseña"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent.withOpacity(0.5),
        leading: BackButton(onPressed: () =>
            showCupertinoModalPopup(context: context, builder:
            (context) => const BottomBar ())),
        title: const Text("Editar Perfil",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 20),),
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
                    style: TextStyle(color: Colors.white),
                    controller: usernameController,
                      decoration: InputDecoration(
                      border: OutlineInputBorder(),
                        labelStyle: TextStyle(
                          color: Colors.white
                        ),
                        hintStyle: TextStyle(color: Colors.grey),
                        labelText: 'Usuario',
                        hintText: 'Introduce tu usuario',
                        prefixIcon: Icon(Icons.person,color: Colors.white,),
                      ),
                    cursorColor: Colors.white,
                    ),
                  Gap(25),
                  TextField(
                    style: TextStyle(color: Colors.white),
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(
                          color: Colors.white
                      ),
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: 'Correo',
                      hintText: 'Introduce tu correo',
                      prefixIcon: Icon(Icons.mail,color: Colors.white,),
                    ),
                    cursorColor: Colors.white,
                  ),
                  Gap(25),
                  TextField(
                    style: TextStyle(color: Colors.white),
                    controller: phoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(
                          color: Colors.white
                      ),
                      labelText: 'Teléfono',
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: 'Introduce tu número de teléfono',
                      prefixIcon: Icon(Icons.phone,color: Colors.white,),
                    ),
                    cursorColor: Colors.white,
                  ),
                  Gap(25),
                  TextField(
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(
                          color: Colors.white
                      ),
                      labelText: 'Contraseña',
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: 'Introduce tu contraseña',
                      prefixIcon: Icon(Icons.fingerprint,color: Colors.white,),
                    ),
                    cursorColor: Colors.white,
                  ),
                  Gap(25),
                  SizedBox(
                      width:200,
                      child: ElevatedButton(onPressed: ()=>updateInfo(),
                      child: Text("Confirmar cambios"),
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

  updateInfo() async {
    profileData={
      "nombre":usernameController.text,
      "contraseña":passwordController.text,
      "telefono":phoneController.text,
      "correo":emailController.text
    };
    final user = FirebaseFirestore.instance.collection("Usuario");
    user.doc("1").set(profileData);
    Fluttertoast.showToast(msg: "Has actualizado tu perfil");
  }
}
