import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class addFavouriteScreen extends StatelessWidget {
  const addFavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
        backdropEnabled: true,
        panel: Center(
          child: Text("This is the sliding Widget"),
        ),
        body: Scaffold(
          appBar: AppBar(
            title: Text("SlidingUpPanelExample"),
        ),
            body:  Center(
              child: Text("This is the Widget behind the sliding panel"),
        ),
        )
      );
  }
}
