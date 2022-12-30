import 'package:farm_management_proj/comp_lower_appbar.dart';
import 'package:farm_management_proj/comp_upper_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:intl/intl.dart';

class WeeklyViewPage extends StatefulWidget {
  const WeeklyViewPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WeeklyViewPageState();
}

class _WeeklyViewPageState extends State<WeeklyViewPage> {
  final CalendarWeekController _controller = CalendarWeekController();
  LowerAppBar navigationbar = LowerAppBar();

  @override
  Widget build(BuildContext context) {
    UpperAppbar appbar = UpperAppbar(context).changeTitle('주간 일지', context);
    return MaterialApp(
      home: Scaffold(
        appBar: appbar.appBar,
        bottomNavigationBar: navigationbar.navigationBar,
        body: Column(children: [
          Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 1)
              ]),
              child: CalendarWeek(
                controller: _controller,
                height: 100,
                showMonth: true,
                minDate: DateTime.now().add(
                  Duration(days: -365),
                ),
                maxDate: DateTime.now().add(
                  Duration(days: 365),
                ),
                onDatePressed: (DateTime datetime) {
                  // Do something
                  setState(() {});
                },
                onDateLongPressed: (DateTime datetime) {
                  // Do something
                },
                onWeekChanged: () {
                  // Do something
                },
                monthViewBuilder: (DateTime time) => Align(
                  alignment: FractionalOffset.center,
                  child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        DateFormat.yMMMM().format(time),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.w600),
                      )),
                ),
                decorations: [
                  DecorationItem(
                      decorationAlignment: FractionalOffset.bottomRight,
                      date: DateTime.now(),
                      decoration: Icon(
                        Icons.today,
                        color: Colors.blue,
                      )),
                  DecorationItem(
                      date: DateTime.now().add(Duration(days: 3)),
                      decoration: Text(
                        'Holiday',
                        style: TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                ],
              )),
          //타임라인 할일별 카드
          Expanded(
            child: Center(
              child: Text(
                '${_controller.selectedDate.day}/${_controller.selectedDate.month}/${_controller.selectedDate.year}',
                style: TextStyle(fontSize: 30),
              ),
            ),
          )
        ]),
      ),
    );
  }
}