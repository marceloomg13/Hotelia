import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelia/utils/Styles.dart';

import '../Data/data.dart';
import '../widgets/hotel_Card.dart';
import 'bottom_bar.dart';
import 'hotel_screen.dart';

class findHotels extends StatefulWidget {
  const findHotels({super.key});

  @override
  State<findHotels> createState() => _findHotelsState();
}

class _findHotelsState extends State<findHotels> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.lowMirage,
        leading: BackButton(color: Colors.white,onPressed: () =>
            showCupertinoModalPopup(context: context, builder:
                (context) => const BottomBar ())),
        title: const Text("Hotels",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 20),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: getList(),
        ),
      ),
    );
  }

  getList(){
    List<Widget> childs = [];
    for(var i=0;i<temporalHotels.length;i++){
      childs.add(
          GestureDetector(
              child: hotelCard(ticket: temporalHotels[i]),
              onTap: () => showCupertinoModalPopup(context: context, builder: (context) => hotelScreen(ticket: temporalHotels[i]),
          )
      )
      );
    }
    setState(() {});

    return childs;
  }
}


