import 'package:flutter/material.dart';
class NewVehicleReview extends StatefulWidget {
  @override
  _NewVehicleReviewState createState() => _NewVehicleReviewState();
   final String data;
    NewVehicleReview({Key key, @required this.data,}) : super(key: key);
}

class _NewVehicleReviewState extends State<NewVehicleReview> {
  String _plate;
  double _rating = 0.0;
  String _review = '';
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
              widget.data, 
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
                            Navigator.pushNamed(context, 'ViewReviews', arguments: widget.data);
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
                    ),
                  ),
                ),
              ),
            ),
          );
 }

  //_sendReview(BuildContext context) {
  //  Navigator.pushNamed(context, 'ViewReviews');
  //  setState(() {
      
  //  });
  //}
}