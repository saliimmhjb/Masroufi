import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:masroufi/screens/home_screen.dart';
import 'package:masroufi/screens/spalsh_screen.dart';

void main() async
{
  await Hive.initFlutter();
  var box = await Hive.openBox("mybox");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Masroufi",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Colors.white),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
        fontFamily: GoogleFonts.poppins().fontFamily,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: Scaffold(
        body: SplashScreen(),
      ),
    );
  }
}
