import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quranapp/Constants/constants.dart';
import 'package:quranapp/Model/Surah.dart';
import 'package:quranapp/Model/sajda.dart';
import 'package:quranapp/Screens/juzz_screen.dart';
import 'package:quranapp/Screens/surah_view.dart';
import 'package:quranapp/Widget/sajda_custom_listtile.dart';
import 'package:quranapp/Widget/surah_Custom_tile.dart';

import '../Services/ApiServices.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({Key? key}) : super(key: key);

  @override
  _QuranScreenState createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen>
    with TickerProviderStateMixin {
  ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 4, vsync: this);
    var _size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3, // Added
      initialIndex: 0,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: _size.height * 0.12, // 22% of screen
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      image: DecorationImage(
                          fit: BoxFit.fill, image: AssetImage('Assets/1.png'))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [],
                    ),
                  ),
                ),
              ),
              TabBar(
                controller: tabController,
                isScrollable: true,
                tabs: [
                  Tab(
                    child: Text(
                      'Surah',
                      style: TextStyle(
                          color: HexColor("#8c59d0"),
                          fontWeight: FontWeight.w700,
                          fontSize: 15),
                    ), //index - 0,)
                  ),
                  Tab(
                    child: Text(
                      'Sajda',
                      style: TextStyle(
                          color: HexColor("#8c59d0"),
                          fontWeight: FontWeight.w700,
                          fontSize: 15),
                    ), //index - 1
                  ),
                  Tab(
                    child: Text(
                      'Juz',
                      style: TextStyle(
                          color: HexColor("#8c59d0"),
                          fontWeight: FontWeight.w700,
                          fontSize: 15),
                    ), // index - 2
                  ),

                  Text(
                    'Tafseer',
                    style: TextStyle(
                        color: HexColor("#8c59d0"),
                        fontWeight: FontWeight.w700,
                        fontSize: 15),
                  ), // index - 2
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: <Widget>[
                    FutureBuilder(
                      future: apiServices.getSurah(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Surah>> snapshot) {
                        if (snapshot.hasData) {
                          List<Surah>? surah = snapshot.data;
                          return ListView.builder(
                            itemCount: surah!.length,
                            itemBuilder: (context, index) => SurahCustomTitle(
                                surah: surah[index],
                                context: context,
                                ontap: () {
                                  setState(() {
                                    Constants.surahIndex = (index + 1);
                                  });
                                  Navigator.pushNamed(context, Surahdetail.id);
                                }),
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                    FutureBuilder(
                      future: apiServices.getSajda(),
                      builder: (context, AsyncSnapshot<SajdaList> snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Something went wrong'),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ListView.builder(
                          itemCount: snapshot.data!.sajdaAyahs.length,
                          itemBuilder: (context, index) => SajdaCustomTile(
                              snapshot.data!.sajdaAyahs[index], context),
                        );
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemCount: 30,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  Constants.juzIndex = (index + 1);
                                });
                                Navigator.pushNamed(context, JuzScreen.id);
                              },
                              child: Card(
                                elevation: 4,
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("Assets/123.png"),
                                      fit: BoxFit.cover,
                                    ),
                                    color: Colors.black.withOpacity(
                                        0.5), // Adjust the opacity as needed
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 87, 87, 87),
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Center(child: Text("Coming Soon"))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
