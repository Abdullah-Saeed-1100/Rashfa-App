import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rashfa_app/pages/add_item.dart';
import 'package:rashfa_app/pages/edit_item.dart';
import 'package:rashfa_app/pages/home.dart';
import 'package:rashfa_app/pages/item_info.dart';
import 'package:rashfa_app/pages/splash_screen.dart';

void main(List<String> args) {
  //
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  //
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF212325),
          fontFamily: "Marhey"),
      // initialRoute: "home",
      // هذي طريقة بدل ماتستخدم خاصية الهوم
      routes: {
        "splash": (context) => const SplashScreen(),
        "home": (context) => const HomePage(),
        // "info": (context) =>  ItemInfo(),
        // "add": (context) => AddItem(),
        // "edit": (context) =>  EditItem(),
      },
      initialRoute: "splash",
      // home: const SplashScreen(),
    );
  }
}
