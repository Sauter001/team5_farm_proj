import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import 'app.dart';
import 'monthly_view.dart';

// 최종 일지 페이지

class FinalReportPage extends StatefulWidget {
  const FinalReportPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FinalReportPageState();
}

class _FinalReportPageState extends State<FinalReportPage> {
  bool _isRegisterd = false;
  final _textEditController = TextEditingController();
  double _rating = 0;
  bool _ischecked = false;
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  void dispose() {
    _textEditController.dispose();
    super.dispose();
  }

  void plantRegister() {
    setState(() {
      FirebaseFirestore.instance.collection('plants').doc('선인장').update({
        'rating' : _rating,
        'checked' : _ischecked,
        'report' : _textEditController.text,
        'ing' : false,
      });
      _isRegisterd = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '종료 일지 작성',
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.black,
                icon: Icon(Icons.arrow_back),
              ),
              title: const Text('종료 일지 작성'),
            ),
            body: FutureBuilder(
              future: FirebaseFirestore.instance.collection('plants').doc('선인장').get(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) return const Scaffold();
                return ListView(
                  //각각 구역들이 들어온다.
                  children: [
                    Container(
                        margin:
                        const EdgeInsets.only(left: 10, top: 20, right: 10),
                        child: Row(
                          children: [
                            //해당 식물 대표 사진? 아이콘  ,
                            Container(
                              width: 80,
                              height: 80,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 3
                                )
                              ),
                              child: const Center(child: Text('사진')),
                            ),

                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  //세로로 시작부분을 정렬
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.only(bottom: 8),
                                        child: Text(
                                            '이름: ${snapshot.data['name']} (${snapshot.data['nickname']})') //식물 이름 (애칭)
                                    ),
                                    Container(
                                        padding: const EdgeInsets.only(bottom: 8),
                                        child: Text(
                                            '재배 기간: ${snapshot.data['startDate']} ~ ${formatter.format(DateTime.now())}') //재배 기간 2022/11/22 ~ 2022/12/22
                                    ),
                                    // Container(
                                    //     padding: const EdgeInsets.only(bottom: 8),
                                    //     child: const Text(
                                    //         '물 준 횟수: ') //체크되어있는 부분만 count가 가능할까?
                                    //     ),
                                    Container(
                                        padding: const EdgeInsets.only(bottom: 8),
                                        child: const Text('일지 작성 횟수: 1') //이건 쉬울듯
                                    ),
                                  ],
                                ))
                          ],
                        )), //식물의 정보를 담은 구역

                    Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('재배 목표', textAlign: TextAlign.left),
                              Text('달성 여부', textAlign: TextAlign.right)
                            ])),

                    Container(
                      margin: const EdgeInsets.only(left: 8, right: 8),
                      height: 50,
                      decoration: const BoxDecoration(
                        //color는 Them?
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //각각 목표 + 달성여부의 체크박스가 자식
                          Container(
                            margin: const EdgeInsets.only(left: 8, right: 8),
                            child: Text('${snapshot.data['goal']}'),
                          ), //Container로 만들면 체크박스를 못만들듯...

                          Checkbox(
                              value: _ischecked,
                              onChanged: (value) {
                                setState(() {
                                  _ischecked = value!;
                                });
                              })
                        ],
                      ),
                    ), //초록색 구역

                    Container(
                        margin: const EdgeInsets.only(top: 10, left: 10),
                        child: Row(children: const [
                          Text('재배 소감', textAlign: TextAlign.left),
                        ])), //재배 소감 Text?

                    TextField(
                      //ui잘 설정해보자
                      controller: _textEditController,
                      //이걸 이용해 text가져오기 가능 _textEditController.text
                      decoration: const InputDecoration(
                        hintText: '소감을 입력하세요',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ), //TextField() //재배 소감 적는 구역

                    Container(
                        margin: const EdgeInsets.only(top: 10, left: 10),
                        child: Row(children: const [
                          Text(
                            '만족도',
                          )
                        ])),
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        //이걸 db에 저장하면 별점 보여주기 가능할듯
                        _rating = rating;
                        print(rating);
                      },
                    ),

                    if (_isRegisterd == false)
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.green),
                          ),
                          onPressed: () => {
                            plantRegister(),
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MonthlyViewPage()))
                          },
                          child: Text('등록하기'),

                        ),
                      ),
                  ],
                );
              },
            )));
    // TODO: implement build
    throw UnimplementedError();
  }
}
