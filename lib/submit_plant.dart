import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'comp_upper_appbar.dart';
import 'package:intl/intl.dart';


// 식물 등록 페이지
class SubmitPlantPage extends StatefulWidget {
  const SubmitPlantPage({Key? key}) : super(key: key);

  @override
  _SubmitPlantPageState createState() => _SubmitPlantPageState();
}

class _SubmitPlantPageState extends State<SubmitPlantPage> {
  final _plantNameController = TextEditingController();
  final _nicknameController = TextEditingController();

  DateTime today = new DateTime.now();
  //String formattedDate = DateFormat('yyyy/mm/dd').format(today);
  //TextEditingController _startDateController = new TextEditingController(text: formattedDate);
  final _endDateController = TextEditingController();
  final _goalsController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    DateTime today = new DateTime.now();
    String formattedDate = DateFormat('yyyy/mm/dd').format(today);
    //TextEditingController _startDateController = new TextEditingController(text: today.toString());
    TextEditingController _startDateController = new TextEditingController(text: formattedDate);

    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // date picker dialog
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
    UpperAppbar appbar = new UpperAppbar();

    return MaterialApp(

        home: Scaffold(
          appBar: appbar.appBar,

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
                        const Text('재배 시작일 '),
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
                        const Text('재배 종료일 '),
                        IconButton(
                            icon: const Icon(Icons.calendar_month),
                            onPressed: () {
                              showDialog(context: context, builder: (context){
                                return AlertDialog(
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
                        const Text('목표 '),
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
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () async {
                        print('${_plantNameController.text}');
                        print('${_nicknameController.text}');
                        print('${_startDateController.text}');
                        print('${_endDateController.text}');
                        print('${_goalsController.text}');
                        await FirebaseFirestore.instance.collection('plants').add(
                            {'name': _plantNameController.text,
                              'nickname': _nicknameController.text,
                              'startDate': _startDateController.text,
                              'endDate': _endDateController.text,
                              'goal': _goalsController.text
                            }
                        ).then((value) => print("완료"));


                      },
                      child: const Text('저장하기'),
                    ),



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