import 'dart:async';
import 'dart:io';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

final today = DateUtils.dateOnly(DateTime.now());


void main() {
  runApp(const DailyReportPage());
}

// 앱 제목
class DailyReportPage extends StatelessWidget {
  const DailyReportPage({Key? key}) : super(key: key);

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

// 캘린더
class _MyHomePageState extends State<MyHomePage> {
  List<XFile>? _imageFileList;

  bool _isCheckedWater = false;
  bool _isCheckedSoil = false;

  bool _sunnyPressed = false;
  bool _cloudPressed = false;
  bool _airPressed = false;
  bool _acPressed = false;
  bool _snowPressed = false;



  void _setImageFileListFromFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  dynamic _pickImageError;
  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();  

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
      await _displayPickImageDialog(context!,
          (double? maxWidth, double? maxHeight, int? quality) async {
        try {
          final XFile? pickedFile = await _picker.pickImage(
            source: source,
          );
          setState(() {
            _setImageFileListFromFile(pickedFile);
          });
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      });
  }



  @override
  void dispose() {
    super.dispose();
  }


  Widget _previewImages() {
    if (_imageFileList != null) {
      return Semantics(
        label: 'image_picker_example_picked_images',
        child: ListView.builder(
          key: UniqueKey(),
          itemBuilder: (BuildContext context, int index) {
            // Why network for web?
            // See https://pub.dev/packages/image_picker#getting-ready-for-the-web-platform
            return Semantics(
              label: 'image_picker_example_picked_image',
              child: kIsWeb
                  ? Image.network(_imageFileList![index].path)
                  : Image.file(File(_imageFileList![index].path)),
            );
          },
          itemCount: _imageFileList!.length,
        ),
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _handlePreview() {
      return _previewImages();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
        setState(() {
          if (response.files == null) {
            _setImageFileListFromFile(response.file);
          } else {
            _imageFileList = response.files;
          }
        });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }


  // 캘린더 값을 기본값을 오늘로 설정
  List<DateTime?> _dialogCalendarPickerValue = [
    DateTime.now(),
  ];
  // body에 버튼과 달력 위치시키기
  @override
  Widget build(BuildContext context) {
    
    final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SizedBox(
          width: 375,
          child: ListView(
            children: <Widget>[
              _buildCalendarDialogButton(),
              _buildDefaultSingleDatePickerWithValue(),
              
              // 작물 버튼
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: <Widget>[
                  OutlinedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
                    ),
                    onPressed: () {
                    },
                    child: const Text('고구마',
                    style: TextStyle(
                      color: Colors.black,
                    ),),
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
                    ),
                    onPressed: () {},
                    child: const Text('감자',
                    style: TextStyle(
                      color: Colors.black,
                    ),),
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
                    ),
                    onPressed: () {},
                    child: const Text('당근',
                    style: TextStyle(
                      color: Colors.black,
                    ),),
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
                    ),
                    onPressed: () {},
                    child: const Text('상추',
                    style: TextStyle(
                      color: Colors.black,
                    ),),
                  ),
                ],
              ),

              const Text('날씨'),
              Row(
                mainAxisSize: MainAxisSize.min,
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
              Semantics(
                    label: 'image_picker_example_from_gallery',
                    child: FloatingActionButton(
                      onPressed: () {
                        //isVideo = false;
                        _onImageButtonPressed(ImageSource.gallery, context: context);
                      },
                      heroTag: 'image0',
                      tooltip: 'Pick Image from gallery',
                      child: const Icon(Icons.photo),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        _onImageButtonPressed(ImageSource.camera, context: context);
                      },
                      heroTag: 'image2',
                      tooltip: 'Take a Photo',
                      child: const Icon(Icons.camera_alt),
                    ),
                  ),
                  Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

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

              // 작성완료, 삭제 버튼
              Row(
                mainAxisSize: MainAxisSize.min,
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
    );
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


  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.single) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        //valueText = '$startDate';
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
                  _dialogCalendarPickerValue = values;
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

    // 화면에 출력되는 내용
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,

      children: <Widget>[  
        // 버튼 클릭시 이전 날짜로 이동
        IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: Colors.green,
                    //size: 30.0,
                    onPressed: () {
                    },
                  ),   
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
  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('사진을 업로드하시겠습니까?'),
            actions: <Widget>[
              TextButton(
                  child: const Text('네'),
                  onPressed: () {
                    final double? width = null;
                    final double? height = null;
                    final int? quality = null;
                    onPick(width, height, quality);
                    Navigator.of(context).pop();
                  }),
              TextButton(
                child: const Text('아니오'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);