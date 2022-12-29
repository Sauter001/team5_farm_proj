import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/percent_indicator.dart';

// 최종 일지 조회 페이지

class FinalReportViewPage extends StatefulWidget {
  const FinalReportViewPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FinalReportViewPageState();
}

class _FinalReportViewPageState extends State<FinalReportViewPage> {
  final _textEditController = TextEditingController();
  @override
  void dispose(){
    _textEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '종료 일지',
        home: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                color: Colors.black,
                icon: Icon(Icons.arrow_back),
              ),
              title: const Text('종료 일지'),              /* TODO:여기 바꿔야 됨 */
            ),
            body: ListView( //각각 구역들이 들어온다.
              children: [
                plantInformationSection,//식물의 정보를 담은 구역
                /* TODO:여기 바꿔야 됨 */
                Container(
                  padding: EdgeInsets.only(left:10, top: 20, right:10),
                  child: LinearPercentIndicator(
                    width: 300,
                    animation: true,  //차오르는 애니메이션
                    animationDuration: 1000,  //시간
                    lineHeight: 20,
                    leading: Text('달성 정도'),
                    percent: 0.4, //계산해야함
                    center: Text('40.0 %'), //이것도 계산해서 넣어주기
                    progressColor: Colors.lightGreenAccent,
                  ),
                ),

                Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('재배 목표',
                              textAlign: TextAlign.left),
                          Text('달성 여부',
                              textAlign: TextAlign.right)
                        ]
                    )
                ),

                plantGoal,//초록색 구역

                Container(
                    margin: EdgeInsets.only(top:10,left:10),
                    child: Row(
                        children: [
                          Text('재배 소감',
                              textAlign: TextAlign.left),
                        ]
                    )
                ),//재배 소감 Text?

                TextField(  //TODO:여기 TEXT로 바꿔야 한다. 저장했던 문자를 그대로 보여주기
                  controller: _textEditController,  //이걸 이용해 text가져오기 가능 _textEditController.text
                  decoration: InputDecoration(
                    hintText: '소감을 입력하세요',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),

                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),//TextField() //재배 소감 적는 구역


                Container(
                    margin: EdgeInsets.only(top:10,left:10),
                    child: Row(
                        children: [
                          Text('만족도',)
                        ]
                    )
                ),
                RatingBar.builder(      //TODO:여기도 저장했던 별점을 그대로 보여줘야 하는데 ratingbar랑 좀 다르네...
                  initialRating: 0,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {    //이걸 db에 저장하면 별점 보여주기 가능할듯
                    print(rating);
                  },
                ),

                Container(
                    margin: EdgeInsets.only(top:20, left:10, right: 10),
                    child: Column(
                        children: [
                          Text('개별 일지 모아보기',),
                          Divider(color: Colors.black, thickness: 2.0,)
                        ]
                    )
                ),

                //개별 일지 모아보기
                // GridView.count(
                //   crossAxisCount: 3,
                //   //children: , TODO:이부분 나타내기 날짜를 위에 표시하고 사진이 있으면 썸네일 사진, 없으면 메모내용
                // )
              ],
            )
        )
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}

Widget plantInformationSection = Container(
    margin: const EdgeInsets.only(left:10, top: 20, right:10),
    child: Row(
      children: [
        //해당 식물 대표 사진? 아이콘  ,
        Container(
          margin: const EdgeInsets.only(right:10),
          child: const Text('아이콘 들어갈 자리'),
        ),

        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, //세로로 시작부분을 정렬
              children: [
                Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: const Text('이름: ')//식물 이름 (애칭)
                ),
                Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: const Text('재배 기간: ')//재배 기간 2022/11/22 ~ 2022/12/22
                ),
                Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: const Text('물 준 횟수: ')//체크되어있는 부분만 count가 가능할까?
                ),
                Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: const Text('일지 작성 횟수: ')//이건 쉬울듯
                ),
              ],
            )
        )
      ],
    )
);

Widget plantGoal = Container(
  margin: const EdgeInsets.only(left:8, right:8),
  height: 100,

  decoration: const BoxDecoration(
    //color는 Them?
      color: Colors.green,
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      )
  ),

  child: Row(
    children: [
      //각각 목표 + 달성여부의 체크박스가 자식
      Container(
        child: Column(
          children: [
            //목표
          ],
        ),
      ) //Container로 만들면 체크박스를 못만들듯...
    ],
  ),
);