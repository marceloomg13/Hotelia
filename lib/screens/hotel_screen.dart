import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hotelia/Data/data.dart';
import 'package:hotelia/screens/bottom_bar.dart';
import 'package:hotelia/screens/map.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:gap/gap.dart';
import '../utils/Styles.dart';
import '../utils/app_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class hotelScreen extends StatefulWidget {
  final Map <String,dynamic> ticket;
  const hotelScreen({super.key, required this.ticket});

  @override
  State<hotelScreen> createState() => _hotelScreenState();
}

class _hotelScreenState extends State<hotelScreen> {
  late DateTime? _startDate, _endDate;
  final DateRangePickerController _controller = DateRangePickerController();
  final dialogController = TextEditingController();

  @override
  void initState() {
    final DateTime today = DateTime.now();
    _startDate = today;
    _endDate = _startDate;
    _controller.selectedRange = PickerDateRange(today, today.add(Duration(days: 3)));
    super.initState();
  }
  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      _startDate = args.value.startDate;
      _endDate = args.value.endDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Scaffold(
        appBar: AppBar(
        backgroundColor: AppColors.lowMirage,
        leading: BackButton(color: Colors.white,onPressed: () =>
        showCupertinoModalPopup(context: context, builder:
        (context) => const BottomBar())),
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
    body:SingleChildScrollView(
      child: Container(
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
                            rating: widget.ticket["puntuacion"]+.0,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.bedroom_child_rounded),
                            Text("Individuales:${widget.ticket["camas"]["individuales"]}",style: TextStyle(color: Colors.white,fontSize: 16),),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.bedroom_parent_rounded),
                            Text("Dobles:${widget.ticket["camas"]["dobles"]}",style: TextStyle(color: Colors.white,fontSize: 16),),
                          ],
                        ),
                      ],
                    ),
                    Gap(25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.euro_rounded),
                            Text("Precio/noche:${widget.ticket["precio"]}€",style: TextStyle(color: Colors.white,fontSize: 16),),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on_rounded),
                            GestureDetector(
                                onTap: () => showCupertinoModalPopup(context: context, builder: (context) => map(lat: widget.ticket["ubicacion"]["lat"],long:widget.ticket["ubicacion"]["long"] ,)),
                                child: Text("Ubicación",style: TextStyle(color: Colors.lightBlueAccent,fontSize: 16),)),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: AppColors.lowMirage,
                    border: Border.all(color: Colors.blueAccent)
                ),
                child: SfDateRangePicker(
                  enablePastDates: false,
                  selectionMode: DateRangePickerSelectionMode.range,
                  view: DateRangePickerView.month,
                  onSelectionChanged: _onSelectionChanged,
                  headerStyle: DateRangePickerHeaderStyle(
                    textStyle: TextStyle(
                      color:Colors.white
                    )
                  ),
                  monthViewSettings: DateRangePickerMonthViewSettings(
                      viewHeaderStyle: DateRangePickerViewHeaderStyle(
                          textStyle: TextStyle(
                              color: Colors.white)),
                    ),
                  monthCellStyle: DateRangePickerMonthCellStyle(
                    textStyle: TextStyle(
                      color: Colors.white
                    )
                  )
                ),
              ),
            ),
            //TODO reservar hotel
            ElevatedButton(
              onPressed: () => buyScreen(widget.ticket),
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
          final addToList = FirebaseFirestore.instance.collection("Favoritos");
          var newEntry = [];
          newEntry.add(widget.ticket);
          bool repeated = false;
          var mylist = myFavourites[i]["hoteles"];
          for(var j in mylist){
            if(newEntry.first["id"] == j["id"]){
              Fluttertoast.showToast(msg: "Ya está en esta lista");
              repeated = true;
              confirmDelete(i);
            }
            if(newEntry.first.toString() != j.toString() && repeated==false) {
              Fluttertoast.showToast(msg: "Ha sido añadido");
              newEntry.add(j);
            }
          }
          if(repeated == false){
            print("se añade");
            myFavourites[i]["hoteles"] = newEntry;
            addToList.doc(myFavourites[i]["list_id"].toString()).update(myFavourites[i]);
          }
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

  Future confirmDelete(int i) => showDialog(

      context: context,
      builder: (context) => AlertDialog(
        title: Text("¿Desea quitar el hotel de su lista?",style: TextStyle(color: Colors.white),),
        actions: [
          TextButton(
              onPressed: (){
                final removeFromList = FirebaseFirestore.instance.collection("Favoritos");
                var newEntry = [];
                myFavourites[i]["hoteles"];
                var mylist = myFavourites[i]["hoteles"];
                for(var j in mylist){
                    if(widget.ticket["id"] == j["id"]){
                    }else{
                      newEntry.add(j);
                    }
                }
                myFavourites[i]["hoteles"] = newEntry;
                removeFromList.doc(myFavourites[i]["list_id"].toString()).update(myFavourites[i]);
                Fluttertoast.showToast(msg: "Ha sido borrado con éxito");
                Navigator.pop(context);
              },
              child: Text("Yes")),
          TextButton(
              onPressed: (){Navigator.pop(context);},
              child: Text("No"))
        ],
      )
  );

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
    final addHotel = FirebaseFirestore.instance.collection("Favoritos");
    int new_id = myFavourites.last["list_id"]+1;
    var lista = {"nombre": dialogController.text,
      "list_id":new_id,
      "hoteles": [{
        "ubicacion":{
          "direccion":widget.ticket["ubicacion"]["direccion"],
          "lat":widget.ticket["ubicacion"]["lat"],
          "long":widget.ticket["ubicacion"]["long"]
        },
        "puntuacion": widget.ticket["puntuacion"],
        "precio": widget.ticket["precio"],
        "nombre": widget.ticket["nombre"].toString(),
        "id": widget.ticket["id"],
        "descripcion": widget.ticket["descripcion"].toString(),
        "camas": {
          "dobles": widget.ticket["camas"]["dobles"],
          "individuales": widget.ticket["camas"]["individuales"]
        }
      }]
    };

    if(dialogController.text.isNotEmpty) {
      myFavourites.add(lista);
      addHotel.doc(lista["list_id"].toString()).set(lista);
      setState(() {});
      dialogController.clear();
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Añadido a la nueva lista");
    }
    else{
      Fluttertoast.showToast(msg: "El nombre de la lista está vacío");
    }
  }

  buyScreen(Map<String, dynamic> ticket) {
    final size = AppLayout.getSize(context);
    if(_endDate != null && _endDate!=_startDate){
      int count = daysBetween(_startDate!, _endDate!);
      showCupertinoModalPopup(context: context, builder:
          (context) =>BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 15,left: 15,right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  child: Container(
                    width: size.width * 0.90,
                    height: size.height * 0.25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
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
                Container(
                  width: size.width * 0.90,
                  height: size.height * 0.30,
                  decoration: BoxDecoration(
                      color: AppColors.lowMirage,
                    border: Border.all(
                      color: Colors.blueAccent
                    )
                  ),
                  child: Material(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Fecha de llegada:",style: TextStyle(color: Colors.white,fontSize: 16)),
                              Text("${_startDate!.day}/${_startDate!.month}/${_startDate!.year}",style: TextStyle(color: Colors.white,fontSize: 16))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Fecha de salida:",style: TextStyle(color: Colors.white,fontSize: 16)),
                              Text("${_endDate!.day}/${_endDate!.month}/${_endDate!.year}",style: TextStyle(color: Colors.white,fontSize: 16))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Precio/noche: ",style: TextStyle(color: Colors.white,fontSize: 16)),
                              Text(ticket["precio"].toString()+"€",style: TextStyle(color: Colors.white,fontSize: 16))
                            ],
                          ),
                        ),
                        Divider(thickness: 1,indent: 15,endIndent: 15,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Precio total: ",style: TextStyle(color: Colors.white,fontSize: 16)),
                              Text((ticket["precio"]*count).toString()+"€",style: TextStyle(color: Colors.white,fontSize: 16))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Precio total(+IVA): ",style: TextStyle(color: Colors.white,fontSize: 16)),
                              Text((ticket["precio"]*count+(ticket["precio"]*count*0.21)).toString()+"€",style: TextStyle(color: Colors.white,fontSize: 16))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(20),
                ElevatedButton(
                  onPressed: () {
                    int dias = daysBetween(_startDate!, _endDate!);
                    var boughtHotel ={
                      "puntuacion":ticket["puntuacion"],
                      "precio":ticket["precio"].toString(),
                      "nombre":ticket["nombre"].toString(),
                      "id":ticket["id"],
                      "descripcion":ticket["descripcion"],
                      "camas":{
                        "dobles":ticket["camas"]["dobles"],
                        "individuales":ticket["camas"]["individuales"]
                      },
                      "ubicacion":{
                        "direccion":ticket["ubicacion"]["direccion"],
                        "lat":ticket["ubicacion"]["lat"],
                        "long":ticket["ubicacion"]["long"]
                      },
                      "price":((ticket["precio"]+(ticket["precio"]*0.21))*dias),
                      "startDate":"${_startDate!.day}/${_startDate!.month}/${_startDate!.year}",
                      "endDate":"${_endDate!.day}/${_endDate!.month}/${_endDate!.year}"
                    };
                    boughtHotels.add(boughtHotel);

                    final uploadBoughtQuery = FirebaseFirestore.instance.collection("Compras");
                    uploadBoughtQuery.add(boughtHotel);

                    showCupertinoModalPopup(context: context, builder:
                        (context) =>const BottomBar());
                  },
                  child: const Text(
                    'Pagar', style: TextStyle(color: Colors.white),),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        AppColors.lowMirage),
                    overlayColor: MaterialStateProperty.all(
                        Colors.lightBlue.shade300),
                    side: MaterialStateProperty.all(BorderSide(color: Colors.blueAccent)),
                    minimumSize: MaterialStateProperty.all(const Size(200, 40)),
                  ),)
              ],
            ),
          ),
        ),
      )
      );
    }else if(_endDate == null || _endDate==_startDate){
      showCupertinoModalPopup(context: context, builder:
          (context) =>BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 15,left: 15,right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  child: Container(
                    width: size.width * 0.90,
                    height: size.height * 0.25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
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
                Container(
                  width: size.width * 0.90,
                  height: size.height * 0.30,
                  decoration: BoxDecoration(
                      color: AppColors.lowMirage,
                    border: Border.all(
                      color: Colors.blueAccent
                    )
                  ),
                  child: Material(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Una sola noche:",style: TextStyle(color: Colors.white,fontSize: 16)),
                              Text("${_startDate!.day}/${_startDate!.month}/${_startDate!.year}",style: TextStyle(color: Colors.white,fontSize: 16))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Precio/noche:",style: TextStyle(color: Colors.white,fontSize: 16)),
                              Text(ticket["precio"].toString()+"€",style: TextStyle(color: Colors.white,fontSize: 16))
                            ],
                          ),
                        ),
                        Gap(35),
                        Divider(thickness: 1,indent: 15,endIndent: 15,),
                        Gap(15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Precio total: ",style: TextStyle(color: Colors.white,fontSize: 16)),
                              Text((ticket["precio"]).toString()+"€",style: TextStyle(color: Colors.white,fontSize: 16))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Precio total(+IVA): ",style: TextStyle(color: Colors.white,fontSize: 16)),
                              Text((ticket["precio"]+(ticket["precio"]*0.21)).toString()+"€",style: TextStyle(color: Colors.white,fontSize: 16))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Gap(20),
                ElevatedButton(
                  onPressed: () {
                    var boughtHotel ={
                      "puntuacion":ticket["puntuacion"],
                      "precio":ticket["precio"].toString(),
                      "nombre":ticket["nombre"].toString(),
                      "id":ticket["id"],
                      "descripcion":ticket["descripcion"],
                      "camas":{
                        "dobles":ticket["camas"]["dobles"],
                        "individuales":ticket["camas"]["individuales"]
                      },
                      "ubicacion":{
                        "direccion":ticket["ubicacion"]["direccion"],
                        "lat":ticket["ubicacion"]["lat"],
                        "long":ticket["ubicacion"]["long"]
                      },
                      "price":(ticket["precio"]+(ticket["precio"]*0.21)),
                      "startDate":"${_startDate!.day}/${_startDate!.month}/${_startDate!.year}",
                    };
                    boughtHotels.add(boughtHotel);

                    final uploadBoughtQuery = FirebaseFirestore.instance.collection("Compras");
                    uploadBoughtQuery.add(boughtHotel);

                    showCupertinoModalPopup(context: context, builder:
                        (context) =>const BottomBar());
                  },
                  child: const Text(
                    'Pagar', style: TextStyle(color: Colors.white),),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        AppColors.lowMirage),
                    overlayColor: MaterialStateProperty.all(
                        Colors.lightBlue.shade300),
                    side: MaterialStateProperty.all(BorderSide(color: Colors.blueAccent)),
                    minimumSize: MaterialStateProperty.all(const Size(200, 40)),
                  ),)
              ],
            ),
          ),
        ),
      )
      );
    }
  }
}


