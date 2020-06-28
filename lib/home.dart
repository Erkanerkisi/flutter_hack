import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hack/match_generator.dart';
import 'package:flutter_hack/custom_option.dart';
import 'package:flutter_hack/success_page.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'error_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _offsetAdjustmentx = 60;
  int _offsetAdjustmenty = 25;
  int counter = 0;
  Match match;
  MatchGenerator _matchGenerator;
  bool _visibleSuccessPage = false;
  bool _visibleErrorPage = false;

  @override
  void initState() {
    _matchGenerator = MatchGenerator();
    setState(() {
      match = _matchGenerator.getRandomMatch();
    });
  }

  Future<AudioPlayer> playSuccessAnswer() async {
    AudioCache cache = new AudioCache();
    return await cache.play("audio/correct_answer.mp3");
  }

  Future<AudioPlayer> playWrongAnswer() async {
    AudioCache cache = new AudioCache();
    return await cache.play("audio/wrong_answer.mp3");
  }

  checkDragIsSuccess(var dragDetails, BuildContext currentContext) {
    bool isCorrectAnswer = false;

    for (CustomOption cs in match.options) {
      RenderBox box = cs.keyVal.currentContext.findRenderObject();
      Offset position = box.localToGlobal(Offset.zero);
      if (cs.isRight &&
          position.dx - _offsetAdjustmentx < dragDetails.offset.dx &&
          position.dx > dragDetails.offset.dx &&
          position.dy - _offsetAdjustmenty < dragDetails.offset.dy &&
          position.dy + _offsetAdjustmenty > dragDetails.offset.dy) {
        setState(() {
          match = _matchGenerator.getRandomMatch();
          counter++;
          _visibleSuccessPage = true;
          playSuccessAnswer();
        });
        isCorrectAnswer = true;
      }
    }
    if (!isCorrectAnswer) {
      setState(() {
        _visibleErrorPage = true;
        playWrongAnswer();
      });
    }
  }

  resetMatch() {
    setState(() {
      match = _matchGenerator.getRandomMatch();
    });
  }

  List<Widget> getOptions() {
    return match.options;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("PandemicKillers")),
        backgroundColor: Colors.teal,
        elevation: 10,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 150, vertical: 180),
            child: Text(
              counter.toString(),
              style: TextStyle(fontSize: 200,color: Colors.deepPurple,),
            ),
          ),
          Opacity(
            opacity: 0.85,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bgw.jpeg"),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          AnimatedOpacity(
            child: ErrorPage(),
            opacity: _visibleErrorPage ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            onEnd: () {
              setState(() {
                _visibleErrorPage = false;
              });
            },
          ),
          AnimatedOpacity(
            child: SuccessPage(),
            opacity: _visibleSuccessPage ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            onEnd: () {
              setState(() {
                _visibleSuccessPage = false;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Draggable(
                    child: Container(
                      margin: EdgeInsets.only(left: 30.0),
                      child: match.matchImage,
                    ),
                    feedback: Container(
                      margin: EdgeInsets.only(left: 30.0),
                      child: match.matchImage,
                    ),
                    onDragCompleted: () {
                      print("Drag comp");
                    },
                    onDragEnd: (dragDetails) {
                      checkDragIsSuccess(dragDetails, context);
                    },
                    childWhenDragging: Container(),
                  ),
                ],
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: getOptions())
            ],
          )
        ],
      ),
    );
  }
}
