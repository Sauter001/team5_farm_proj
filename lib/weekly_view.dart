// 주간 일지 화면 구성
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:timelines/timelines.dart';

import 'package:farm_management_proj/comp_lower_appbar.dart';
import 'package:farm_management_proj/comp_upper_appbar.dart';

UpperAppbar appbar = UpperAppbar();
LowerAppBar navigationbar = LowerAppBar();

const kTileHeight = 50.0;

const completeColor = Color(0xff5e6172);
const inProgressColor = Color(0xff5ec792);
const todoColor = Color(0xffd1d2d7);

int _dayIndex = 2;

Color getColor(int index) {
  if (index == _dayIndex) {
    return inProgressColor;
  } else if (index < _dayIndex) {
    return completeColor;
  } else {
    return todoColor;
  }
}

class WeeklyViewPage extends StatefulWidget {
  const WeeklyViewPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WeeklyViewPageState();
}

class _WeeklyViewPageState extends State<WeeklyViewPage> {
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
    // ignore: dead_code
    return MaterialApp(
        home: Scaffold(
            appBar: appbar.appBar,
            body: EventCalendar(
                calendarType: CalendarType.GREGORIAN,
                calendarLanguage: 'en',
                calendarOptions: CalendarOptions(viewType: ViewType.MONTHLY),
                headerOptions: HeaderOptions(
                    weekDayStringType: WeekDayStringTypes.SHORT,
                    monthStringType: MonthStringTypes.FULL),
                eventOptions: EventOptions(
                    emptyText: '할 일을 생성해 주세요.', emptyTextColor: Colors.black12),
                dayOptions: DayOptions(
                    eventCounterViewType: DayEventCounterViewType.DOT),
                showLoadingForEvent: true,
                events: [
                  // 이벤트별 식물의 타임라인 구현
                  Event(
                      child: Row(),
                      dateTime: CalendarDateTime(
                          year: 2022,
                          month: 12,
                          day: 28,
                          calendarType: CalendarType.GREGORIAN)),
                  Event(
                      child: const Text('another one'),
                      dateTime: CalendarDateTime(
                          year: 2022,
                          month: 12,
                          day: 28,
                          calendarType: CalendarType.GREGORIAN))
                ]),
            bottomNavigationBar: navigationbar.navigationBar));
  }
}
