import 'package:flutter/material.dart';
import 'package:quranapp/Model/qari.dart';
import 'package:quranapp/Screens/audio_surah_screen.dart';

import '../Services/ApiServices.dart';
import '../Widget/qari_custom_tile.dart';

class QariListScreen extends StatefulWidget {
  const QariListScreen({Key? key}) : super(key: key);

  @override
  _QariListScreenState createState() => _QariListScreenState();
}

class _QariListScreenState extends State<QariListScreen> {
  ApiServices apiServices = ApiServices();
  late Future<List<Qari>> qariListFuture;
  @override
  void initState() {
    super.initState();
    qariListFuture = apiServices.getQariList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 12, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 12,
              ),
              Expanded(
                child: FutureBuilder(
                  future: qariListFuture,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Qari>> snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Qari\'s data not found '),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return QariCustomTile(
                            qari: snapshot.data![index],
                            ontap: () {
                              if (snapshot.data != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AudioSurahScreen(),
                                  ),
                                );
                              }
                            });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
