import 'package:amb_digi_clock/colors_clock.dart';
import 'package:flutter/material.dart';

import 'number_painter.dart';


class NumberBuilder extends StatefulWidget {
  final AnimationController animationController;
  final int number;
  const NumberBuilder({Key key, this.animationController, this.number}) : super(key: key);
  @override
  NumberBuilderState createState() {
    return new NumberBuilderState();
  }
}

class NumberBuilderState extends State<NumberBuilder> with TickerProviderStateMixin<NumberBuilder> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
          aspectRatio: 5/3/2,
          child: AnimatedBuilder(
            animation: widget.animationController,
            builder: (context, child) {
              return CustomPaint(
                painter: NumberPainter(widget.animationController.value, widget.number ,ColorsClock.orange),
                size: Size.infinite,
              );
            },
          ), 
        );
  }
}

