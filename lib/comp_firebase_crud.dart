import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/* Read */

// 사용자 이름 가져올 Text 위젯
class GetUserName extends StatelessWidget {
  final String documentId;
  final TextStyle textStyle;

  GetUserName(this.documentId, this.textStyle);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(
            "${data['name']}",
            style: textStyle,
          );
        }

        return Text("loading");
      },
    );
  }
}

// 사용자 이름 가져올 Text 위젯
class GetPlants extends StatelessWidget {
  final TextStyle textStyle;
  CollectionReference plants = FirebaseFirestore.instance.collection('plants');
  int _size = 0;

  GetPlants(this.textStyle);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getSize(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //해당 부분은 data를 아직 받아 오지 못했을 때 실행되는 부분
          if (snapshot.hasData == false) {
            return CircularProgressIndicator(); // CircularProgressIndicator : 로딩 에니메이션
          }

          //error가 발생하게 될 경우 반환하게 되는 부분
          else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Error: ${snapshot.error}', // 에러명을 텍스트에 뿌려줌
                style: TextStyle(fontSize: 15),
              ),
            );
          }

          // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 부분
          else {
            return Text(
              _size.toString(),
              style: textStyle,
            );
          }
        });
  }

  Future _getSize() async {
    await plants.get().then((snap) => {_size = snap.size});
    return _size;
  }
}
