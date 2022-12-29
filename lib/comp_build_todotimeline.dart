import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

// 타임라인 구현
class Timeline {
  bool _checkBoxVal = true;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Checkbox(
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() => _checkBoxVal = value);
                      }
                    },
                    value: _checkBoxVal,
                  ),
                  Checkbox(
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() => _checkBoxVal = value);
                      }
                    },
                    value: _checkBoxVal,
                  ),
                  Checkbox(
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() => _checkBoxVal = value);
                      }
                    },
                    value: _checkBoxVal,
                  ),
                  Checkbox(
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() => _checkBoxVal = value);
                      }
                    },
                    value: _checkBoxVal,
                  ),
                  Checkbox(
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() => _checkBoxVal = value);
                      }
                    },
                    value: _checkBoxVal,
                  ),
                  Checkbox(
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() => _checkBoxVal = value);
                      }
                    },
                    value: _checkBoxVal,
                  ),
                  Checkbox(
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() => _checkBoxVal = value);
                      }
                    },
                    value: _checkBoxVal,
                  )
                ])
          ]),
    );
  }
}

void setState(bool Function() param0) {}
