import 'package:flutter/material.dart';
import 'package:memonto_app/src/pages/newVehicleReview.page.dart';
import 'package:memonto_app/src/pages/plate.page.dart';
import 'package:memonto_app/src/pages/viewReviwsMore.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder> {
    '/': (BuildContext context) => PlatePage(),
    'NewVehicleReview': (BuildContext context) => NewVehicleReview(),
    'ViewReviews': (BuildContext context) => ViewReviews(data: "Jueputaaa",),
  };
}