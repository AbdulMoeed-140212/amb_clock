import 'package:amb_digi_clock/amb_clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter_clock_helper/customizer.dart';


void main() {
  runApp(
    ClockCustomizer(
      (ClockModel model) => AmbClock(model: model)
    )
  );
}

