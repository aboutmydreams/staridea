import 'dart:math' as prefix0;

import 'package:flutter/cupertino.dart' as prefix1;
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:share/share.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:ui';
import '../data/topicdata.dart';
// import '../data/detaildata.dart';
import 'addcomment.dart';

class DetailShow extends StatelessWidget {
  final Data topic;
  final MethodChannel _channel = const MethodChannel('flutter_share_me');

  DetailShow({
    @required this.topic,
  });
  Future<String> shareToSystem({String msg}) async {
    Map<String, Object> arguments = Map<String, dynamic>();
    arguments.putIfAbsent('msg', () => msg);
    dynamic result;
    try {
      result = await _channel.invokeMethod('system', {'msg': msg});
    } catch (e) {
      return "false";
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    // 自定义添加评论组件样式
    final _floatingActionButton = FloatingActionButton.extended(
      backgroundColor: Colors.blue,
      elevation: 3,
      tooltip: "New topic",
      icon: Icon(Icons.add_comment),
      label: Text("添加评论"),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return AddComment(topic: topic);
        }));
      },
    );

    // 清除html的正则
    RegExp exp = new RegExp(r'<[^>]+>');
    String _clear(String text) => text.replaceAll(exp, "");

    // 自定义组件样式
    PopupMenuItem<String> childItem(String id, String title, IconData icon) {
      return PopupMenuItem(
        value: id,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.black54,
            ),
            Text('    $title'),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('话题详情'),
        actions: <Widget>[
          new PopupMenuButton(
            // padding: EdgeInsets.only(bottom: 15),
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                  childItem("A", "编辑话题", Icons.edit),
                  childItem("B", "删除话题", Icons.delete),
                  childItem("C", "分享", Icons.share),
                ],
            onSelected: (String action) {
              // 点击选项的时候
              switch (action) {
                case 'A':
                  break;
                case 'B':
                  break;
                case 'C':
                  Share.share(
                      '我在「星星」上讨论「${topic.title}」快来瞧瞧！ https://us.ncuhomer.cn');
                  break;
              }
            },
          ),
        ],
        elevation: 0.0,
      ),
      body: Stack(
        children: <Widget>[
          Detail(topic: topic),
          Positioned(
            right: 20,
            bottom: window.physicalSize.height / 30,
            child: _floatingActionButton,
          )
        ],
      ),
    );
  }
}

class Detail extends StatefulWidget {
  final Data topic;
  Detail({
    @required this.topic,
  });
  @override
  createState() => new DetailState(topic: topic);
}

class DetailState extends State<Detail> {
  ScrollController _controller;
  List _commentsList;
  final Data topic;
  bool _isLoading = false;

  DetailState({
    @required this.topic,
  });

  @override
  void initState() {
    super.initState();
    _commentsList = List();
    _controller = ScrollController();
    _isLoading = true;
    //getTopicDetail(123);
    // print(topic.topicId);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  topic.title,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(12),
                child: Text(
                  topic.content,
                  style: TextStyle(fontSize: 20),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
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
              ),
            ],
          ),
        )
        // body: _buildtopics(topic),
        );
  }

  Widget _buildtopics(Data topic) {
    print(topic.ideaId);
    return Align(
      child: RefreshIndicator(
        onRefresh: () async {
          await new Future.delayed(const Duration(seconds: 1));
          _commentsList.clear();
        },
        child: _isLoading
            ? Container(
                child: ListView.builder(
                  controller: _controller,
                  itemCount: _commentsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildColumn(_commentsList[index]);
                  },
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
                  backgroundColor: Colors.blue[100],
                ),
              ),
      ),
    );
  }

  Widget _buildColumn(topic) {
    String _clearText(String text) {
      String retext;
      text = text[0] == ":" ? text.substring(1, text.length) : text;
      RegExp exp = new RegExp(r'<[^>]+>');
      retext = text
          .replaceAll(exp, "")
          .replaceAll("\n\n", "")
          .replaceAll("&nbsp", "")
          .replaceAll("</", "");
      return retext;
    }

    // print(topic);
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Container(
                //   padding: EdgeInsets.all(10),
                //   child: CircleAvatar(
                //     backgroundImage: NetworkImage(
                //       topic.user.username,
                //     ),
                //     radius: 16.0,
                //   ),
                // ),
                Text(
                  '${topic.isFinish}',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            )
          ],
        ),
        Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Text(
                  '${_clearText(topic.content)}',
                  style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 1.7,
                    color: Color.fromRGBO(0, 0, 0, 0.75),
                  ),
                ),
              ),
              SizedBox(height: 32.0),
              //Text('${topic.brief}', style: Theme.of(context).textTheme.body1),
            ],
          ),
        ),
      ],
    );
  }

  _deleteTopic() async {
    String _url = "https://us.ncuhomer.cn/api/topic/love";
  }
}
