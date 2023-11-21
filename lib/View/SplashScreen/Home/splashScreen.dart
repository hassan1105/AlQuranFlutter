import 'package:flutter/material.dart';
import 'package:quranapp/Dashboard/dashBoard.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});
  static String routeName = "/splashScreen ";
  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    Future.delayed(Duration(milliseconds: 3500), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => dashBoard()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(
                'Assets/splashpic.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              child: const Text(
                "Al Quran",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
