import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quranapp/Model/Surah.dart';

Widget SurahCustomTitle(
    {required Surah surah,
    required BuildContext context,
    required VoidCallback ontap}) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      padding: EdgeInsets.all(16.0),
      decoration:
          BoxDecoration(color: Color.fromARGB(234, 255, 255, 255), boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 3.0),
      ]),
      child: Column(children: [
        Row(
          children: [
            Container(
              alignment: Alignment.center,
              height: 30,
              width: 40,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(
                    Radius.circular(8.0)), // Adjust the radius as needed
                color: HexColor("#8c59d0"),
              ),
              child: Text(
                (surah.number).toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(surah.englishName!,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(surah.englishNameTranslation!),
              ],
            ),
            Spacer(),
            Text(
              surah.name!,
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            )
          ],
        )
      ]),
    ),
  );
}

class StarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    double width = size.width;
    double height = size.height;

    // Define the coordinates for the star vertices
    List<Offset> starVertices = [
      Offset(width * 0.5, 0),
      Offset(width * 0.6, height * 0.4),
      Offset(width, height * 0.5),
      Offset(width * 0.6, height * 0.6),
      Offset(width * 0.5, height),
      Offset(width * 0.4, height * 0.6),
      Offset(0, height * 0.5),
      Offset(width * 0.4, height * 0.4),
    ];

    Path path = Path()..addPolygon(starVertices, true);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
