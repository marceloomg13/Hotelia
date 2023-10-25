import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelia/Data/data.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hotelia/screens/profile_screen.dart';


class favourite_screen extends StatefulWidget {
  const favourite_screen({super.key});

  @override
  State<favourite_screen> createState() => _favourite_screenState();
}

class _favourite_screenState extends State<favourite_screen> {
  final dialogController = TextEditingController();
  final menuController = MenuController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.blueAccent.withOpacity(0.5),
          title: const Text("Favourites",style: TextStyle(color: Colors.white,fontSize: 20),textAlign: TextAlign.end,),
          actions: [FloatingActionButton(
            backgroundColor: Colors.blueAccent.withOpacity(0.5),
            foregroundColor: Colors.white,
            mini: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0))
            ),
            onPressed: () => newListDialog(),
            child: Icon(Icons.add),
          )],
        ),
      body: SingleChildScrollView(
        child: Column(
         children: getList(),
        ),
      )
    );
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
             onPressed: ()=> addList(context),
             child: Text("SUBMIT"))
       ],
     )
 );

  getList() {
    List<Widget> childs = [];
    for(var i=0;i<myFavourites.length;i++){
        childs.add(GestureDetector(
          onTap: () => {

          },
          child: ListTile(
            leading: Icon(Icons.favorite,color: Colors.blue),
            title: Text(myFavourites[i].entries.first.value,style: TextStyle(color: Colors.white,fontSize: 18),),
            trailing: PopupMenuButton<String>(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.more_vert,color: Colors.white,),
              // Callback that sets the selected popup menu item.
              onSelected: (String item) {
                setState(() {
                  if(item == "Delete"){
                    deleteItem(myFavourites[i].entries.first.value);
                  }
                  else if(item == "Edit"){
                    dialogController.text=myFavourites[i].entries.first.value;
                    modifyDialog(myFavourites[i].entries.first.value);
                  }else{
                    //#TODO
                  }
                });
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: "Edit",
                  child: Text("Edit"),
                ),
                PopupMenuItem<String>(
                  value: "Delete",
                  child: Text('Delete'),
                ),
                const PopupMenuItem<String>(
                  value: "Share",
                  child: Text('Share'),
                ),
              ],
            ),
          ),
        )
        );
        childs.add(Divider(
          height: 6,
          indent: 20,
          endIndent: 20,
        ),);
    }
    return childs;
  }

  //TODO comprobar repetidos
  addList(context) {
    if(dialogController.text.isNotEmpty) {
      myFavourites.add({"nombre": dialogController.text,
        "hoteles": {
        }
      });
      setState(() {});
      dialogController.clear();
      Navigator.pop(context);
    }
    else{
      Fluttertoast.showToast(msg: "Your list name is empty");
    }
    print(myFavourites);
  }

  deleteItem(name) {
    print(name);
    for (var i = 0; i <= myFavourites.length-1; i++) {
      if(myFavourites[i].entries.first.value == name){
        myFavourites.removeAt(i);
        print(myFavourites);
      }
    }
    setState(() {});
  }

  Future modifyDialog(name) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Modify List Name",style: TextStyle(color: Colors.white),),
        content: TextField(
          controller: dialogController,
          style: TextStyle(
              color: Colors.white
          ),
          decoration: InputDecoration(
              hintText: "Enter the new name"
          ),
        ),
        actions: [
          TextButton(
              onPressed: ()=> modifyItem(name,dialogController.text,context),
              child: Text("MODIFY"))
        ],
      )
  );

  modifyItem(name,newName,context) {
    if(newName.toString().isNotEmpty){
    for(var item in myFavourites){
     if(item["name"]==name){
       item["name"] = newName;
     }
  }
    setState(() {});
    dialogController.clear();
    Navigator.pop(context);
  }else{
      Fluttertoast.showToast(msg: "The new name is empty");
    }
  }


}

