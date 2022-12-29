import 'package:flutter/material.dart';

class ReportCards {
  final Column _column = Column();
  List _dateImgList = [];
  List<Widget> _reportCardList = [];

  ReportCards(this._dateImgList);

  ReportCards generate() {
    _dateImgList.forEach(
      (element) {
        _reportCardList.add(
          ClipRect(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 200,
                child: Column(
                  children: <Widget>[
                    _ReportCard(element),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    return this;
  }

  get reportCardList {
    return Container(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: _reportCardList,
      ),
    );
  }
}

class _ReportCard extends StatelessWidget {
  String _date = '';
  Widget _image = Text('');

  void generate(dynamic element) {
    _date = element['date'];

    _image = element['img'] == ''
        ? Text(
            element['name'],
            style: TextStyle(fontSize: 15),
          )
        : Image.asset(element['img']);
  }

  _ReportCard(element) {
    generate(element);
  }

  @override
  Widget build(Object context) {
    return Container(
      width: 120,
      height: 160,
      color: Colors.white,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          Text(
            _date,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          Container(
            child: Center(child: _image),
          ),
        ],
      ),
    );
  }
}
