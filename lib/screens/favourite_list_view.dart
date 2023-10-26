import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelia/Data/data.dart';

import '../utils/Styles.dart';
import '../widgets/hotel_Card.dart';
import 'bottom_bar.dart';
import 'hotel_screen.dart';

class favourite_list_view extends StatelessWidget {
  final int pos;

  const favourite_list_view({super.key,required this.pos});

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
          children: getList(context),
        ),
      ),
    );
  }

  getList(context){
    List<Widget> childs = [];
    var mylist = myFavourites[pos]["hoteles"];
    for(var i in mylist){
      childs.add(
          GestureDetector(
              child: hotelCard(ticket: i),
              onTap: () => showCupertinoModalPopup(context: context, builder: (context) => hotelScreen(ticket: i),
              )
          )
      );
    }
    if(childs.isNotEmpty || childs == null){
      return childs;
    }else{
      childs.add(Text("Empty List"));
      return childs;
    }
  }
}
