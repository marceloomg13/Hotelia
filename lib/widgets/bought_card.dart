import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelia/widgets/hotel_Card.dart';
import 'package:gap/gap.dart';
import '../utils/app_layout.dart';

class boughtCard extends StatelessWidget {
  final startDate;
  final DateTime? endDate;
  final double price;
  final Map <String,dynamic> ticket;
  const boughtCard({super.key,this.endDate, required this.startDate, required this.price, required this.ticket});

  addHotel(){

  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Column(
      children: [
        Material(child: hotelCard(ticket: ticket)),
        Gap(15),
        Container(
          width: size.width * 0.90,
          height: size.height * 0.15,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: Colors.blueAccent,width: 3),
              color: Color(0xff1b3041)
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8,left: 15,right: 15,bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Precio total(+IVA)",style: TextStyle(color: Colors.white,fontSize: 16)),
                    Text(price.toString(),style: TextStyle(color: Colors.white,fontSize: 16))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Fecha de llegada: ",style: TextStyle(color: Colors.white,fontSize: 16)),
                    Text(ticket["startDate"],style: TextStyle(color: Colors.white,fontSize: 16))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                child: Container(
                    child: ticket["endDate"]==null? Center(child: Text("-------------------------------------------",style: TextStyle(color: Colors.white),)):Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text("Fecha de salida:",style: TextStyle(color: Colors.white,fontSize: 16)),
                  Text(ticket["endDate"],style: TextStyle(color: Colors.white,fontSize: 16))
                ],)),
              ),
            ],
          ),
        )
      ],
    );
  }
}
