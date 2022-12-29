import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'comp_upper_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clean Calendar Demo',
      home: MonthlyViewPage(),
    );
  }
}

class MonthlyViewPage extends StatefulWidget {
  const MonthlyViewPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MonthlyViewPageState();
}
class _MonthlyViewPageState extends State<MonthlyViewPage> {


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
   /* Map<DateTime, List<Event>> events = {
      DateTime.utc(2022,12,13) : [ Event('title'), Event('title2') ],
      DateTime.utc(2022,12,14) : [ Event('title3') ],
    };
    List<Event> _getEventsForDay(DateTime day) {
      return events[day] ?? [];
    }*/
    //var plantName = documentSnapshot.;
    var documentSnapshot = FirebaseFirestore.instance
        .collection('plants')
        .doc('가지')
        .get()
        .then((DocumentSnapshot doc) {
          final data = doc.data();
          //final name = List.from(data?['name']);
        }
    );
    UpperAppbar appbar = new UpperAppbar(context);
    appbar.changeTitle('월간', context);

    return Scaffold(
      appBar: appbar.appBar,
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('plants')
            .doc('가지')
            .get(),
        builder: (context, AsyncSnapshot snapshot){
          if (!snapshot.hasData) return const Scaffold();
          Map<DateTime, List<Event>> events = {};
            var date = DateTime.utc(DateTime.parse(snapshot.data['startDate']).year,DateTime.parse(snapshot.data['startDate']).month,DateTime.parse(snapshot.data['startDate']).day);
            for(int i=0; i<10; i++){
              events.addAll({date : [Event(snapshot.data['name'])]});
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
      )


    );
  }
}

class Event {
  String title;

  Event(this.title);
}