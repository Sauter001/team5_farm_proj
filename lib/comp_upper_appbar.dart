import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void _gotoMyPage() {
  // 마이 페이지로 이동
  Fluttertoast.showToast(msg: '프로필 눌림', toastLength: Toast.LENGTH_SHORT);
}

void _openMenu() {
  // 햄버거 버튼 누를 시 실행할 기능
  Fluttertoast.showToast(msg: '햄버거 버튼 눌림', toastLength: Toast.LENGTH_SHORT);
}

// 상단바 구현
class UpperAppbar {
  final AppBar _appBar = AppBar(
    leading: const IconButton(
      onPressed: _openMenu,
      icon: Icon(Icons.menu),
    ),
    title: const Text('appbar title'),
    actions: <Widget>[
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        child: IconButton(
          onPressed: _gotoMyPage,
          icon: Image.asset('assets/images/base_profile.png'),
        ),
      ),
    ],
  );

  get appBar {
    return _appBar;
  }
}
