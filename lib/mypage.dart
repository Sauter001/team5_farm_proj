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

    return MaterialApp(
      title: 'My Page',
      home: Scaffold(
        appBar: UpperAppbar().changeTitle('마이페이지').appBar,
        body: Container(
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
                              '일 째,',
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
            ],
          ),
        ),
      ),
    );
  }
}
