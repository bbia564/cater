import 'package:catering_management/db_catering/db_catering.dart';
import 'package:catering_management/pages/catering_first/catering_first_binding.dart';
import 'package:catering_management/pages/catering_first/catering_first_view.dart';
import 'package:catering_management/pages/catering_man/cater_man_binding.dart';
import 'package:catering_management/pages/catering_man/cater_man_view.dart';
import 'package:catering_management/pages/catering_second/catering_second_binding.dart';
import 'package:catering_management/pages/catering_second/catering_second_view.dart';
import 'package:catering_management/pages/catering_tab/catering_tab_binding.dart';
import 'package:catering_management/pages/catering_tab/catering_tab_view.dart';
import 'package:catering_management/pages/catering_third/catering_third_binding.dart';
import 'package:catering_management/pages/catering_third/catering_third_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'db_catering/cater_mb.dart';

Color primaryColor = const Color(0xffff8900);
Color bgColor = const Color(0xfff7f7f7);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Get.putAsync(() => DBCatering().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Goal,
      initialRoute: '/',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        dialogTheme: const DialogTheme(
          actionsPadding: EdgeInsets.only(right: 10, bottom: 5),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}

List<GetPage<dynamic>> Goal = [
  GetPage(name: '/', page: () => const CaterManView(), binding: CaterManBinding()),
  GetPage(name: '/cateringTab', page: () => CateringTabPage(), binding: CateringTabBinding()),
  GetPage(name: '/cateringFirst', page: () => CateringFirstPage(), binding: CateringFirstBinding()),
  GetPage(name: '/cateringSecond', page: () => CateringSecondPage(), binding: CateringSecondBinding()),
  GetPage(name: '/cateringSolo', page: () => const CaterMb()),
  GetPage(name: '/cateringThird', page: () => CateringThirdPage(), binding: CateringThirdBinding()),
];
