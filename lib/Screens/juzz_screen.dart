import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quranapp/Constants/constants.dart';
import 'package:quranapp/Model/juzz.dart';
import 'package:quranapp/Services/ApiServices.dart';

import '../Widget/juzz_custom_tile.dart';

class JuzScreen extends StatelessWidget {
  static const String id = 'juz_screen';

  ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Para ${Constants.juzIndex!.toString()}",
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
        body: FutureBuilder<JuzModel>(
          future: apiServices.getJuzz(Constants.juzIndex!),
          builder: (context, AsyncSnapshot<JuzModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              print('${snapshot.data!.juzAyahs.length} length');
              return ListView.builder(
                itemCount: snapshot.data!.juzAyahs.length,
                itemBuilder: (context, index) {
                  return JuzCustomTile(
                    list: snapshot.data!.juzAyahs,
                    index: index,
                  );
                },
              );
            } else {
              return Center(
                child: Text('Data not found'),
              );
            }
          },
        ),
      ),
    );
  }
}
