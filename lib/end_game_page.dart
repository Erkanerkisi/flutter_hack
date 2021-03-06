import 'package:flutter/material.dart';

import 'home.dart';
import 'info_page.dart';
import 'ads-helper.dart';

class EndGamePage extends StatefulWidget {
  EndGamePage({this.score});

  final int score;

  @override
  _EndGamePageState createState() => _EndGamePageState();
}

class _EndGamePageState extends State<EndGamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff21315a),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/aglayan_dunya.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                "Your score is ${widget.score}",
                style: TextStyle(fontSize: 20, color: Colors.white),
              )),
          SizedBox(
            height: 50,
          ),
          Center(
            child: ButtonTheme(
              minWidth: 300.0,
              height: 50.0,
              child: RaisedButton(
                child: Text(
                  "Restart",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  ).then((value) => {AdsHelper.showBannerAd()});
                },
                color: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: ButtonTheme(
              minWidth: 300.0,
              height: 50.0,
              child: RaisedButton(
                child: Text(
                  "Guide",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InfoPage()),
                  ).then((value) => {AdsHelper.showBannerAd()});
                },
                color: Colors.pinkAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                    side: BorderSide(color: Colors.pinkAccent)),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    AdsHelper.showBannerAd();
    super.initState();
  }

  void dispose() {
    super.dispose();
  }
}
