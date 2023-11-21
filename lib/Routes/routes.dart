import 'package:flutter/widgets.dart';
import 'package:quranapp/Screens/juzz_screen.dart';
import 'package:quranapp/Screens/surah_view.dart';

import '../View/SplashScreen/Home/splashScreen.dart';

final Map<String, WidgetBuilder> routes = {
  splashScreen.routeName: (context) => const splashScreen(),
  JuzScreen.id: (context) => JuzScreen(),
  Surahdetail.id: (context) => Surahdetail(),
};
