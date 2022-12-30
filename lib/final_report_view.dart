import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'individual_daily_report_view.dart';

class FinalReportViewPage extends StatefulWidget {
  const FinalReportViewPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FinalReportViewPageState();
}

class _FinalReportViewPageState extends State<FinalReportViewPage> {
  final _textEditController = TextEditingController();
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  void dispose() {
    _textEditController.dispose();
    super.dispose();
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
              future: FirebaseFirestore.instance
                  .collection('plants')
                  .doc('선인장')
                  .get(),
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
                        )),
                    //식물의 정보를 담은 구역
                    if (snapshot.data['checked'])
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 20, right: 10),
                        child: LinearPercentIndicator(
                          width: 300,
                          animation: true,
                          //차오르는 애니메이션
                          animationDuration: 1000,
                          //시간
                          lineHeight: 20,
                          leading: Text('달성 정도'),
                          percent: 1.0,
                          //계산해야함
                          center: Text('100%'),
                          //이것도 계산해서 넣어주기
                          progressColor: Colors.lightGreenAccent,
                        ),
                      ),
                    if (!snapshot.data['checked'])
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 20, right: 10),
                        child: LinearPercentIndicator(
                          width: 300,
                          animation: true,
                          //차오르는 애니메이션
                          animationDuration: 1000,
                          //시간
                          lineHeight: 20,
                          leading: Text('달성 정도'),
                          percent: 0,
                          //계산해야함
                          center: Text('0%'),
                          //이것도 계산해서 넣어주기
                          progressColor: Colors.lightGreenAccent,
                        ),
                      ),

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
                              value: snapshot.data['checked'],
                              onChanged: (value) {
                                setState(() {
                                  snapshot.data['checked'] = value!;
                                });
                              })
                        ],
                      ),
                    ),
                    //초록색 구역

                    Container(
                        margin: const EdgeInsets.only(top: 10, left: 10),
                        child: Row(children: const [
                          Text('재배 소감', textAlign: TextAlign.left),
                        ])),
                    //재배 소감 Text?

                    Container(
                      margin: const EdgeInsets.only(left: 8, right: 8),
                      height: 50,
                      decoration: BoxDecoration(
                        //color는 Them?
                        border: Border.all(
                            color: Colors.black,
                            width: 2.0
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Row(children: [
                            Text('${snapshot.data['report']}'),
                          ])),

                    ),

                    Container(
                        margin: const EdgeInsets.only(top: 10, left: 10),
                        child: Row(children: const [
                          Text(
                            '만족도',
                          )
                        ])),

                    RatingBar.builder(
                      initialRating: snapshot.data['rating'],
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
                        print(rating);
                      },
                    ),

                    Container(
                        margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                        child: Column(children: [
                          Text(
                            '개별 일지 모아보기',
                          ),
                          Divider(
                            color: Colors.black,
                            thickness: 2.0,
                          )
                        ])),

                    //개별 일지 모아보기
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 10),
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width:2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:  (
                              TextButton(
                                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => IndividualDailyReportPage())), //여기 네비게이터 설정
                                  child: Text('2022-12-30\n\n 물을 주었다')
                              )
                          ),

                        ),
                        SizedBox(
                          width: 80,
                        )
                      ],
                    )
                  ],
                );
              },
            )));
    // TODO: implement build
    throw UnimplementedError();
  }
}
