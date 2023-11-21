import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quranapp/Constants/constants.dart';
import 'package:quranapp/Model/translation.dart';
import 'package:quranapp/Services/ApiServices.dart';
import 'package:quranapp/Widget/custom_translation.dart';

import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

enum Translation { urdu, hindi, english, spanish }

class Surahdetail extends StatefulWidget {
  const Surahdetail({Key? key}) : super(key: key);

  static const String id = 'surahDetail_screen';

  @override
  _SurahdetailState createState() => _SurahdetailState();
}

class _SurahdetailState extends State<Surahdetail> {
  ApiServices _apiServices = ApiServices();
  //SolidController _controller = SolidController();
  Translation? _translation = Translation.urdu;
  String? SurahName;
  @override
  Widget build(BuildContext context) {
    print(_translation!.index);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Surah ${Constants.surahIndex!.toString()}",
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
              "Assets/back-arrow-svgrepo-com.svg",
              color: HexColor("#8c59d0"),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: FutureBuilder(
          future: _apiServices.getTranslation(
              Constants.surahIndex!, _translation!.index),
          builder: (BuildContext context,
              AsyncSnapshot<SurahTranslationList> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: ListView.builder(
                  itemCount: snapshot.data!.translationList.length,
                  itemBuilder: (context, index) {
                    return TranslationTile(
                      index: index,
                      surahTranslation: snapshot.data!.translationList[index],
                    );
                  },
                ),
              );
            } else
              return Center(
                child: Text('Translation Not found'),
              );
          },
        ),
        bottomSheet: SolidBottomSheet(
          headerBar: Container(
            color: HexColor("#8c59d0"),
            height: 50,
            child: Center(
              child: Text(
                "Swipe me!",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          body: Container(
            color: Colors.white,
            height: 30,
            child: SingleChildScrollView(
              child: Center(
                  child: Column(
                children: <Widget>[
                  ListTile(
                    title: const Text('Urdu'),
                    leading: Radio<Translation>(
                      activeColor: HexColor("#8c59d0"),
                      value: Translation.urdu,
                      groupValue: _translation,
                      onChanged: (Translation? value) {
                        setState(() {
                          _translation = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Hindi'),
                    leading: Radio<Translation>(
                      value: Translation.hindi,
                      groupValue: _translation,
                      onChanged: (Translation? value) {
                        setState(() {
                          _translation = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('English'),
                    leading: Radio<Translation>(
                      value: Translation.english,
                      groupValue: _translation,
                      onChanged: (Translation? value) {
                        setState(() {
                          _translation = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Spanish'),
                    leading: Radio<Translation>(
                      value: Translation.spanish,
                      groupValue: _translation,
                      onChanged: (Translation? value) {
                        setState(() {
                          _translation = value;
                        });
                      },
                    ),
                  ),
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
}
