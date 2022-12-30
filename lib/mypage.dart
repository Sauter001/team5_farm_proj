import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_management_proj/comp_report_card.dart';
import 'package:farm_management_proj/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:folding_cell/folding_cell.dart';
import 'dart:developer';
import 'comp_upper_appbar.dart';
import 'comp_firebase_crud.dart';
import 'final_report_view.dart';
import 'individual_daily_report_view.dart';

// 마이 페이지
class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final _foldingCellKey1 = GlobalKey<SimpleFoldingCellState>();
  final _foldingCellKey2 = GlobalKey<SimpleFoldingCellState>();

  List<bool> _selectedOrder = <bool>[true, false];
  bool _isPlant = true;

  @override
  Widget build(BuildContext context) {
    String nickname = 'test';
    TextStyle nicknameTextStyle = const TextStyle(
      // 닉네임의 text style
      fontWeight: FontWeight.bold,
      fontSize: 25,
    );
    TextStyle introTextStyle = const TextStyle(fontSize: 20); // 소개문의 text style
    TextStyle numberTextStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 22,
      color: Colors.red,
    );

    /* TODO: 재배한 기간 불러오도록 구현 필요 */
    int period = 224;
    /* TODO: 재배하는 식물의 종류 DB에서 불러오기 */
    int plantType = 5;
    /* TODO: 작성한 일지 수 DB에서 불러오기 */
    int numOfReports = 7;

    List<String> yearList = ["2022"];
    List reportInfoList = [
      {"name": "고구마", "date": '2022/03/10', "img": ""},
      {"name": "고구마", "date": '2022/08/21', "img": ""},
      {"name": "고구마", "date": '2022/10/20', "img": ""},
      {"name": "고구마", "date": '2022/11/22', "img": ""},
    ];

    /* 식물-연도 바꾸는 toggle button */
    final toggle = ToggleButtons(
      borderWidth: 2,
      borderRadius: BorderRadius.circular(20),
      direction: Axis.horizontal,
      onPressed: (index) {
        log(_selectedOrder.toString());
        setState(() {
          // The button that is tapped is set to true, and the others to false.
          for (int i = 0; i < _selectedOrder.length; i++) {
            _selectedOrder[i] = (i == index);
          }
        });

        switch (index) {
          case 0:
            _isPlant = true;
            break;
          case 1:
            _isPlant = false;
            break;
        }
      },
      isSelected: _selectedOrder,
      color: Colors.black,
      selectedColor: Colors.white,
      fillColor: const Color(0xff4c6076),
      children: <Widget>[
        Container(
          width: 60,
          child: const Text(
            '식물',
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: 60,
          child: const Text(
            '연도',
            textAlign: TextAlign.center,
          ),
        )
      ],
    );

    return MaterialApp(
      title: 'My Page',
      home: Scaffold(
        appBar: UpperAppbar(context).changeTitle('마이페이지', context).appBar,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // 메인 프로필
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 94,
                    padding: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: Image.asset('assets/images/baseProfile.jpg'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Row(
                            children: <Widget>[
                              GetUserName('user1', nicknameTextStyle),
                              Text(
                                ' 님은',
                                style: introTextStyle,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              '재배 일지를 작성한 지',
                              style: introTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              '$period',
                              style: numberTextStyle,
                            ),
                            Text(
                              ' 일 째,',
                              style: introTextStyle,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '총 ',
                              style: introTextStyle,
                            ),
                            GetPlants(numberTextStyle),
                            Text(
                              ' 종류의 식물을 ',
                              style: introTextStyle,
                            ),
                          ],
                        ),
                        Text(
                          '가꾸고 있어요!',
                          style: introTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // 폴더 리스트
              Container(
                color: Color.fromARGB(255, 255, 255, 255),
                alignment: Alignment.topCenter,
                child: Column(
                  children: <Widget>[
                    // 현재 기르는 식물 폴더
                    SimpleFoldingCell.create(
                      key: _foldingCellKey1,
                      frontWidget:
                          _buildFrontWidget(_foldingCellKey1, '현재 기르는 식물'),
                      innerWidget: _buildInnerWidget(
                          _foldingCellKey1, '현재 기르는 식물', _CurrentPlantWidget()),
                      cellSize: Size(MediaQuery.of(context).size.width, 160),
                      padding: EdgeInsets.all(15),
                      animationDuration: Duration(milliseconds: 300),
                      borderRadius: 10,
                      onOpen: () => print('cell opened'),
                      onClose: () => print('cell closed'),
                    ),

                    // 재배 종료 식물 폴더
                    SimpleFoldingCell.create(
                      key: _foldingCellKey2,
                      frontWidget:
                          _buildFrontWidget(_foldingCellKey2, '재배 종료 식물'),
                      innerWidget: _buildInnerWidget(_foldingCellKey2,
                          '재배 종료 식물', /* 종료 식물 없음 */ Text('')),
                      cellSize: Size(MediaQuery.of(context).size.width, 160),
                      padding: EdgeInsets.all(15),
                      animationDuration: Duration(milliseconds: 300),
                      borderRadius: 10,
                      onOpen: () => print('cell opened'),
                      onClose: () => print('cell closed'),
                    ),
                  ],
                ),
              ),

              Card(
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Icon(
                        Icons.edit,
                        size: 50,
                      ),
                    ),
                    const Text(
                      '작성한 일지 수 : ',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      '$numOfReports',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Divider(),
                    ),
                  ],
                ),
              ),

              Card(
                color: Color.fromARGB(255, 230, 230, 230),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              '기준',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          toggle
                        ],
                      ),
                    ),
                    _isPlant
                        ? Column(
                            children: [
                              _CurrentPlantWidget(),
                              ReportCards(reportInfoList)
                                  .generate()
                                  .reportCardList,
                            ],
                          )
                        : Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10.0),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  yearList[0],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                              ReportCards(reportInfoList)
                                  .generate()
                                  .reportCardList,
                            ],
                          ),
                  ],
                ),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FinalReportViewPage())),
                  child: Text('일지 보기')
              ),
              // 로그아웃 버튼
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextButton(
                  onPressed: logout,
                  child: const Text(
                    '로그아웃',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFrontWidget(
      GlobalKey<SimpleFoldingCellState> key, String title) {
    return Container(
      color: Color(0xFFffcd3c),
      alignment: Alignment.center,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF2e282a),
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: TextButton(
              onPressed: () => key?.currentState?.toggleFold(),
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFfdfdfd),
                minimumSize: Size(80, 40),
              ),
              child: const Text(
                "열기",
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInnerWidget(
      GlobalKey<SimpleFoldingCellState> key, String title, Widget widget) {
    return Container(
      color: Color(0xFFecf2f9),
      padding: EdgeInsets.only(top: 10),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFF2e282a),
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Align(
              alignment: Alignment.topCenter,
              child: widget,
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: TextButton(
              onPressed: () => key?.currentState?.toggleFold(),
              child: const Text(
                "닫기",
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: Size(80, 40),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void logout() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text(
              '로그아웃',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('로그아웃 하시겠습니까?'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Fluttertoast.showToast(
                      msg: '로그아웃 하였습니다.', toastLength: Toast.LENGTH_SHORT);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: const Text('확인'),
              ),
              TextButton(
                onPressed: () => {Navigator.pop(context)},
                child: const Text('취소'),
              )
            ],
          );
        });
  }
}

class _CurrentPlantWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CurrentPlantWidgetState();
}

class _CurrentPlantWidgetState extends State<_CurrentPlantWidget> {
  final CollectionReference _plantsInfo =
      FirebaseFirestore.instance.collection('plants');
  List<Widget> _plantCardList = [];

  Color _getColorCode(String colorCode) {
    RegExp regex = RegExp('0x[a-zA-z0-9]+');
    int hex = int.parse(regex.stringMatch(colorCode) ?? '0xFFffffff');

    return Color(hex);
  }

  Future<QuerySnapshot<Object?>> _getData() async {
    return await _plantsInfo.get();
  }

  Future _addPlantCard() async {
    var data = _getData();
    await data.then((value) {
      if (value.docs.isNotEmpty) {
        log(value.docs.length.toString());
        for (int i = 0; i < value.docs.length; ++i) {
          Map<String, dynamic> map =
              value.docs[i].data() as Map<String, dynamic>;
          log(map.toString(), name: 'map');
          _plantCardList
              .add(plantCard(map['name'], _getColorCode(map['color'])));
        }
      } else {
        print('not found');
      }
    });
    return _plantCardList;
  }

  @override
  Widget build(Object context) {
    log(_plantCardList.toString(), name: '_plantCardList');
    return FutureBuilder(
      future: _addPlantCard(),
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
          return Container(
            height: 100,
            margin: EdgeInsets.symmetric(vertical: 20.0),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _plantCardList,
            ),
          );
        }
      },
    );
  }

  Widget plantCard(String name, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(80),
        child: Container(
            width: 100,
            height: 0,
            color: color,
            child: Center(
              child: Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            )),
      ),
    );
  }
}
