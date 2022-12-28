import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'comp_upper_appbar.dart';
import 'package:intl/intl.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'dart:ui';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() => runApp(MyApp());
// 식물 등록 페이지

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SubmitPlantPage(),
    );
  }
}

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
    bool isChecked_todo1 = false;
    bool isChecked_todo2 = false;
    bool isChecked_todo3 = false;
    bool isChecked_todo4 = false;

    Color pickerColor = Color(0xff443a49);
    Color currentColor = Color(0xff443a49);

    void changeColor(Color color) {
      setState(() => pickerColor = color);
    }

    final values = List.filled(7, false);
    DateTime today = new DateTime.now();
    String formattedDate = DateFormat('yyyy/mm/dd').format(today);
    //TextEditingController _startDateController = new TextEditingController(text: today.toString());
    TextEditingController _startDateController = new TextEditingController(
        text: formattedDate);

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

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.green;
      }
      return Colors.black;
    }

    UpperAppbar appbar = new UpperAppbar();
    appbar.changeTitle('식물 등록');

    return Builder(
        builder: (BuildContext ctx) {
          return Scaffold(
            appBar: appbar.appBar,

            body:
            SafeArea(

                child: 
                  ListView(
                   // padding: const EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    children: <Widget>[
                      const SizedBox(height: 12.0),

                      Row(
                        children: <Widget>[
                          const Text('이름    ', style: TextStyle(fontSize: 20)),
                          Expanded(
                            child:
                            TextField(
                              decoration: const InputDecoration(
                                focusedBorder:
                                OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.green, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0),
                                ),
                              ),
                              style: TextStyle(fontSize: 25, height: 0.5,),
                              controller: _plantNameController,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.palette),
                            onPressed: () {
                              showDialog(context: ctx, builder: (context) {
                                return AlertDialog(
                                  title: const Text('대표색을 선택해주세요'),
                                  content: SingleChildScrollView(
                                     child: BlockPicker(
                                       pickerColor: currentColor,
                                       onColorChanged: changeColor,
                                     ),
                                  ),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      child: const Text('완료'),
                                      onPressed: () {
                                        setState(() => currentColor = pickerColor);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });

                            },
                            iconSize: 35,
                          ),
                        ],
                      ),

                      const SizedBox(height: 12.0),

                      Row(
                        children: <Widget>[
                          const Text('애칭    ', style: TextStyle(fontSize: 20)),
                          Expanded(
                            child:

                                  TextField(
                                    decoration: const InputDecoration(
                                      focusedBorder:
                                      OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.green, width: 2.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 2.0),
                                      ),
                                    ),
                                    style: TextStyle(fontSize: 25, height: 0.5,),
                                    controller: _nicknameController,
                                  ),

                          )
                        ],
                      ),

                      const SizedBox(height: 12.0),

                      Row(
                        children: <Widget>[
                          const Text('재배 시작일  ', style: TextStyle(fontSize: 20)),
                          IconButton(
                              icon: const Icon(Icons.calendar_month),
                              onPressed: () {
                                showDialog(context: ctx, builder: (context) {
                                  return alert;
                                });
                              },
                              iconSize: 30,
                          ),
                          Expanded(
                            child:
                            TextField(
                              decoration: const InputDecoration(
                                focusedBorder:
                                OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.green, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0),
                                ),
                              ),
                              style: TextStyle(fontSize: 25, height: 0.5,),
                              controller: _startDateController,
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 12.0),

                      Row(
                        children: <Widget>[
                          const Text('재배 종료일  ', style: TextStyle(fontSize: 20)),
                          IconButton(
                              icon: const Icon(Icons.calendar_month),
                              onPressed: () {
                                showDialog(context: ctx, builder: (context) {
                                  return alert;
                                });
                              },
                              iconSize: 30,
                          ),
                          Expanded(
                            child:
                            TextField(
                              decoration: const InputDecoration(
                                focusedBorder:
                                OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.green, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0),
                                ),
                              ),
                              style: TextStyle(fontSize: 25, height: 0.5,),
                              controller: _endDateController,
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 12.0),

                      Row(
                        children: <Widget>[
                          const Text('목표  ', style: TextStyle(fontSize: 20)),
                          Spacer(),
                          ElevatedButton(
                            onPressed: () {

                            },
                            child: const Text('+ 추가'),
                          ),
                        ],
                      ),
                      Divider(thickness: 2, color: Colors.black54, height: 15),
                      TextField(
                        decoration: const InputDecoration(
                          focusedBorder:
                          OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.green, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black, width: 2.0),
                          ),
                        ),
                        style: TextStyle(fontSize: 25, height: 0.5,),
                        controller: _goalsController,
                      ),


                      const SizedBox(height: 12.0),

                      Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text('반복 설정', style: TextStyle(fontSize: 20)),
                            Spacer(),
                            ElevatedButton(
                              child: const Text('+ 추가'),
                              onPressed: () {
                                showDialog(context: ctx, builder: (context) {
                                  return AlertDialog(
                                      title: const Text('반복 설정 추가', style: TextStyle(fontSize: 20)),
                                      content: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Divider(thickness: 2, color: Colors.black54, height: 5),

                                            Row(
                                                children: <Widget>[
                                                  Checkbox(
                                                    checkColor: Colors.white,
                                                    fillColor: MaterialStateProperty.resolveWith(getColor),
                                                    value: isChecked_todo1,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        isChecked_todo1 = value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('물 주기'),
                                                    Checkbox(
                                                      checkColor: Colors.white,
                                                      fillColor: MaterialStateProperty.resolveWith(getColor),
                                                      value: isChecked_todo2,
                                                      onChanged: (bool? value) {
                                                        setState(() {
                                                          isChecked_todo2 = value!;
                                                        });
                                                      },
                                                    ),
                                                  const Text('흙 갈기'),
                                              ]
                                            ),
                                            Row(
                                                children: <Widget>[
                                                  Checkbox(
                                                    checkColor: Colors.white,
                                                    fillColor: MaterialStateProperty.resolveWith(getColor),
                                                    value: isChecked_todo3,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        isChecked_todo3 = value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('????'),
                                                  Checkbox(
                                                    checkColor: Colors.white,
                                                    fillColor: MaterialStateProperty.resolveWith(getColor),
                                                    value: isChecked_todo4,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        isChecked_todo4 = value!;
                                                      });
                                                    },
                                                  ),
                                                  Expanded(
                                                    child:
                                                    TextField(
                                                      decoration: const InputDecoration(
                                                        focusedBorder:
                                                        OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .green,
                                                              width: 2.0),
                                                        ),
                                                        enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .black,
                                                              width: 2.0),
                                                        ),
                                                      ),
                                                      controller: _plantNameController, // 임시
                                                    ),
                                                  )
                                                ]
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                                children: <Widget>[
                                                  const Text('반복   '),
                                                  Expanded(
                                                    child:
                                                    TextField(
                                                      decoration: const InputDecoration(
                                                        focusedBorder:
                                                        OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .green,
                                                              width: 2.0),
                                                        ),
                                                        enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .black,
                                                              width: 2.0),
                                                        ),
                                                      ),
                                                      controller: _plantNameController, // 임시
                                                    ),
                                                  ),
                                                  const Text('주마다')
                                                ]
                                            ),
                                            WeekdaySelector(
                                              selectedFillColor: Colors.indigo,
                                              onChanged: (v) {
                                                print(v);
                                                setState(() {
                                                  values[v % 7] = !values[v % 7];
                                                });
                                              },
                                              values: values,
                                            ),

                                          ]),



                                      actions:
                                        <Widget>[
                                          Spacer(),
                                          ElevatedButton(
                                            child: const Text('닫기'),
                                            onPressed: () => Navigator.pop(context)
                                          ),
                                          ElevatedButton(
                                            child: const Text('확인'),
                                            onPressed: () {}
                                          )
                                        ]


                                  );
                                });
                              },
                            ),
                          ]
                      ),

                      Divider(thickness: 2, color: Colors.black54, height: 15),
                      const SizedBox(height: 30),
                      Spacer(),
                      SizedBox(
                        //alignment: Alignment.topCenter,
                        child:
                          ElevatedButton(
                            onPressed: () async {
                              print('${_plantNameController.text}');
                              print('${_nicknameController.text}');
                              print('${_startDateController.text}');
                              print('${_endDateController.text}');
                              print('${_goalsController.text}');
                              await FirebaseFirestore.instance.collection('plants')
                                  .add(
                                  {'name': _plantNameController.text,
                                    'nickname': _nicknameController.text,
                                    'startDate': _startDateController.text,
                                    'endDate': _endDateController.text,
                                    'goal': _goalsController.text
                                  }
                              )
                                  .then((value) => print("완료"));
                            },
                            child: const Text('저장하기'),
                        ),
                      )


                    ]
                )
            ),
            // ** bottomNavigationBar: **


          );
        }
    );
  }
}
