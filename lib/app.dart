import 'package:flutter/material.dart';

import 'login.dart';
import 'monthly_view.dart';

class FarmApp extends StatelessWidget {
  const FarmApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farm management',
      initialRoute: '/login',
      routes: {
        // '/': 기본 화면 월간 화면으로 설정됨
        '/login': (BuildContext context) => const LoginPage(),
        '/': (BuildContext context) => const MonthlyViewPage(),
      },
    );
  }
}
