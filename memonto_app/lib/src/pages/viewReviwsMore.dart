import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ViewReviews extends StatefulWidget {
  @override
  _ViewReviewsState createState() => _ViewReviewsState();
  final Map data;
  ViewReviews({Key key, @required this.data,}) : super(key: key);
}

class _ViewReviewsState extends State<ViewReviews> {
  String _token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVlNjJhZGEzMTI5Zjc4MDAzYjVmZmFlMiIsImlhdCI6MTU4MzUyNTI4MywiZXhwIjoxNTkyMTY1MjgzfQ.AX4_2M39c2uZJYyZxgAwv6D8HDsHpZ3OJZJ3CS40j1E';
  String _plate = '';
  String _ratingMedian = '';
  String _vehicleId = '';
  String _userId = '';
  Map _dataVehicle;
  Map _dataRating;
  List _dataReviews;
  String _model = '';
  String _ano = '';
  String _make = '';
  List _reviews = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultar'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.all(20),
            child: Text(
            _plate, 
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
              )
            ,),
          ),
          Center (
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                    width: 190.0,
                    height: 190.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                "https://i.imgur.com/BoN9kdC.png")
                        )
                    )),
                  Text(
                    "Carl J",
                    textScaleFactor: 1.5,
                    style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                    )
                  )
              ],    
            )
          ),
          Center (
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin:EdgeInsets.all(15),
                  child: Text(_make,
                  style: TextStyle(
                  fontSize: 20
                )
              ),
                ),
                Container(
                  margin:EdgeInsets.all(15),
                  child: Text(_model,
                  style: TextStyle(
                  fontSize: 20
                )
              ),
                ),
              ],
            ),
          ),
          Center (
            child: Column(
              children: <Widget>[
                Text(_ratingMedian,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  )
                ),
                Text('Rating'),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            height: 250,
             child: _crearLista(),
          )
        ],
      )
        );
  }


  Future fetchData () async {

  _userId =  widget.data['userId'];
  _vehicleId = widget.data['vehicleId'];
  _plate = widget.data['plate'];

  http.Response getReviews =  await http.get('http://3.135.230.1/api/v1/review/all/vehicle/$_vehicleId', headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token',
      });
      if (getReviews.statusCode == 200) {
        _dataReviews = json.decode(getReviews.body);
        for (var review in _dataReviews) {
          _reviews.add(review['text']);
        }
    }
        setState(() {
    });
    
  http.Response getVehicle =  await http.get('http://3.135.230.1/api/v1/vehicle/plate/$_plate', headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    });
    if (getVehicle.statusCode == 200) {
      _dataVehicle = json.decode(getVehicle.body);
      _ano = _dataVehicle['year'];
      _make = _dataVehicle['make'];
      _model = _dataVehicle['model'];
    setState(() {
    });
    }
    http.Response getMedianRating =  await http.get('http://3.135.230.1/api/v1/rating/vehicle/average/$_vehicleId', headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token',
      });
    if (getMedianRating.statusCode == 200) {
        _dataRating = json.decode(getMedianRating.body);
        _ratingMedian = _dataRating['Average'].toString();
         setState(() {
    });
    }
  }
  

  Widget _crearLista() {
    return ListView.builder(
      itemCount: _reviews.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            ListTile(
              title: Text(_reviews[index]),
              leading: Icon(Icons.verified_user),
            ),
            Divider()
          ], 
        );
      }
    );
  }
}