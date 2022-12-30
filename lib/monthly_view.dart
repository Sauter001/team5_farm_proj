import 'package:farm_management_proj/weekly_view.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'comp_upper_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'comp_lower_appbar.dart';
import 'daily_report.dart';
import 'final_report.dart';


class MonthlyViewPage extends StatefulWidget {
  const MonthlyViewPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MonthlyViewPageState();
}
class _MonthlyViewPageState extends State<MonthlyViewPage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(_selectedIndex == 0){
        Navigator.push(context, MaterialPageRoute(builder: (context) => MonthlyViewPage()));
      }
      if(_selectedIndex == 1){
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: '일지 작성',)));
      }
      if(_selectedIndex == 2){
        Navigator.push(context, MaterialPageRoute(builder: (context) => FinalReportPage()));
      }
      if(_selectedIndex == 3){
        Navigator.push(context, MaterialPageRoute(builder: (context) => WeeklyViewPage()));
      }
    });
  }
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime focusedDay = DateTime.now();
/*
  Map<DateTime, List<Event>> events = {
    DateTime.utc(2022,12,13) : [ Event('title1'), Event('title2') ],
    DateTime.utc(2022,12,14) : [ Event('title3') ],
  };
*/

  /*
  DocumentReference<Map<String, dynamic>> documentReference =
    await FirebaseFirestore.instance.collection('plants').doc('carrot').get();
*/
  @override
  Widget build(BuildContext context)  {

    UpperAppbar appbar = new UpperAppbar(context);
    appbar.changeTitle('월간', context);

    LowerAppBar lowerAppbar = new LowerAppBar();

    return Scaffold(
      appBar: appbar.appBar,
        body: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 10,left:25),
                    child: Text('이름: 선인짱(선인장)\n재배 시작일: 2022-12-30\n목표: 죽이지 않기',
                    style: TextStyle(fontSize: 16),),

                  ),
                  Divider(
                    indent: 15,
                    endIndent: 15,
                    color: Colors.black38,
                    thickness: 2.0,
                  ),
                  FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('plants')
                        .doc('선인장')
                        .get(),
                    builder: (context, AsyncSnapshot snapshot){
                      if (!snapshot.hasData) return const Scaffold();
                      Map<DateTime, List<Event>> events = {};
                      var date = DateTime.utc(DateTime.parse(snapshot.data['startDate']).year,DateTime.parse(snapshot.data['startDate']).month,DateTime.parse(snapshot.data['startDate']).day);
                      for(int i=0; i<20; i++){
                        events.addAll({date : [Event(snapshot.data['nickname'])]});
                        date = date.add(const Duration(days: 7));
                      }

                      List<Event> _getEventsForDay(DateTime day) {
                        return events[day] ?? [];
                      }
                      return TableCalendar(
                        //locale: 'ko_KR',
                        firstDay: DateTime.utc(2021, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: DateTime.now(),
                        onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                          // 선택된 날짜의 상태를 갱신합니다.
                          setState((){

                            this.selectedDay = selectedDay;
                            this.focusedDay = focusedDay;
                          });

                        },
                        selectedDayPredicate: (DateTime day) {
                          // selectedDay 와 동일한 날짜의 모양을 바꿔줍니다.
                          return isSameDay(selectedDay, day);
                        },
                        calendarStyle: CalendarStyle(
                          markerSize: 10.0,
                          markerDecoration: BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle
                          ),
                        ),
                        eventLoader: _getEventsForDay,
                      );
                    },
                  ),
                  Divider(
                    indent: 15,
                    endIndent: 15,
                    color: Colors.black38,
                    thickness: 2.0,
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 20,left:25),
                    child: Text('< 오늘 할 일 >',
                      style: TextStyle(fontSize: 16),),
                  ),

                  Container(
                    margin: const EdgeInsets.only(left:25),
                    child: Text('● 선인짱: 물 주기',
                      style: TextStyle(fontSize: 14),),

                  ),
                ]
            ),


        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black54,
          unselectedItemColor: Colors.black,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Colors.green,
              icon: Icon(Icons.calendar_month),
              label: '월별 보기',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.green,
              icon: Icon(Icons.mode_edit),
              label: '일지 작성',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.green,
              icon: Icon(Icons.square),
              label: '재배 종료',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.green,
              icon: Icon(Icons.bookmark),
              label: '주별 보기',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        )

    );
  }
}

class Event {
  String title;

  Event(this.title);
}