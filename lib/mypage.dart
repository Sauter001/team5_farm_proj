import 'package:flutter/material.dart';
import 'package:folding_cell/folding_cell.dart';
import 'comp_upper_appbar.dart';

// 마이 페이지

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final _foldingCellKey1 = GlobalKey<SimpleFoldingCellState>();
  final _foldingCellKey2 = GlobalKey<SimpleFoldingCellState>();
  final _foldingCellKey3 = GlobalKey<SimpleFoldingCellState>();

  @override
  Widget build(BuildContext context) {
    String nickname = '텃밭입문';
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

    return MaterialApp(
      title: 'My Page',
      home: Scaffold(
        appBar: UpperAppbar().changeTitle('마이페이지').appBar,
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
                        Row(
                          children: <Widget>[
                            Text(
                              nickname,
                              style: nicknameTextStyle,
                            ),
                            Text(
                              ' 님은',
                              style: introTextStyle,
                            ),
                          ],
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
                            Text(
                              '$plantType',
                              style: numberTextStyle,
                            ),
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
                        innerWidget:
                            _buildInnerWidget(_foldingCellKey1, '현재 기르는 식물'),
                        cellSize: Size(MediaQuery.of(context).size.width, 140),
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
                        innerWidget:
                            _buildInnerWidget(_foldingCellKey2, '재배 종료 식물'),
                        cellSize: Size(MediaQuery.of(context).size.width, 140),
                        padding: EdgeInsets.all(15),
                        animationDuration: Duration(milliseconds: 300),
                        borderRadius: 10,
                        onOpen: () => print('cell opened'),
                        onClose: () => print('cell closed'),
                      ),

                      // 작성 일지 수 폴더
                      SimpleFoldingCell.create(
                        key: _foldingCellKey3,
                        frontWidget: _buildFrontWidget(
                            _foldingCellKey3, '작성한 일지 수 : $numOfReports'),
                        innerWidget:
                            _buildInnerWidget(_foldingCellKey3, '작성한 일지'),
                        cellSize: Size(MediaQuery.of(context).size.width, 140),
                        padding: EdgeInsets.all(15),
                        animationDuration: Duration(milliseconds: 300),
                        borderRadius: 10,
                        onOpen: () => print('cell opened'),
                        onClose: () => print('cell closed'),
                      ),
                    ],
                  )),
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
      GlobalKey<SimpleFoldingCellState> key, String title) {
    return Container(
      color: Color(0xFFecf2f9),
      padding: EdgeInsets.only(top: 10),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              title,
              style: TextStyle(
                color: Color(0xFF2e282a),
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "detail",
              style: TextStyle(
                color: Color(0xFF2e282a),
                fontSize: 40.0,
              ),
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
}
