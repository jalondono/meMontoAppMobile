import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class PlatePage extends StatefulWidget {

  const PlatePage({Key key}) : super(key: key);

  @override
  _PlatePageState createState() => _PlatePageState();
}

class _PlatePageState extends State<PlatePage> {
  String _plate = '';
  Map _data ;
  String _token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVlNjJhZGEzMTI5Zjc4MDAzYjVmZmFlMiIsImlhdCI6MTU4MzUyNTI4MywiZXhwIjoxNTkyMTY1MjgzfQ.AX4_2M39c2uZJYyZxgAwv6D8HDsHpZ3OJZJ3CS40j1E';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plate'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(100),
          child: Center(
            child: _createInput(context),
          ),
        ),
      )
    );
  }

 Widget _createInput(BuildContext context) {
   return TextField(
     textCapitalization: TextCapitalization.sentences,
     decoration: InputDecoration(
       border: OutlineInputBorder(
         borderRadius: BorderRadius.circular(20.0)
       ),
       hintText: 'Ingrese la placa',
       counter: Text('Letras ${_plate.length}'),
       labelText: 'Placa',
       suffixIcon: Icon(Icons.keyboard),
     ),
      textAlign: TextAlign.center,
      onChanged: (text) {
        _plate = text.toUpperCase();
        if (_plate.length > 5) {
          _validatePlate(context);
          
        }
        setState(() {     
        }); 
      },
   );
 }

 Future<List> _validatePlate(BuildContext context) async{
    http.Response response =  await http.get('http://3.135.230.1/api/v1/vehicle/plate/$_plate', headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    });
    _data = json.decode(response.body);
    print(response.body);
    setState(() {
      
    });
    Navigator.pushNamed(context, 'NewVehicleReview', arguments: _plate);
  }
}