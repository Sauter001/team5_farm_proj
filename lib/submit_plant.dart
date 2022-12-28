/*import 'package:flutter/material.dart';

// 식물 등록 페이지
class SubmitPlantPage extends StatelessWidget {
  const SubmitPlantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

 */

import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

void main() => runApp(const SubmitPlantPage());
// 식물 등록 페이지
class SubmitPlantPage extends StatefulWidget {
  const SubmitPlantPage({Key? key}) : super(key: key);

  @override
  _SubmitPlantPageState createState() => _SubmitPlantPageState();
}

class _SubmitPlantPageState extends State<SubmitPlantPage> {
  final _plantNameController = TextEditingController();
  final _nicknameController = TextEditingController();
  TextEditingController _startDateController = new TextEditingController(text: DateTime.now().toString());
  final _endDateController = TextEditingController();
  final _goalsController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("날짜를 선택해주세요"),
      actions: [
        okButton,
      ],
      content: Container(
          width: 300,
          height: 300,
          child: CalendarDatePicker2(
            config: CalendarDatePicker2Config(),
            initialValue: [],
          )
      ),
    );
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('식물 등록'),
            ),
            body: SafeArea(
                child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    children: <Widget>[
                      const SizedBox(height: 12.0),
                      IconButton(
                        icon: const Icon(Icons.palette),
                        onPressed: () {},
                      ),
                      Row(
                        children: <Widget>[
                          const Text('이름  '),
                          Expanded(
                            child:
                            TextField(
                              decoration: const InputDecoration(
                                focusedBorder:
                                OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                                ),
                              ),
                              controller: _plantNameController,
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 12.0),

                      Row(
                        children: <Widget>[
                          const Text('애칭  '),
                          Expanded(
                            child:
                            TextField(
                              decoration: const InputDecoration(
                                focusedBorder:
                                OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                                ),
                              ),
                              controller: _nicknameController,
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 12.0),

                      Row(
                        children: <Widget>[
                          const Text('재배 시작일  '),
                          IconButton(
                              icon: const Icon(Icons.calendar_month),
                              onPressed: () {
                                showDialog(context: context, builder: (context){
                                  return alert;
                                });
                              }
                          ),
                          Expanded(
                            child:
                            TextField(
                              decoration: const InputDecoration(
                                focusedBorder:
                                OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                                ),
                              ),
                              controller: _startDateController,
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 12.0),

                      Row(
                        children: <Widget>[
                          const Text('재배 종료일  '),
                          IconButton(
                              icon: const Icon(Icons.calendar_month),
                              onPressed: () {
                                showDialog(context: context, builder: (context){
                                  return alert;
                                });
                              }
                          ),
                          Expanded(
                            child:
                            TextField(
                              decoration: const InputDecoration(
                                focusedBorder:
                                OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                                ),
                              ),
                              controller: _endDateController,
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 12.0),

                      Row(
                        children: <Widget>[
                          const Text('목표  '),
                          Spacer(),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('+ 추가'),
                          ),
                        ],
                      ),
                      Divider(),
                      TextField(
                        decoration: const InputDecoration(
                          focusedBorder:
                          OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2.0),
                          ),
                        ),
                        controller: _goalsController,

                      ),



                      const SizedBox(height: 12.0),

                      Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text('반복 설정'),
                            Spacer(),
                            ElevatedButton(
                              child: const Text('+ 추가'),
                              onPressed: () {
                                showDialog(context: context, builder: (context){
                                  return Dialog(
                                    child:
                                      Column(
                                        children: <Widget>[
                                          const Text('반복 설정 추가'),
                                          const SizedBox(height: 12),
                                          Divider(),
                                          const SizedBox(height: 18),
                                          const Text('이름'),
                                          const SizedBox(height: 8),

                                          Row(
                                              children: <Widget>[
                                                TextField(
                                                  decoration: const InputDecoration(
                                                    focusedBorder:
                                                      OutlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.green, width: 2.0),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                                                    ),
                                                  ),
                                                  controller: _plantNameController,
                                                ),
                                                // ** checkbox **
                                            ]
                                          ),
                                          const SizedBox(height: 18),
                                          const Text('이름'),
                                          const SizedBox(height: 8),

                                          Row(
                                            children: <Widget>[
                                              TextField(
                                                decoration: const InputDecoration(
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.green, width: 2.0),
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                                                  ),
                                                ),
                                                controller: _plantNameController,
                                              ),
                                              // ** checkbox **
                                              const Text(' 주마다'),
                                          ]),
                                          const SizedBox(height: 8),
                                          // ** weekday picker **
                                          const SizedBox(height: 25),
                                          Row(
                                            children: <Widget>[
                                              Spacer(),
                                              ElevatedButton(
                                                  child: const Text('닫기'),
                                                  onPressed: () {}
                                              ),
                                              ElevatedButton(
                                                  child: const Text('확인'),
                                                  onPressed: () {}
                                              )
                                            ]
                                          )
                                        ]
                                      )
                                  );
                                });
                              },
                            ),
                          ]
                      ),

                      Divider(),



                      /*
              TextField(
                decoration: const InputDecoration(
                  filled: true,
                  labelText: '비밀번호',
                ),
                obscureText: true,
              ),
              OverflowBar(
                alignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('취소'),
                    onPressed: (){
                    },
                  ),
                  ElevatedButton(
                    child: const Text('로그인'),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  )
                ],
              )*/
                    ]
                )
            ),
            // ** bottomNavigationBar: **

        )
    );
  }
}