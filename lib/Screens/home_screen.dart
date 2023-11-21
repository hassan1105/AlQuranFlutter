import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/ayahOfTheDay.dart';
import '../Services/ApiServices.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiServices _apiServices = ApiServices();

  void setData() async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("alreadyUsed", true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    HijriCalendar.setLocal('ar');
    var _hijri = HijriCalendar.now();
    var day = DateTime.now();
    var format = DateFormat('EEE , d MMM yyyy');
    var formatted = format.format(day);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text("Asslamualaikum",
                  textAlign: TextAlign.end,
                  style: GoogleFonts.roboto(
                      textStyle: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 106, 106, 106),
                        letterSpacing: .5),
                  ))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: _size.height * 0.22, // 22% of screen
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('Assets/background_img.jpg'))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(formatted,
                          style: GoogleFonts.roboto(
                              textStyle: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontSize: 20,
                                color: const Color.fromARGB(255, 255, 255, 255),
                                letterSpacing: .5),
                          ))),
                      RichText(
                        text: TextSpan(children: <InlineSpan>[
                          WidgetSpan(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                _hijri.hDay.toString(),
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: 20,
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      letterSpacing: .5),
                                ),
                              ),
                            ),
                          ),
                          WidgetSpan(
                            child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(_hijri.longMonthName,
                                    style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          fontSize: 20,
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          letterSpacing: .5),
                                    ))),
                          ),
                          WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.all(4),
                              child: Text('${_hijri.hYear} AH',
                                  style: GoogleFonts.roboto(
                                      textStyle: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        letterSpacing: .5),
                                  ))),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsetsDirectional.only(top: 10, bottom: 20),
                child: Column(
                  children: [
                    FutureBuilder<AyaOfTheDay>(
                      future: _apiServices.getAyaOfTheDay(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return Icon(Icons.sync_problem);
                          case ConnectionState.waiting:
                          case ConnectionState.active:
                            return CircularProgressIndicator();
                          case ConnectionState.done:
                            return Container(
                              margin: EdgeInsetsDirectional.all(16),
                              padding: EdgeInsetsDirectional.all(20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(32),
                                  color: HexColor("#ba76e7"),
                                  boxShadow: []),
                              child: Column(
                                children: [
                                  Text(
                                    "Quran Aya of the Day",
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Divider(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    thickness: 0.5,
                                  ),
                                  Text(
                                    snapshot.data?.arText ??
                                        ' إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ',
                                    style: TextStyle(
                                      fontFamily: "arabic",
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    snapshot.data?.enTran ??
                                        "Thee (alone) we worship; Thee (alone) we ask for help.",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(241, 255, 255, 255),
                                        fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                  RichText(
                                    text: TextSpan(children: <InlineSpan>[
                                      WidgetSpan(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            snapshot.data?.surNumber
                                                    .toString() ??
                                                "1",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      WidgetSpan(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            snapshot.data?.surEnName ??
                                                "Al-Faatiha",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                ],
                              ),
                            );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
