import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:quranapp/Screens/audio_surah_screen.dart';
import 'package:quranapp/Screens/home_screen.dart';
import 'package:quranapp/Screens/quran_screen.dart';
import 'package:quranapp/Services/ApiServices.dart';

import '../Screens/qari_screen.dart';

class dashBoard extends StatefulWidget {
  const dashBoard({super.key});

  @override
  State<dashBoard> createState() => _dashBoardState();
}

class _dashBoardState extends State<dashBoard> {
  int _seletedindex = 0;
  PageController _pageController = PageController(initialPage: 0);
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  final tabs = [
    HomeScreen(),
    QuranScreen(),
    AudioSurahScreen(),
  ];
  final items = <Widget>[
    const Icon(
      Icons.home,
      size: 30,
    ),
    const Icon(
      Icons.dashboard,
      size: 30,
    ),
    const Icon(
      Icons.speaker_group,
      size: 30,
    ),
  ];
  ApiServices apiServices = ApiServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Al Quran",
          style: TextStyle(
              color: HexColor("#8c59d0"), fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[HexColor("#ffffff"), HexColor("#ffffff")],
            ),
          ),
        ),
        backgroundColor: HexColor("#38c172"),
        elevation: 0,
        leading: IconButton(
          color: HexColor("#8c59d0"),
          icon: SvgPicture.asset(
            "Assets/menu.svg",
            color: HexColor("#8c59d0"),
          ),
          onPressed: () {},
        ),
      ),
      backgroundColor: HexColor("#8c59d0"),
      body: PageView(
        controller: _pageController,
        onPageChanged: (newindex) {
          setState(() {
            _seletedindex = newindex;
          });
        },
        children: tabs,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: HexColor("#8c59d0"),
        index: _seletedindex,
        backgroundColor: HexColor("#ffffff"),
        animationDuration: Duration(milliseconds: 300),
        items: items,
        height: 50,
        onTap: (newindex) {
          _pageController.animateToPage(newindex,
              duration: Duration(milliseconds: 500), curve: Curves.ease);
        },
      ),
    );
  }
}
