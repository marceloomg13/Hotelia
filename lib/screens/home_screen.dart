import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelia/Data/data.dart';
import 'package:hotelia/screens/find_hotel_screen.dart';
import 'package:hotelia/screens/splash.dart';
import 'package:hotelia/utils/Styles.dart';
import 'package:gap/gap.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

//actt

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();
  final dateInController = TextEditingController();
  final dateOutController = TextEditingController();

  void findQuery(TextEditingController searchController,context) async{
    temporalHotels.clear();
    var db = FirebaseFirestore.instance;
    var hotelIDNumber = [];

    db.collection("Hoteles").where('ubicacion', isEqualTo: searchController.text).get().then(
          (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = docSnapshot.data();
          for (var i = 0; i <= hotels.length-1; i++) {
            if (data['id'].toString() == hotels[i]['id'].toString()) {
              hotelIDNumber.add(i);
              print(i);
            } else {
              print("false");
            }
          }
        }
        for(var i in hotelIDNumber) {
          temporalHotels.add(hotels[i]);
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    showCupertinoModalPopup(context: context, builder:
        (context) => AnimatedSplashScreen(
        splash: Splash(),
        splashIconSize: double.infinity,
        duration: 500,
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: findHotels()));
  }


  @override
  void initState() {
    dateInController.text = "";
    dateOutController.text = "";
  }

  @override
  Widget build(BuildContext context) {
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
                  padding: const EdgeInsets.only(right: 10, top: 15),
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                  controller: dateInController,
                  readOnly: true,
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
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      prefixIcon: Icon(Icons.calendar_today),
                      //icon of text field
                      hintText: "Dia de llegada"
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        //get today's date
                        firstDate: DateTime.now(),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101)
                    );
                    if (pickedDate != null) {
                      print(
                          pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                      String formattedDate = DateFormat('yyyy-MM-dd').format(
                          pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                      print(
                          formattedDate); //formatted date output using intl package =>  2022-07-04
                      //You can format date as per your need
                      setState(() {
                        dateInController.text =
                            formattedDate; //set foratted date to TextField value.
                      });
                    } else {
                      print("Date is not selected");
                    }
                  }
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: TextField(
                  controller: dateOutController,
                  readOnly: true,
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
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      prefixIcon: Icon(Icons.calendar_today),
                      //icon of text field
                      hintText: "Dia de ida"
                  ),
                  onTap: () async {
                    if (dateInController.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Debe especificar el día de llegada");
                    }
                    else {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.parse(dateInController.text),
                          //get today's date
                          firstDate: DateTime.parse(dateInController.text),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101)
                      );
                      if (pickedDate != null) {
                        print(
                            pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                        String formattedDate = DateFormat('yyyy-MM-dd').format(
                            pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                        print(
                            formattedDate); //formatted date output using intl package =>  2022-07-04
                        //You can format date as per your need
                        setState(() {
                          dateOutController.text =
                              formattedDate; //set foratted date to TextField value.
                        });
                      } else {
                        print("Date is not selected");
                      }
                    }
                  }
              ),
            ),
            ElevatedButton(onPressed: () => findQuery(searchController,context),
              child: const Text(
                'Buscar', style: TextStyle(color: Colors.black),),
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(
                    Colors.blueAccent),
                minimumSize: MaterialStateProperty.all(const Size(200, 40)),
              ),),
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
                              Text("data", style: TextStyle(fontSize: 25),),
                              Text(
                                "this is an extended data that should fit the container propperly",
                                style: TextStyle(fontSize: 16),)
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
                              Text("data", style: TextStyle(
                                  fontSize: 25, color: Colors.white),),
                              Text(
                                "this is an extended data that should fit the container propperly",
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
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 15.0, right: 15, bottom: 15),
                      child: Container(
                        width: 170,
                        height: 190,
                        decoration: BoxDecoration(
                            color: Colors.blueAccent
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 15, bottom: 15),
                      child: Container(
                        width: 170,
                        height: 240,
                        decoration: BoxDecoration(
                            color: Colors.purple
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
                        width: 170,
                        height: 240,
                        decoration: BoxDecoration(
                            color: Colors.red
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15, bottom: 15),
                      child: Container(
                        width: 170,
                        height: 190,
                        decoration: BoxDecoration(
                            color: Colors.yellow
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
}