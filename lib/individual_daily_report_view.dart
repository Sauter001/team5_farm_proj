import 'package:flutter/material.dart';
// 개별 일지 조회

class IndividualDailyReportPage extends StatelessWidget {
  const IndividualDailyReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: '2022년 12월 30일',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
            icon: Icon(Icons.arrow_back),
          ),
          title: const Text('2022년 12월 30일'),  //title은 일지가 작성된 날짜
        ),

        body: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(top:15, left:10),
              child: Row(
                children: [
                  Text('날씨',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Icon(Icons.cloud),// + 해당 날씨 아이콘
                ],
              ),
            ),


            Container(
                margin: const EdgeInsets.only(top:20, left:10, right: 10),
                child: Column(
                    children: const [
                      Divider(color: Colors.black, thickness: 2.0,),
                      Text('오늘따라 귀여운 선인장, 사진이 올라가질 않네....\n\n\n\n\n\n\n\n',
                      style: TextStyle(fontSize: 18),),
                    ]
                )
            )
          ],
        ),
      ),
    );

    throw UnimplementedError();
  }

}
