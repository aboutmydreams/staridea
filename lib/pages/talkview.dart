import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:ui';
import 'dart:convert';
import '../data/topicdata.dart';
import '../main.dart';
import 'talkdetail.dart';

class ListViewDemo extends StatelessWidget {
  String token;
  @override
  Widget build(BuildContext context) {
    return Topiclist();
  }
}

class Topiclist extends StatefulWidget {
  @override
  createState() => new TopiclistState();
}

class TopiclistState extends State<Topiclist> {
  List<Data> theTopics;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    theTopics = List();
    fen();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final _floatingActionButton = FloatingActionButton(
      backgroundColor: Colors.blue,
      elevation: 3,
      tooltip: "New idea",
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.pushNamed(context, "/addtopic");
      },
    );
    // print(window.physicalSize.height / 30);
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          _buildtopics(),
          // 添加idea按钮
          Positioned(
            right: 20,
            bottom: window.physicalSize.height / 30, //108
            child: _floatingActionButton,
          )
        ],
      ),
    );
  }

  Widget _buildtopics() {
    print(_isLoading);
    return _isLoading
        ? Container(
            // margin: EdgeInsets.only(top: 16),
            child: GridView.builder(
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 3.05,
              ),
              itemCount: theTopics.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildColumn(theTopics[index]);
              },
            ),
          )
        : Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
              backgroundColor: Colors.blue[100],
            ),
          );
  }

  Widget _buildColumn(Data idea) {
    Color _cardColor = Colors.white;
    int _num = 1;
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return DetailShow(topic: idea);
            }));
          },
          onDoubleTap: () {
            setState(() {
              _cardColor = _num % 2 == 0 ? Colors.yellow : Colors.white;
              _num = _num + 1;
              print(_num);
            });

            Fluttertoast.showToast(
              msg: "star shine",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 2,
              backgroundColor: Colors.yellow,
              textColor: Colors.grey[800],
            );
          },
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 15, right: 15),
            padding: EdgeInsets.only(left: 20, top: 15, right: 15, bottom: 15),
            height: 100,
            decoration: BoxDecoration(
              color: _cardColor,
              borderRadius: new BorderRadius.all(
                const Radius.circular(8.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  offset: new Offset(0.0, 3.0),
                  blurRadius: 6.0,
                  color: const Color(0x80000000),
                ),
              ],
            ),
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${clearText(idea.title, 20)}",
                  maxLines: 1,
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.90),
                    // fontFamily: "PingFang",
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    letterSpacing: 1.5,
                  ),
                ),
                Container(
                  height: 8,
                ),
                idea.content == ""
                    ? SizedBox(height: 0.1)
                    : Text(
                        "${clearText(idea.content, 22).trim()}",
                        maxLines: 4,
                        style: TextStyle(
                            color: Color.fromRGBO(155, 155, 155, 1),
                            fontFamily: "Pingfang",
                            fontSize: 15,
                            height: 1.2),
                      ),
              ],
            ),
          ),
        ),
        SizedBox(height: 5),
      ],
    );
  }

  getMyIdeaData() async {
    Dio dio = new Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String getToken(String key) => prefs.getString(key);
    String token = getToken("token");
    // print(token);
    Options options = Options(headers: {"authorization": token});

    try {
      Response response = await dio.get(
        'https://star.exql.top/api/idea/crud',
        options: options,
      );

      // print(response.data.runtimeType);
      // print(response.headers);
      // print(response.statusCode);
      MyIdeaData myIdeaData = MyIdeaData.fromJson(response.data);
      setState(() {
        theTopics = myIdeaData.data;
        _isLoading = true;
      });
      return myIdeaData;
    } catch (e) {
      MyIdeaData myIdeaData;
      return myIdeaData;
    }
  }

  fen() {
    getMyIdeaData();
  }
}

Future getaToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String getToken(String key) => prefs.getString(key);
  String token = getToken("token");
  return token;
}

String clearText(String text, int maxn) {
  RegExp exp = new RegExp(r'<[^>]+>');
  String retext = text
      .replaceAll(exp, "")
      .replaceAll("\n\n", "")
      .replaceAll("&nbsp", "")
      .replaceAll("</", "");
  //.replaceFirst("\n", "", text.length ~/ 2)

  if (retext.length > maxn) {
    // retext = retext.substring(0, maxn) + "..";
    retext = retext.substring(0, maxn - 2) + "..";
  }
  return retext;
}
