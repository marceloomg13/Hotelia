import 'package:hotelia/screens/auth_page.dart';
import 'package:hotelia/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:hotelia/utils/Styles.dart';
import 'package:google_fonts/google_fonts.dart' as fonts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Data/data.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});


  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {

  uploadData() async{
    var db = FirebaseFirestore.instance;
    var hotel = {
     "ubicacion":"Cadiz",
      "puntuacion":4.3,
      "precio":45,
      "nombre":"Hotel Victoria",
      "id":1,
      "descripcion":"lorem ipsum dolor...",
      "camas":{
       "dobles":1,
        "individuales":0
      }
    };
    db.collection("Hoteles").doc("13").set(hotel);
  }
  void initializeData() {
    final collectionQuery = FirebaseFirestore.instance.collection("Hoteles");

    collectionQuery.get().then((querySnapshot){
      for (var docSnapshot in querySnapshot.docs) {
        var ubicacion;
        var puntuacion;
        var precio;
        var nombre;
        var id;
        var descripcion;
        var dobles;
        var individuales;

        Map<String, dynamic> data = docSnapshot.data();

        Map<dynamic,dynamic> camas = data['camas'];

        ubicacion = data["ubicacion"].toString();
        puntuacion = data["puntuacion"];
        precio = data["precio"];
        nombre = data["nombre"].toString();
        id = data["id"];
        descripcion = data["descripcion"].toString();
        dobles = camas["dobles"].toString();
        individuales = camas["individuales"];

        var hotel = {
          "ubicacion":ubicacion,
          "puntuacion":puntuacion,
          "precio":precio,
          "nombre":nombre,
          "id":id,
          "descripcion":descripcion,
          "camas":{
            "dobles":dobles,
            "individuales":individuales
          }
        };
        hotels.add(hotel);
      }
    });
  }


  @override
  void initState() {
    super.initState();
    initializeData();
    //uploadData();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: AppColors.creamColor,
            brightness: Brightness.dark,
            background: AppColors.mirage,
          ),
          indicatorColor: AppColors.rawSienna,
          dividerColor: Colors.white54,
          textTheme: fonts.GoogleFonts.exo2TextTheme(),
        )
        ,
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
            splash: Splash(),
            splashIconSize: double.infinity,
            duration: 2000,
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: AppColors.mirage,
            nextScreen: AuthPage())
    );
  }
}
