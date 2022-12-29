import 'package:flutter/material.dart';
// 개별 일지 조회

class IndividualDailyReportPage extends StatelessWidget {
  const IndividualDailyReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: '종료 일지 작성',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
            icon: Icon(Icons.arrow_back),
          ),
          title: const Text('종료 일지 작성'),  //title은 일지가 작성된 날짜
        ),

        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top:15, left:10),
              child: Row(
                children: [
                  Text('날씨',
                    style: TextStyle(
                      fontSize: 25,
                    ),),// + 해당 날씨 아이콘
                ],
              ),
            ),

            //if사진이 존재하면 사진 보여주기


            Container(
                margin: const EdgeInsets.only(top:20, left:10, right: 10),
                child: Column(
                    children: const [
                      Divider(color: Colors.black, thickness: 2.0,)
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
