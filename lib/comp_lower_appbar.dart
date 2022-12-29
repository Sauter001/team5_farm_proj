import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void _onItemTapped(int index) {
  setstate() {
    // 하단 바 클릭 시 이벤트
    Fluttertoast.showToast(msg: '$index', toastLength: Toast.LENGTH_SHORT);
  }
}

// 하단바 구현
class LowerAppBar {
  // BottomNavigationBar
  final BottomNavigationBar _navigationBar = BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.add),
        label: '할 일 추가',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.mode_edit),
        label: '일지 작성',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.square),
        label: '재배 종료',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.bookmark),
        label: '주별 보기',
      ),
    ],
    onTap: _onItemTapped,
  );

  get navigationBar {
    return _navigationBar;
  }
}
