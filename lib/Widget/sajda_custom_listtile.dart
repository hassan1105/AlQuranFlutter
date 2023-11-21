import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Model/sajda.dart';

Widget SajdaCustomTile(SajdaAyat sajdaAyat, context) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(color: Colors.white, boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 3.0,
      ),
    ]),
    child: Column(
      children: [
        Row(
          children: [
            Container(
              alignment: Alignment.center,
              height: 30,
              width: 40,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: HexColor("#8c59d0"),
              ),
              child: Text(
                sajdaAyat.juzNumber.toString(),
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: '${sajdaAyat.surahEnglishName} \n',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                    TextSpan(
                        text: sajdaAyat.revelationType,
                        style: TextStyle(color: Colors.black)),
                  ]),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            Spacer(),
            Text(
              sajdaAyat.surahName,
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ],
        ),
      ],
    ),
  );
}
