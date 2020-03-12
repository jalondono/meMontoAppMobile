import 'package:flutter/material.dart';
class ViewReviews extends StatefulWidget {
  @override
  _ViewReviewsState createState() => _ViewReviewsState();
  final String data;
  ViewReviews({Key key, @required this.data,}) : super(key: key);
}

class _ViewReviewsState extends State<ViewReviews> {
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
              widget.data, 
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
                    "John Doe",
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
                  child: Text('Ano',
                  style: TextStyle(
                  fontSize: 20
                )
              ),
                ),
                Container(
                  margin:EdgeInsets.all(15),
                  child: Text('Modelo',
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
                Text('5 ⭐',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  )
                ),
                Text('Rating'),
                Container()
              ],
            ),
          ),
        ],
      )
        );
  }
}