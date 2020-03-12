import 'package:flutter/material.dart';
import 'package:memonto_app/src/pages/plate.page.dart';
import 'package:memonto_app/src/routes/generator.router.dart';
import 'package:memonto_app/src/routes/router.dart';


void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: '/',
      onGenerateRoute: RouterGenerator.generateRoute,
    );
  }
}