import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelia/Data/data.dart';
import 'package:hotelia/screens/find_hotel_view.dart';
import 'package:hotelia/screens/splash.dart';
import 'package:hotelia/utils/Styles.dart';
import 'package:gap/gap.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'dart:core';

import '../utils/app_layout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Scaffold(
      backgroundColor: AppColors.mirage,
      body: ListView(
        children: [Column(
          children: [
            const Gap(40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(style: Styles.headLineStyle3,
                              "Bienvenido a Hotelia"),
                          Text(style: Styles.headLineStyle2,
                              "Encuentra las mejores ofertas")
                        ]
                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 28, top: 15),
                  child: Container(
                    padding: EdgeInsets.all(4), // Border width
                    decoration: BoxDecoration(
                        color: Colors.blueAccent, shape: BoxShape.circle),
                    child: ClipOval(
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(36), // Image radius
                        child: Image.asset('assets/images/Hotelia-logo.png'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Gap(15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Encuentra tu Hotel ideal", textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.white, fontSize: 20),)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        //<-- SEE HERE
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Encuentra tu hotel",
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      prefixIcon: Icon(Icons.location_on)
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: () => findQuery(searchController,context),
                child: const Text(
                  'Buscar', style: TextStyle(color: Colors.black),),
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                      Colors.blueAccent),
                  minimumSize: MaterialStateProperty.all(const Size(200, 40)),
                ),),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Viaja más por menos", textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.white, fontSize: 20),)),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Container(
                        height: 175,
                        width: 225,
                        decoration: BoxDecoration(
                            color: Color(0xff024fb4),
                            borderRadius: BorderRadius.all(Radius.circular(
                                20.0))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Nivel 1 Hotelia", style: TextStyle(fontSize: 25,color: Colors.white ),),
                              Gap(10),
                              Text(
                                "Este es tu nivel de Hotelia alcanza mayores niveles para obtener los mejores descuentos",
                                style: TextStyle(fontSize: 16,color: Colors.white),)
                            ],
                          ),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Container(
                        height: 175,
                        width: 225,
                        decoration: BoxDecoration(
                            color: Color(0xbe000000),
                            border: Border.all(color: Colors.blueAccent),
                            borderRadius: BorderRadius.all(Radius.circular(
                                20.0))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Nivel 2 Hotelia", style: TextStyle(
                                  fontSize: 25, color: Colors.white),),
                              Gap(10),
                              Text(
                                "Obtén hasta un 15% de descuento en los mejores hoteles",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),)
                            ],
                          ),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Container(
                        height: 175,
                        width: 225,
                        decoration: BoxDecoration(
                            color: Color(0xbe000000),
                            border: Border.all(color: Colors.blueAccent),
                            borderRadius: BorderRadius.all(Radius.circular(
                                20.0))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Nivel 3 Hotelia", style: TextStyle(
                                  fontSize: 25, color: Colors.white),),
                              Gap(10),
                              Text(
                                "Desayunos gratis en Hoteles seleccionados",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),)
                            ],
                          ),
                        )
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Más para ti", textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.white, fontSize: 20),)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween
              ,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 15.0, right: 15, bottom: 15),
                      child: Container(
                        width: size.width * 0.4,
                        height: size.height * 0.33,
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: AssetImage("assets/images/home2.jpg")
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 15, bottom: 15),
                      child: Container(
                        width: size.width * 0.4,
                        height: size.height * 0.3,
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: AssetImage("assets/images/home3.jpg")
                            )
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15.0, right: 15, bottom: 15),
                      child: Container(
                        width: size.width * 0.4,
                        height: size.height * 0.3,
                        decoration: BoxDecoration(
                            color: Colors.red,
                          image: DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: AssetImage("assets/images/home1.jpg")
                          )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15, bottom: 15),
                      child: Container(
                        width: size.width * 0.4,
                        height: size.height * 0.33,
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: AssetImage("assets/images/home4.jpg")
                            )
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        )
        ],
      ),
    );
  }

  void findQuery(TextEditingController searchController,context) async{
    temporalHotels.clear();
    var db = FirebaseFirestore.instance;
    var hotelIDNumber = [];

    var querySize=0;

    db.collection("Hoteles").where('ubicacion.direccion', isEqualTo: searchController.text).get().then(
          (querySnapshot) {
        querySize = querySnapshot.size;
        for (var docSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = docSnapshot.data();
          for (var i = 0; i <= hotels.length-1; i++) {
            if (data['id'].toString() == hotels[i]['id'].toString()) {
              hotelIDNumber.add(i);
            } else {
            }
          }
        }
        for(var i in hotelIDNumber) {
          temporalHotels.add(hotels[i]);
        }
        print(querySize);
        if(querySize > 0){
          showCupertinoModalPopup(context: context, builder:
              (context) => AnimatedSplashScreen(
              splash: Splash(),
              splashIconSize: double.infinity,
              duration: 500,
              splashTransition: SplashTransition.fadeTransition,
              nextScreen: findHotels()));
        }else if(querySize==0){
          Fluttertoast.showToast(msg: "No ha sido encontrado");
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
}