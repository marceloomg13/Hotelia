import 'package:hotelia/screens/auth_page.dart';
import 'package:hotelia/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:hotelia/utils/Styles.dart';
import 'package:google_fonts/google_fonts.dart' as fonts;
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});


  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: AppColors.creamColor,
            brightness: Brightness.dark,
            background: AppColors.mirage,
          ),
          indicatorColor: AppColors.rawSienna,
          dividerColor: Colors.white54,
          textTheme: fonts.GoogleFonts.exo2TextTheme(),
        )
        ,
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
            splash: Splash(),
            splashIconSize: double.infinity,
            duration: 3000,
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: const Color(0xFF8ACCF7),
            nextScreen: AuthPage())
    );
  }
}
