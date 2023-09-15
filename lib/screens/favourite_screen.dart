import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelia/screens/add_favourite_screen.dart';

class favourite_screen extends StatefulWidget {
  const favourite_screen({super.key});

  @override
  State<favourite_screen> createState() => _favourite_screenState();
}

class _favourite_screenState extends State<favourite_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
            onPressed: () =>
                showCupertinoModalPopup(context: context, builder:
                    (context) => const addFavouriteScreen()),
            child: Icon(Icons.add),
          )],
        ),
      body: Container(

      ),
    );
  }
}
