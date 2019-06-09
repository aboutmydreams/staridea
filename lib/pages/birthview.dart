import 'dart:async';
import 'dart:ui';
import 'dart:math';
import 'dart:typed_data';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';

import 'talkdetail.dart';

import '../data/nightdata.dart';

class TimeLinePage extends StatelessWidget {
  String token;
  @override
  Widget build(BuildContext context) {
    return Skylist();
  }
}

class Skylist extends StatefulWidget {
  @override
  createState() => new SkylistState();
}

class SkylistState extends State<Skylist> {
  List<Data> theTopics;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    theTopics = List();
    fen();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
          Container(
            height: 10,
          ),
          _buildtopics(),
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
                childAspectRatio: 2.65,
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
    var cardColor = Colors.white;
    var rng = new Random();
    int a = rng.nextInt(3) + 1;
    String num = a.toString();
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              // return DetailShow(topic: idea);
            }));
          },
          onDoubleTap: () {
            Fluttertoast.showToast(
              msg: "star shine",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 2,
              backgroundColor: Colors.white70,
              textColor: Colors.grey[800],
            );
            setState(() {
              cardColor = Colors.yellow;
            });
          },
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 15, right: 15),
            padding: EdgeInsets.only(left: 20, top: 15, right: 15, bottom: 16),
            // height: 120,
            decoration: BoxDecoration(
              color: cardColor,
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
                Row(
                  children: <Widget>[
                    SizedBox(height: 15),
                    CircleAvatar(
                      radius: 15.0,
                      child: Image.network(
                          'https://exqlnet-note.oss-cn-shenzhen.aliyuncs.com/star/$num.png'),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        idea.user.username,
                        style: TextStyle(
                          color: Color.fromRGBO(155, 155, 155, 1),
                          fontFamily: "Pingfang",
                          fontSize: 15,
                          height: 1.2,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
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
                          height: 1.2,
                        ),
                      ),
              ],
            ),
          ),
        ),
        SizedBox(height: 5),
      ],
    );
  }

  getNightData() async {
    Dio dio = new Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String getToken(String key) => prefs.getString(key);
    String token = getToken("token");
    Options options = Options(headers: {"authorization": token});

    try {
      Response response = await dio.get(
        'https://star.exql.top/api/idea/square',
        options: options,
      );
      // print(response.data.runtimeType);
      // print(response.headers);
      // print(response.statusCode);
      NightData nightData = NightData.fromJson(response.data);
      setState(() {
        theTopics = nightData.data;
        _isLoading = true;
      });
      return NightData;
    } catch (e) {
      NightData nightData;
      return nightData;
    }
  }

  fen() {
    getNightData();
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
