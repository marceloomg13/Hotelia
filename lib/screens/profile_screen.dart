import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hotelia/screens/profile_edit_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotelia/screens/login_or_register.dart';
import 'package:hotelia/screens/login_page.dart';

class profile_screen extends StatefulWidget {
  const profile_screen({super.key});

  @override
  State<profile_screen> createState() => _profile_screenState();
}

void signOut(context){
  FirebaseAuth.instance.signOut();
  showCupertinoModalPopup(context: context, builder:
      (context) =>const LoginOrRegisterPage());
}

class _profile_screenState extends State<profile_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                alignment: AlignmentDirectional.topCenter,
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25)),
                    color: Color(0xff1e2c41)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Gap(20),
                    const Text("Perfil",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 20),),
                    Gap(20),
                    ClipOval(
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(48), // Image radius
                        child: Image.asset('assets/images/Hotelia-logo.png'),
                      ),
                    ),
                      const Gap(8),
                      const Text("Marcelo Sánchez Macías",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                      const Text("marcelo@gmail.com",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 16),),
                      const Gap(8),
                      SizedBox(
                          width:200,
                          child: ElevatedButton(onPressed: () => showCupertinoModalPopup(context: context, builder:
                          (context) => EditProfile()), child: Text("Edit Profile")))
                  ],
                ),
              ),
              Gap(20),
              Gap(5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blueAccent.withOpacity(0.5)
                    ),
                    child: Icon(Icons.payments,color: Colors.white,),
                  ),
                  title: Text("Ajustes de Pago",style: TextStyle(color: Colors.white,fontSize: 20)),
                  trailing: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey.withOpacity(0.5)
                    ),
                    child: Icon(Icons.arrow_right,color: Colors.grey,),
                  ),
                ),
              ),
              Gap(5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: ()=>{
                  showCupertinoModalPopup(context: context, builder: (context) => infoScreen()),
                  },
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.blueAccent.withOpacity(0.5)
                      ),
                      child: Icon(Icons.info,color: Colors.white,),
                    ),
                    title: Text("Information",style: TextStyle(color: Colors.white,fontSize: 20)),
                    trailing: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey.withOpacity(0.5)
                      ),
                      child: Icon(Icons.arrow_right,color: Colors.grey,),
                    ),
                  ),
                ),
              ),
              Gap(15),
              Divider(
                indent: 20,
                endIndent: 20,
              ),
              Gap(15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: ()=>signOut(context),
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.blueAccent.withOpacity(0.5)
                      ),
                      child: Icon(Icons.logout,color: Colors.white,),
                    ),
                    title: Text("Salir",style: TextStyle(color: Colors.red,fontSize: 20)),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  infoScreen() {
   return Scaffold(
     appBar: AppBar(
       centerTitle: true,
       backgroundColor: Colors.blueAccent.withOpacity(0.5),
       title: const Text("Información",style: TextStyle(color: Colors.white,fontSize: 20),textAlign: TextAlign.end,),
     ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Text("Descripción:\n\n"
          "Hotelia es una aplicación móvil que facilita la búsqueda, comparación y reserva de hoteles en todo el mundo. Ofrece una amplia selección de opciones, reseñas de usuarios y ofertas exclusivas.\n\n\n"+
          "Características Principales:\n\n"

          "Búsqueda intuitiva y reservas personalizadas."
          "Comparación de precios y reseñas de hoteles."
          "Ofertas especiales y promociones para usuarios."
          "Gestión sencilla de reservas existentes."
          "Plataformas: Disponible en iOS y Android para smartphones y tabletas.\n\n"

          "Servicio al Cliente: Soporte 24/7 a través de chat, correo electrónico y llamadas."

          ,style: TextStyle(color: Colors.white,fontSize: 16),),
    )
   );
  }
}
