import 'package:hotelia/screens/auth_page.dart';
import 'package:hotelia/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:hotelia/utils/Styles.dart';
import 'package:google_fonts/google_fonts.dart' as fonts;
import 'package:cloud_firestore/cloud_firestore.dart';
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
      "puntuacion":4.3,
      "precio":45,
      "nombre":"Hotel Victoria",
      "id":1,
      "descripcion":"lorem ipsum dolor...",
      "camas":{
       "dobles":1,
        "individuales":0
      },
      "ubicacion":{
        "direccion":"Cadiz",
       "lat":36.534477,
        "long":-6.305920
      }
    };
    var favourite =
    {"nombre":"Hoteles Madrid",
      "list_id":1,
      "hoteles":[
        {
          "puntuacion":3.4,
          "precio":20,
          "nombre":"Hotel Paraíso",
          "id":2,
          "descripcion":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
          "camas":{
            "dobles":0,
            "individuales":1
          },
          "ubicacion":{
            "direccion":"Madrid",
            "lat":40.447438,
            "long":-3.704108
          }
        },
        {
          "puntuacion":2.9,
          "precio":25,
          "nombre":"Hotel Marbella",
          "id":3,
          "descripcion":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque tristique finibus nisl, ut dictum est gravida id. Mauris id sodales tellus. Suspendisse et ultricies magna, at malesuada arcu. Pellentesque varius odio ut dictum ullamcorper. Aliquam erat volutpat. Proin congue metus ut eros blandit, vel blandit augue bibendum. Cras pellentesque congue diam, non consequat tellus bibendum et. Nam sed elementum sapien.",
          "camas":{
            "dobles":0,
            "individuales":2
          },
          "ubicacion":{
            "direccion":"Madrid",
            "lat":40.391946,
            "long":-3.696019
          }
        }
    ]
    }
    ;
    //db.collection("Hoteles").doc("13").set(hotel);
    db.collection("Favoritos").doc("1").set(favourite);
  }

  void initializeHotel() {
    final hotelQuery = FirebaseFirestore.instance.collection("Hoteles");

    hotelQuery.get().then((querySnapshot){
      for (var docSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data = docSnapshot.data();
        hotels.add(data);
        print("hotel done!");
      }
    });
  }
  void initializeFavourite(){
    final favouriteQuery = FirebaseFirestore.instance.collection("Favoritos");

    favouriteQuery.get().then((querySnapshot){
      for (var docSnapshot in querySnapshot.docs) {

        Map<String, dynamic> data = docSnapshot.data();

        var nombreLista = data["nombre"].toString();
        var list_id = data["list_id"];
        var favorito = {"nombre":nombreLista,
          "list_id":list_id,
          "hoteles":[
          ]
        };
        var hotelesAdd = [];
        List<dynamic> hoteles = data["hoteles"];
        for(var i in hoteles){
          hotelesAdd.add(i);
        }
        favorito["hoteles"]=hotelesAdd;
        myFavourites.add(favorito);
      }
      print("favourite done!");
    });
  }

  void initializeProfile(){
    final userQuery = FirebaseFirestore.instance.collection("Usuario");
    userQuery.get().then((querySnapshot){
      for (var docSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data = docSnapshot.data();
        profileData = data;
      }
    });
  }
  void initializeBought(){
    final boughtQuery = FirebaseFirestore.instance.collection("Compras");
    boughtQuery.get().then((querySnapshot){
      for (var docSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data = docSnapshot.data();
        boughtHotels.add(data);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    //uploadData();
    initializeFavourite();
    initializeHotel();
    initializeProfile();
    initializeBought();
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
