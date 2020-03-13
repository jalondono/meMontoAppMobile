import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class NewVehicleReview extends StatefulWidget {
  @override
  _NewVehicleReviewState createState() => _NewVehicleReviewState();
   final Map data;
    NewVehicleReview({Key key, @required this.data,}) : super(key: key);
}

class _NewVehicleReviewState extends State<NewVehicleReview> {
  String _token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVlNjJhZGEzMTI5Zjc4MDAzYjVmZmFlMiIsImlhdCI6MTU4MzUyNTI4MywiZXhwIjoxNTkyMTY1MjgzfQ.AX4_2M39c2uZJYyZxgAwv6D8HDsHpZ3OJZJ3CS40j1E';
  String _plate = '';
  double _rating = 0.0;
  String _review = '';
  String _vehicleId = '';
  String _userId = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Review'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.all(20),
            child: Text(
              widget.data['plate'], 
              style: TextStyle(
                fontSize: 25
              )
            ,),
          ),
          Center(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20),
                  child: _ratingSlide()
                  ),
                  _createReview(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 10, top: 40),
                        child: FloatingActionButton(
                          child: Icon(Icons.send),
                          onPressed: () {
                            _sendReview(context);
                          }
                        ),
                      )
                      
                    ],
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

 Widget _ratingSlide() {
   return Slider(
     min: 0,
     max: 5,
     value: _rating,
     divisions: 5,
     onChanged: (value) {     
       setState(() {
         _rating = value;
       });
     },
   );
 }

 Widget _createReview() {
   return Container(
            height: 400,
            margin: EdgeInsets.all(30),
            color: Color(0xffeeeeee),
            padding: EdgeInsets.all(10.0),
            child: new ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight:400.0,
              ),
              child: new Scrollbar(
                child: new SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  reverse: true,
                  child: SizedBox(
                    height: 400.0,
                    child: new TextField(
                      maxLines: 300,
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Escribe tu historia ...',
                      ),
                      onChanged: (value) {
                        _review = value;
                        setState(() {
                          
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
 }

Future<List> _sendReview(BuildContext context) async {
  _userId =  widget.data['userId'];
  _vehicleId = widget.data['vehicleId'];
  _plate = widget.data['plate'];
  setState(() {
  });
  if (_review.length > 10){

    if(_vehicleId == '') {
      //create vehicle if not exist
      http.Response createdVehicle =  await http.post('http://3.135.230.1/api/v1/vehicle/', headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token',
      }, body: jsonEncode({
          'plate': _plate,
          'model': '',
          'make': '',
          'year': ''}));
      if (createdVehicle.statusCode == 200) {
        _vehicleId = json.decode(createdVehicle.body)['_id'];
      setState(() { 
      });
      }
    }
    //Create Review
    http.Response createdReview =  await http.post('http://3.135.230.1/api/v1/review/vehicle', headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token',
        }, body: jsonEncode({
          'vehicleId': _vehicleId,
          'text':_review,
          'userId': _userId,
          }));
    //Create Rating
    http.Response createdRating =  await http.post('http://3.135.230.1/api/v1/rating', headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token',
        }, body: jsonEncode({
          'vehicleId': _vehicleId,
          'rating':_rating.toInt(),
          'userId': _userId}));
    setState(() {
      });
    Navigator.pushNamed(context, 'ViewReviews', arguments: {'plate': _plate, 'vehicleId': _vehicleId, 'userId':_userId});
  }
  }
}