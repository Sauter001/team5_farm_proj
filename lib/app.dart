import 'package:farm_management_proj/submit_plant.dart';
import 'package:flutter/material.dart';

import 'login.dart';
import 'monthly_view.dart';

class FarmApp extends StatelessWidget {
  const FarmApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farm management',
      initialRoute: '/submit',
      routes: {
        // '/': 기본 화면 월간 화면으로 설정됨
        '/submit': (BuildContext context) => const SubmitPlantPage(),
        '/': (BuildContext context) => const MonthlyViewPage(),
      },
    );
  }
}
