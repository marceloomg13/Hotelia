import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelia/screens/home_screen.dart';
import 'package:hotelia/screens/profile_screen.dart';
import 'package:hotelia/utils/Styles.dart';

import 'favourite_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),//const HomeScreen(),
    favourite_screen(), //const SearchScreen(),
    Container(), //const TicketScreen(),
    profile_screen(), //const ProfileScreen()
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex=index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child:_widgetOptions[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.mirage,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 10,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: const Color(0xFF526480),
        items: [
          BottomNavigationBarItem(icon: Icon(FluentSystemIcons.ic_fluent_home_regular),
              activeIcon:Icon(FluentSystemIcons.ic_fluent_home_filled),
              label: "home"
          ),
          BottomNavigationBarItem(icon: Icon(FluentSystemIcons.ic_fluent_heart_regular),
              activeIcon:Icon(FluentSystemIcons.ic_fluent_heart_filled)
              ,label: "search"),
          BottomNavigationBarItem(icon: Icon(FluentSystemIcons.ic_fluent_ticket_regular),
              activeIcon:Icon(FluentSystemIcons.ic_fluent_ticket_filled),
              label: "tickets"),
          BottomNavigationBarItem(icon: Icon(FluentSystemIcons.ic_fluent_person_regular),
              activeIcon:Icon(FluentSystemIcons.ic_fluent_person_filled),
              label: "profile")
        ],
      ),
    );
  }
}
