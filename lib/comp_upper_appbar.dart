import 'package:farm_management_proj/mypage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

late BuildContext cont;
void _gotoMyPage(BuildContext context) {
  // 마이 페이지로 이동
  Fluttertoast.showToast(msg: '프로필 눌림', toastLength: Toast.LENGTH_SHORT);

  if (context.widget != MyPage()) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyPage()));
  }
  cont = context;
}

void _openMenu() {
  // 햄버거 버튼 누를 시 실행할 기능
    Navigator.pop(cont);
}

// 상단바 구현
class UpperAppbar{

  AppBar _appBar = AppBar(
    backgroundColor:  Colors.green,
    leading: const IconButton(
      onPressed: _openMenu,
      icon: Icon(Icons.arrow_back),
    ),

    title: const Text(
      'appbar title',
      textAlign: TextAlign.center,
    ),

    actions: <Widget>[
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        child: IconButton(
          onPressed: () => {},
          icon: Image.asset('assets/images/baseProfile.jpg'),
        ),
      ),
    ],
  );

  UpperAppbar(BuildContext context) {
    _appBar = AppBar(
      backgroundColor:  Colors.green,
      leading: const IconButton(
        onPressed: _openMenu,
        icon: Icon(Icons.menu),
      ),
      title: const Text(
        'appbar title',
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          child: IconButton(
            onPressed: () {
              _gotoMyPage(context);
            },
            icon: Image.asset('assets/images/baseProfile.jpg'),
          ),
        ),
      ],
    );
  }

  /* 상단바 component의 title을 변경한다. */
  UpperAppbar changeTitle(String title, BuildContext context) {
    _appBar = AppBar(
      backgroundColor:  Colors.green,
      leading: const IconButton(
        onPressed: _openMenu,
        icon: Icon(Icons.arrow_back),
      ),
      title: Text(title),
      actions: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          child: IconButton(
            onPressed: () {
              _gotoMyPage(context);
            },
            icon: ClipRRect(
              borderRadius: BorderRadius.circular(80.0),
              child: Image.asset(
                'assets/images/baseProfile.jpg',
                width: 100,
              ),
            ),
          ),
        ),
      ],
    );

    return this;
  }

  get appBar {
    return _appBar;
  }
}
