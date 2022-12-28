// 로그인 화면 구성
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_management_proj/mypage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left),
          // 로그인 화면에서 뒤로 가기가 눌리면 종료
          onPressed: () => SystemNavigator.pop(),
        ),
        title: const Text('로그인'),
      ),
      body: Center(
          child: Column(
        children: [
          TextButton(
            child: const Text('마이 페이지로'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyPage()));
            },
          ),
          TextButton(
            child: const Text('create'),
            onPressed: () {
              FirebaseFirestore.instance.collection('plants').add({
                'title': '등록 테스트',
                'done': false,
                'createTime': Timestamp.now(),
              });
            },
          ),
          TextButton(
            child: const Text('read'),
            onPressed: () {
              var value = FirebaseFirestore.instance
                  .collection('plants')
                  .doc('W2wlDEt7NgDCyaQES0lK');
              Fluttertoast.showToast(
                  msg:
                      '${value.get().then((value) => value.data().toString())}',
                  toastLength: Toast.LENGTH_SHORT);
            },
          ),
        ],
      )),
    );
  }
}
