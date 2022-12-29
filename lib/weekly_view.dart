// 주간 일지 화면 구성
import 'package:farm_management_proj/comp_lower_appbar.dart';
import 'package:farm_management_proj/comp_upper_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';

class WeeklyViewPage extends StatefulWidget {
  const WeeklyViewPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WeeklyViewPageState();
}

class _WeeklyViewPageState extends State<WeeklyViewPage> {
  LowerAppBar navigationbar = LowerAppBar();

  @override
  Widget build(BuildContext context) {
    UpperAppbar appbar = UpperAppbar(context).changeTitle('주간 일지', context);
    return MaterialApp(
      home: Scaffold(
        appBar: appbar.appBar,
        bottomNavigationBar: navigationbar.navigationBar,
        body: Center(
          child: EventCalendar(
            calendarType: CalendarType.GREGORIAN,
            calendarLanguage: 'en',
            calendarOptions: CalendarOptions(viewType: ViewType.MONTHLY),
            headerOptions: HeaderOptions(
                weekDayStringType: WeekDayStringTypes.SHORT,
                monthStringType: MonthStringTypes.FULL),
            eventOptions: EventOptions(
                emptyText: '할 일을 생성해 주세요.', emptyTextColor: Colors.black12),
            dayOptions:
                DayOptions(eventCounterViewType: DayEventCounterViewType.DOT),
            showLoadingForEvent: true,
            events: [
              Event(
                  child: const Text('test Event'),
                  dateTime: CalendarDateTime(
                      year: 2022,
                      month: 12,
                      day: 28,
                      calendarType: CalendarType.GREGORIAN))
            ],
          ),
        ),
      ),
    );
  }
}
