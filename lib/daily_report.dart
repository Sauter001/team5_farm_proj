import 'dart:async';
import 'dart:io';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'package:flutter_3d_choice_chip/flutter_3d_choice_chip.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

enum MediaType {
  image,
  video;
}

void main() {
  runApp(const MyApp());
}

// 앱 제목
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '일지 작성하기',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: '일지 작성하기'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MediaType _mediaType = MediaType.image;

  String? imagePath;

  // 체크리스트 클릭
  bool _isCheckedWater = false;
  bool _isCheckedSoil = false;

  // 날씨 아이콘 클릭
  bool _sunnyPressed = false;
  bool _cloudPressed = false;
  bool _airPressed = false;
  bool _acPressed = false;
  bool _snowPressed = false;

  // 작물 버튼 클릭
  bool _potatoPressed = false;
  bool _sweetPotatoPressed = false;
  bool _carrotPressed = false;
  bool _lettucePressed = false;

  List<DateTime?> _dialogCalendarPickerValue = [
    // 입력받은 날짜 값을 출력하면 되는데 
    // 값이 없으면 null 값 출력
    DateTime(2022, 12, 30),
  ];


  @override
  Widget build(BuildContext context) {

      final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));


    return Scaffold(
      appBar: AppBar(
        //centerTitle: true,
        title: const Text("Image & Video Picker example"),
      ),
      body: Center(      
          child: SingleChildScrollView( 
        child: Container( 
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildDefaultSingleDatePickerWithValue(),
                ],
              ),
                // 작물 버튼

              
              Row(
                //mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    backgroundColor: _sweetPotatoPressed ?Colors.red : Colors.green),
                    onPressed: () {
                      setState(() {
                        _sweetPotatoPressed = !_sweetPotatoPressed;
                      });
                    },
                    child: const Text('고구마',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    backgroundColor: _potatoPressed ?Colors.red : Colors.green),
                    onPressed: () {
                      setState(() {
                        _potatoPressed = !_potatoPressed;
                      });
                    },
                    child: const Text('감자',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    backgroundColor: _carrotPressed ?Colors.red : Colors.green),
                    onPressed: () {
                      setState(() {
                        _carrotPressed = !_carrotPressed;
                      });
                    },
                    child: const Text('당근',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    backgroundColor: _lettucePressed ?Colors.red : Colors.green),
                    onPressed: () {
                      setState(() {
                        _lettucePressed = !_lettucePressed;
                      });
                    },
                    child: const Text('상추',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),

                const Text('날씨'),
              Row(
                //mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: <Widget>[
                 
                  IconButton(
                    icon: Icon(Icons.wb_sunny_outlined),
                    color: _sunnyPressed ? Colors.red : Colors.green,
                    //size: 30.0,
                    onPressed: () {
                      setState(() {
                        _sunnyPressed = !_sunnyPressed;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.cloud_outlined),
                    color: _cloudPressed ? Colors.red : Colors.green,
                    //size: 30.0,
                    onPressed: () {
                      setState(() {
                        _cloudPressed = !_cloudPressed;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.air),
                    color: _airPressed ? Colors.red : Colors.green,
                    //size: 30.0,
                    onPressed: () {
                      setState(() {
                        _airPressed = !_airPressed;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.ac_unit_outlined),
                    color: _acPressed ? Colors.red : Colors.green,
                    //size: 30.0,
                    onPressed: () {
                      setState(() {
                        _acPressed = !_acPressed;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.cloudy_snowing),
                    color: _snowPressed ? Colors.red : Colors.green,
                    //size: 30.0,
                    onPressed: () {
                      setState(() {
                        _snowPressed = !_snowPressed;
                      });
                    },
                  ),
                ],
              ),

                const Text('사진'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ChoiceChip3D(
                      style: ChoiceChip3DStyle.blue,
                      selected: _mediaType == MediaType.image,
                      onSelected: () {
                        setState(() {
                          _mediaType = MediaType.image;
                        });
                      },
                      onUnSelected: () {},
                      height: 50,
                      child: const Text(
                        "사진 버튼",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    ChoiceChip3D(
                      style: ChoiceChip3DStyle.red,
                      selected: _mediaType == MediaType.video,
                      onSelected: () {
                        setState(() {
                          _mediaType = MediaType.video;
                        });
                      },
                      onUnSelected: () {},
                      height: 50,
                      child: const Text(
                        "비디오 버튼",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                (imagePath != null)
                    ? Image.file(File(imagePath!))
                    : Container(
                        width: 300,
                        height: 300,
                        color: Colors.grey[300]!,
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.grey,
                            shadowColor: Colors.grey[400],
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onPressed: () {
                            pickMedia(ImageSource.gallery);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.image,
                                  size: 30,
                                  color: Colors.red,
                                ),
                                Text(
                                  "갤러리",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        )),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.grey,
                            shadowColor: Colors.grey[400],
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onPressed: () {
                            pickMedia(ImageSource.camera);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.camera_alt,
                                  size: 30,
                                  color: Colors.red,
                                ),
                                Text(
                                  "카메라",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
                             
                Row(
                //mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                // 물주기 흙갈기 위젯 버튼
                children: <Widget>[
                  const Text('물주기'),
                  Checkbox(
                    value: _isCheckedWater,
                    onChanged: (value) {
                      setState(() {
                        _isCheckedWater = value!;
                      });
                    }
                  ),
                  const Text('흙갈기'),
                  Checkbox(
                    value: _isCheckedSoil,
                    onChanged: (value) {
                      setState(() {
                        _isCheckedSoil = value!;
                      });
                    }
                  ),
                ],
              ),

                const Text('메모'),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16), // 위치 정하기
                child: TextField(
                  //maxLines: maxLine,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '메모를 작성해 주세요',
                    filled: true,
                  ),
                  minLines: 5,
                  maxLines: 6,
                ),
              ),
                Row(
                //mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: <Widget>[
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
                    ),
                    onPressed: () {
                      _showSaveDialog(context);
                    },
                    child: const Text('작성완료'),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                    ),
                    onPressed: () {
                      _showDeleteDialog(context);
                    },
                    child: const Text('삭제하기'),
                  ),
                ],
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void pickMedia(ImageSource source) async {
    XFile? file;
    if (_mediaType == MediaType.image) {
      file = await ImagePicker().pickImage(source: source);
    } else {
      file = await ImagePicker().pickVideo(source: source);
    }
    if (file != null) {
      imagePath = file.path;
      if (_mediaType == MediaType.video) {
        imagePath = await VideoThumbnail.thumbnailFile(
            video: file.path,
            imageFormat: ImageFormat.PNG,
            quality: 100,
            maxWidth: 300,
            maxHeight: 300);
      }
      setState(() {});
    }
  }

  Future<dynamic> _showSaveDialog(BuildContext context) {
    return showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text('확인 알림'),
              content: Text('일지를 저장하시겠습니까?'),
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('네')),
                ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('아니오')),
              ],
            ),
          );
  }

  Future<dynamic> _showDeleteDialog(BuildContext context) {
    return showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text('확인 알림'),
              content: Text('일지를 삭제하시겠습니까?'),
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('네')),
                ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('아니오')),
              ],
            ),
          );
  }


  // 달력 날짜 클릭시 시간 삭제
  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    var valueText = (values.isNotEmpty ? values[0] : DateTime.now())
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.single) {
      if (values.isNotEmpty) {
        final startDate = (values.isNotEmpty ? values[0] : DateTime.now()).toString().replaceAll('00:00:00.000', '');
        valueText = '$startDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }

  
  _buildCalendarDialogButton() {
    const dayTextStyle =
        TextStyle(color: Colors.black, fontWeight: FontWeight.w700);
    final config = CalendarDatePicker2WithActionButtonsConfig(
        dayTextStyle: dayTextStyle,
        calendarType: CalendarDatePicker2Type.single,
        selectedDayHighlightColor: Colors.red[800], // 버튼 클릭 달력 색
        closeDialogOnCancelTapped: true,
        firstDayOfWeek: 1,
        weekdayLabelTextStyle: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
        controlsTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        dayTextStylePredicate: ({required date}) {
          TextStyle? textStyle;
          return textStyle;
        },
        dayBuilder: ({
          required date,
          textStyle,
          decoration,
          isSelected,
          isDisabled,
          isToday,
        }) {
          Widget? dayWidget;
          return dayWidget;
        });
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            // 달력 아이콘
            icon: Icon(Icons.event), 
                    color: Colors.green,
            onPressed: () async {
              final values = await showCalendarDatePicker2Dialog(
                context: context,
                config: config,
                dialogSize: const Size(325, 400),
                borderRadius: BorderRadius.circular(15),
                initialValue: _dialogCalendarPickerValue,
                dialogBackgroundColor: Colors.white, // 날짜 선택 배경
              );

              if (values != null) {
                // ignore: avoid_print
                print(_getValueText(
                  config.calendarType,
                  values,
                ));
                setState(() {
                    _dialogCalendarPickerValue = values; // 캘린더를 누르면 값이 변경되도록 만들기                  
                });
              } 
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultSingleDatePickerWithValue() {
    final config = CalendarDatePicker2Config(
    );
    //final startDate = _dialogCalendarPickerValue.toString().replaceAll('00:00:00.000', '');

    // 화면에 출력되는 내용
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    
      children: <Widget>[  
        // 버튼 클릭시 이전 날짜로 이동
        IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: Colors.green,
                    //size: 30.0,
                    onPressed: () {
                      // _dialogCalendarPickerValue = _dialogCalendarPickerValue.subtract(Duration(days: 10));
                      // 
                    },
                  ),  
        _buildCalendarDialogButton(), 
        const SizedBox(width: 10),

        // 선택한 날짜 화면에 출력하기
            Text(
              _getValueText(
                config.calendarType,
                _dialogCalendarPickerValue,
              ),
              style: TextStyle(fontSize: 30),
            ),
            
            // 버튼 클릭시 다음 날짜로 이동
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              color: Colors.green,
                    //size: 30.0,
              onPressed: () {
                //_dialogCalendarPickerValue = _dialogCalendarPickerValue.add(Duration(days: 1));
              },
            ),
      ],
    );
  }
}