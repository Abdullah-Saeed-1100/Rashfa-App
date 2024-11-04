import 'package:flutter/material.dart';
import 'package:rashfa_app/pages/home.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
    return Material(
      child: Container(
        // alignment: Alignment.centerLeft,

        alignment: const Alignment(-0.5, 0.50),
        padding: const EdgeInsets.only(
            // top: 100,
            // bottom: 40,
            ),
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              image: AssetImage("assets/images/BG.jpg"),
              fit: BoxFit.cover,
              opacity: 1),
        ),
        child: const Text(
          "Rashfa",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 80,
            letterSpacing: 4,
            fontFamily: "Marhey",
          ),
        ),
      ),
    );
  }
}
