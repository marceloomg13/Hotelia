import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hotelia/screens/edit_profile.dart';
import 'package:hotelia/widgets/favourite_box.dart';

class profile_screen extends StatefulWidget {
  const profile_screen({super.key});

  @override
  State<profile_screen> createState() => _profile_screenState();
}

class _profile_screenState extends State<profile_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                alignment: AlignmentDirectional.topCenter,
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25)),
                    color: Color(0xff1e2c41)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Gap(20),
                    const Text("Profile",textAlign: TextAlign.center,style: TextStyle(color: Colors.grey,fontSize: 20),),
                    Gap(20),
                    ClipOval(
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(48), // Image radius
                        child: Image.asset('assets/images/Hotelia-logo.png'),
                      ),
                    ),
                      const Gap(8),
                      const Text("Marcelo Sánchez Macías",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                      const Text("marcelo@gmail.com",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 16),),
                      const Gap(8),
                      SizedBox(
                          width:200,
                          child: ElevatedButton(onPressed: () => showCupertinoModalPopup(context: context, builder:
                          (context) => EditProfile()), child: Text("Edit Profile")))
                  ],
                ),
              ),
              Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blueAccent.withOpacity(0.5)
                    ),
                    child: Icon(Icons.settings,color: Colors.white,),
                  ),
                  title: Text("Settings",style: TextStyle(color: Colors.white,fontSize: 20)),
                  trailing: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey.withOpacity(0.5)
                    ),
                    child: Icon(Icons.arrow_right,color: Colors.grey,),
                  ),
                ),
              ),
              Gap(5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blueAccent.withOpacity(0.5)
                    ),
                    child: Icon(Icons.payments,color: Colors.white,),
                  ),
                  title: Text("Payment settings",style: TextStyle(color: Colors.white,fontSize: 20)),
                  trailing: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey.withOpacity(0.5)
                    ),
                    child: Icon(Icons.arrow_right,color: Colors.grey,),
                  ),
                ),
              ),
              Gap(5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blueAccent.withOpacity(0.5)
                    ),
                    child: Icon(Icons.info,color: Colors.white,),
                  ),
                  title: Text("Information",style: TextStyle(color: Colors.white,fontSize: 20)),
                  trailing: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey.withOpacity(0.5)
                    ),
                    child: Icon(Icons.arrow_right,color: Colors.grey,),
                  ),
                ),
              ),
              Gap(15),
              Divider(
                indent: 20,
                endIndent: 20,
              ),
              Gap(15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blueAccent.withOpacity(0.5)
                    ),
                    child: Icon(Icons.logout,color: Colors.white,),
                  ),
                  title: Text("Logout",style: TextStyle(color: Colors.red,fontSize: 20)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
