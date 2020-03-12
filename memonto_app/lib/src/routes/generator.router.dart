import 'package:flutter/material.dart';
import 'package:memonto_app/src/pages/newVehicleReview.page.dart';
import 'package:memonto_app/src/pages/plate.page.dart';
import 'package:memonto_app/src/pages/viewReviwsMore.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch(settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => PlatePage());
      case 'NewVehicleReview':
        return MaterialPageRoute(
          builder: (_) => NewVehicleReview(data: args));
      case 'ViewReviews':
      return MaterialPageRoute(
        builder: (_) => ViewReviews(data: args)); 
      default:
        return MaterialPageRoute(
          builder: (_) => PlatePage()); 
    }
  }
}