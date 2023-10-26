import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/Styles.dart';
import 'package:gap/gap.dart';
import '../utils/app_layout.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class hotelCard extends StatelessWidget {
  final Map <String,dynamic> ticket;
  const hotelCard({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 15,left: 15,right: 15),
        child: Container(
          width: size.width * 0.90,
          height: size.height * 0.25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: Colors.blueAccent,width: 3),
              color: Color(0xff1b3041)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: size.height * 0.241,
                        width: size.width * 0.40,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(16),bottomLeft: Radius.circular(16)),
                            image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: AssetImage("assets/images/hotel${ticket["id"]}.jpg")
                            )
                        ),
                      ),
                    ]
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10,top: 5),
                        child: Text(ticket["nombre"],style: TextStyle(color: Colors.white,fontSize: 20),),
                      ),
                    ],
                  ),
                  Gap(20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on),
                          Text(ticket["ubicacion"]["direccion"],style: TextStyle(color: Colors.white,fontSize: 16)),
                        ],
                      ),
                      Text(ticket["precio"].toString() + "€/noche",style: TextStyle(color: Colors.white,fontSize: 16)),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5,right: 10),
                        child: RatingBarIndicator(
                          rating: ticket["puntuacion"]+.0,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 25.0,
                          unratedColor: Colors.amber.withAlpha(50),
                          direction:  Axis.horizontal,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}



