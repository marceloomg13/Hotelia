import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hotelia/Data/data.dart';
import 'package:hotelia/screens/find_hotel_screen.dart';
import 'package:hotelia/widgets/hotel_Card.dart';
import 'package:gap/gap.dart';
import '../utils/Styles.dart';
import '../utils/app_layout.dart';


class hotelScreen extends StatefulWidget {
  final Map <String,dynamic> ticket;
  const hotelScreen({super.key, required this.ticket});

  @override
  State<hotelScreen> createState() => _hotelScreenState();
}

class _hotelScreenState extends State<hotelScreen> {
  final dialogController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Scaffold(
        appBar: AppBar(
        backgroundColor: AppColors.lowMirage,
        leading: BackButton(color: Colors.white,onPressed: () =>
        showCupertinoModalPopup(context: context, builder:
        (context) => const findHotels())),
        title:  Text(widget.ticket["nombre"],textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 20),),
            actions: [FloatingActionButton(
              backgroundColor: AppColors.mirage,
              foregroundColor: Colors.white,
              mini: true,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))
              ),
              onPressed: () => addFavourite(context),
              child: Icon(Icons.favorite),
            )]
        ),
    body:Container(
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [Container(
              height: size.height * 0.3,
              width: size.width,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(16),bottomLeft: Radius.circular(16)),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/hotel${widget.ticket["id"]}.jpg")
                  )
              ),
            ),
              Padding(
                padding: const EdgeInsets.only(bottom: 7,left: 7),
                child: Stack(children: [
                  Container(
                    height: 35,
                    width: 160,
                    decoration: BoxDecoration(
                      color: AppColors.lowMirage,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      children: [
                        RatingBarIndicator(
                          rating: widget.ticket["puntuacion"],
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 25.0,
                          unratedColor: Colors.amber.withAlpha(50),
                          direction:  Axis.horizontal,
                        ),
                        Text(widget.ticket["puntuacion"].toString(),style: TextStyle(color: Colors.white,fontSize: 20),)
                      ],
                    ),
                  ),
                ],
                ),
              ),
            ]
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(widget.ticket["descripcion"].toString(),style: TextStyle(color: Colors.white),),
          ),
          Container(
            height: 125,
            width: size.width *0.9,
              decoration: BoxDecoration(
                  color: AppColors.lowMirage,
                  border: Border.all(color: Colors.blueAccent),
                  borderRadius: BorderRadius.all(Radius.circular(
                      20.0))
              ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 15),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.bedroom_child_rounded),
                      Text("Individuales:${widget.ticket["camas"]["individuales"]}",style: TextStyle(color: Colors.white,fontSize: 16),),
                      Gap(100),
                      Icon(Icons.bedroom_parent_rounded),
                      Text("Dobles:${widget.ticket["camas"]["dobles"]}",style: TextStyle(color: Colors.white,fontSize: 16),),
                    ],
                  ),
                  Gap(25),
                  Row(
                    children: [
                      Icon(Icons.euro_rounded),
                      Text("Precio/noche:${widget.ticket["precio"]}€",style: TextStyle(color: Colors.white,fontSize: 16),),
                      Gap(65),
                      Icon(Icons.location_on_rounded),
                      Text("Ubicación",style: TextStyle(color: Colors.white,fontSize: 16),),
                    ],
                  )
                ],
              ),
            ),
          ),
          Gap(20),
          //TODO reservar hotel
          ElevatedButton(onPressed: () {},
            child: const Text(
              'Reservar', style: TextStyle(color: Colors.white),),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  AppColors.lowMirage),
              overlayColor: MaterialStateProperty.all(
                  Colors.lightBlue.shade300),
              side: MaterialStateProperty.all(BorderSide(color: Colors.blueAccent)),
              minimumSize: MaterialStateProperty.all(const Size(200, 40)),
            ),)
        ]
      ),
    )
    );
  }


  //TODO asignar tamaño fijo scrolleable
  addFavourite(context) {
      showCupertinoModalPopup(context: context, builder:
          (context) =>
      Material(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Guardar en...",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                Gap(15),
                Row(
                  children: [
                    FloatingActionButton(
                      backgroundColor: Colors.blueAccent.withOpacity(0.5),
                      foregroundColor: Colors.white,
                      mini: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0))
                      ),
                      onPressed: () => newListDialog(),
                      child: Icon(Icons.add),
                    ),
                    Gap(5),
                    Text("Nueva lista",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                  ],
                ),
                Gap(10),
                Divider(
                  height: 3,
                  indent: 5,
                  endIndent: 5,

                ),
                Column(
                  children: getList(),
                )
              ],
            ),
          ),
        ),
      )
      );
    setState(() {});
  }


  getList() {
    List<Widget> childs = [];
    for(var i=0;i<myFavourites.length;i++){
      childs.add(GestureDetector(
        onTap: (){
          var newEntry = [{"hotel_id":widget.ticket["id"],"nombre_hotel":widget.ticket["nombre"]}];
          var mylist = myFavourites[i]["hoteles"];
          for(var j in mylist){
            if(newEntry.first.toString() == j.toString()){
              Fluttertoast.showToast(msg: "Ya está en esta lista");
              print("ayiy");
            }else{
              Fluttertoast.showToast(msg: "Ha sido añadido");
              newEntry.add(j);
            }
          }
          myFavourites[i]["hoteles"] = newEntry;
          },
        child: ListTile(
          leading: Icon(Icons.favorite,color: Colors.blue),
          title: Text(myFavourites[i].entries.first.value,style: TextStyle(color: Colors.white,fontSize: 18),),
        ),
      )
      );
      childs.add(Divider(
        height: 3,
        indent: 5,
        endIndent: 5,

      ));
    }
    return childs;
  }

  Future newListDialog() => showDialog(

      context: context,
      builder: (context) => AlertDialog(
        title: Text("New list",style: TextStyle(color: Colors.white),),
        content: TextField(
          controller: dialogController,
          style: TextStyle(
              color: Colors.white
          ),
          decoration: InputDecoration(
              hintText: "Enter your list name"
          ),
        ),
        actions: [
          TextButton(
              onPressed: ()=> addList(),
              child: Text("SUBMIT"))
        ],
      )
  );

  addList() {
    if(dialogController.text.isNotEmpty) {
      myFavourites.add({"nombre": dialogController.text,
        "hoteles": {
          {"hotel_id":widget.ticket["id"],"nombre_hotel":widget.ticket["nombre"]}
        }
      });
      setState(() {});
      dialogController.clear();
      Navigator.pop(context);
    }
    else{
      Fluttertoast.showToast(msg: "Your list name is empty");
    }
  }

}


