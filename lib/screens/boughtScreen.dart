import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelia/Data/data.dart';
import 'package:hotelia/widgets/bought_card.dart';
import 'package:gap/gap.dart';
import 'package:hotelia/widgets/hotel_Card.dart';

class boughtScreen extends StatefulWidget {
  const boughtScreen({super.key});

  @override
  State<boughtScreen> createState() => _boughtScreenState();
}

class _boughtScreenState extends State<boughtScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.blueAccent.withOpacity(0.5),
        title: const Text("Mis Compras",style: TextStyle(color: Colors.white,fontSize: 20),textAlign: TextAlign.end,),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: getList(),
        ),
      ),
    );
  }
  getList() {
    List<Widget> childs = [];
    for(var i=0;i<boughtHotels.length;i++){
      childs.add(
        boughtCard(startDate: boughtHotels[i]["startDate"], price: boughtHotels[i]["price"], ticket: boughtHotels[i])
      );
      Gap(80);
      childs.add(Divider(
        height: 6,
        indent: 20,
        endIndent: 20,
      ),);
    }
    return childs;
  }


}
