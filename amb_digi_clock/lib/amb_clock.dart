import 'package:flutter/material.dart';
import 'colors_clock.dart';
import 'number_builder.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import 'package:amb_digi_clock/colors_clock.dart';
import 'package:amb_digi_clock/number_builder.dart';
import 'package:amb_digi_clock/separater_painter.dart';
class AmbClock extends StatefulWidget {
  final ClockModel model;
  AmbClock({Key key, this.model}) : super(key: key);

  @override
  _AmbClockState createState() => _AmbClockState();
}

class _AmbClockState extends State<AmbClock>
    with TickerProviderStateMixin<AmbClock> {
  AnimationController cMin, cHour, cSeparater;
  
  DateTime _dateTime = DateTime.now();
  Timer _timer, _timerHour;
  @override
  void initState() {
    cMin = AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    cHour = AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    cSeparater = AnimationController(vsync: this, duration: Duration(seconds: 1),);
    cMin.value = 1;
    cHour.value = 1;
    cSeparater.repeat(min: 0 , max: 1, reverse:  true);
    super.initState();

    widget.model.addListener(_updateModel);
    _updateTime();
    _updateTimeHour();
    _updateModel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timerHour?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    cMin.dispose();
    cHour.dispose();
    cSeparater.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
    });
  }

  void _updateTime() {
    cMin.forward().whenComplete(() => cMin.reverse());
    setState(() {
      _dateTime = DateTime.now();
      _timer = Timer(
        Duration(minutes: 1) -
            Duration(seconds: _dateTime.second) -
            Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
    });
  }

  void _updateTimeHour() {
    cHour.forward().whenComplete(() => cHour.reverse());
    setState(() {
      _dateTime = DateTime.now();
      _timerHour = Timer(
        Duration(hours: 1) -
            Duration(minutes: _dateTime.minute) -
            Duration(seconds: _dateTime.second) -
            Duration(milliseconds: _dateTime.millisecond),
        _updateTimeHour,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final hour = DateFormat(
        widget.model.is24HourFormat ? 'HH' : 'hh'
      )
      .format(_dateTime);
    final minute = DateFormat('mm').format(_dateTime);
    final amPm = DateFormat('a').format(_dateTime);
    return Scaffold(
      backgroundColor: ColorsClock.blue,
      body: Center(
        child: AspectRatio(
            aspectRatio: 5 / 3,
            child: Stack(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    NumberBuilder(
                      number: int.parse(hour),
                      animationController: cHour,
                    ),
                    NumberBuilder(
                      number: int.parse(minute),
                      animationController: cMin,
                    )
                  ],
                ),
                widget.model.is24HourFormat? Container() : buildAmPM(amPm, context),
                
                buildSeparator(),
              ],
            )),
      ),
    );
  }

  Align buildSeparator() {
    return Align(
                alignment: Alignment.center,
                child: Container(
                  child: AnimatedBuilder(
                    animation: cSeparater,
                    builder: (BuildContext context,  Widget child) {
                      return CustomPaint(
                        painter: SeparaterPainter(cSeparater.value),
                        size: Size.infinite,
                      );
                    },
                  )
                ),
              );
  }

  Align buildAmPM(String amPm, BuildContext context) {
    return Align(
                alignment: Alignment.bottomRight,
                child: Container(
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.04),
                        child: Text(
                          amPm,
                          style: TextStyle(
                              color: ColorsClock.orange,
                              fontWeight: FontWeight.bold,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .display1
                                  .fontSize),
                        ),
                      ),
              );
  }
}
