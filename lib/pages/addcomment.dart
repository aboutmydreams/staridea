import 'dart:convert';
import '../data/topicdata.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:ui';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'talkdetail.dart';

class AddComment extends StatefulWidget {
  Data topic;
  AddComment({
    @required this.topic,
  });
  _AddCommentState createState() => _AddCommentState(topic: topic);
}

class _AddCommentState extends State<AddComment> {
  Data topic;
  _AddCommentState({
    @required this.topic,
  });
  @override
  Widget build(BuildContext context) {
    var commentSayController = new TextEditingController();

    getTokenData() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String getToken(String key) => prefs.getString(key);
      String token = getToken("token");
      return token;
    }

    Dio dio = new Dio();
    publishTopic(commentSay, topicid) async {
      String token = await getTokenData();
      Options options = Options(headers: {"authorization": token});
      try {
        Response response = await dio.post(
          'https://us.ncuhomer.cn/api/topic/comment',
          data: {"content": "$commentSay", "topic_id": "${topic.content}"},
          options: options,
        );
        if (response.statusCode == 200) {
          return "发布成功";
        } else {
          return "发布失败，可能是接口变更";
        }
      } on DioError catch (e) {
        if (e.response.statusCode == 403) {
          return "身份过期或US后端炸了qaq";
        } else {
          return "bug 截图联系管理员" + e.response.statusCode.toString();
        }
      } catch (e) {
        return "bug 截图联系管理员：$e";
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("添加评论"),
      ),
      body: Center(
        child: new Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: TextField(
                controller: commentSayController,
                keyboardType: TextInputType.text,
                // maxLength: 20,
                maxLines: 4,
                // 是否自动更正
                autocorrect: false,
                // 是否自动对焦
                autofocus: false,
                obscureText: false,
                decoration: new InputDecoration(
                  suffixStyle: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w300,
                    color: Colors.blueGrey[300],
                  ),
                  labelText: "评论",
                  // labelStyle: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600,color: Colors.blueGrey[300]),
                  icon: new Icon(
                    Icons.add_comment,
                    color: Colors.lightBlueAccent[200],
                  ),
                ),
                onChanged: (text) {
                  //内容改变的回调
                  print('change $text');
                },
                onSubmitted: (text) {
                  //内容提交(按回车)的回调
                  print('submit $text');
                },
              ),
            ),
            Container(
              // 这里写800已经超出屏幕了，可以理解为match_parent
              // width: 800.0,
              // margin: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              // padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              //类似cardview
              child: new Card(
                color: Colors.blueAccent,
                elevation: 3.0,
                child: new FlatButton(
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  onPressed: () {
                    if (commentSayController.text.isEmpty) {
                      //第三方的插件Toast，https://pub.dartlang.org/packages/fluttertoast
                      Fluttertoast.showToast(
                        msg: "标题不能为空",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos: 2,
                        backgroundColor: Colors.white70,
                        textColor: Colors.grey[800],
                      );
                    } else {
                      var commentSay = commentSayController.text;
                      String data = "";
                      publishTopic(commentSay, topic.toString()).then(
                        (res) {
                          try {
                            print(res);
                            data = res;
                          } catch (e) {
                            data = "publishTopic wrong 截图联系研发" + e.toString();
                          }
                          if (data == "发布成功") {
                            Navigator.pop(context, topic);
                            Fluttertoast.showToast(
                              msg: "发布成功",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIos: 2,
                              backgroundColor: Colors.grey[300],
                              fontSize: 16.0,
                              textColor: Colors.black,
                            );
                          } else {
                            // print(data);
                            Fluttertoast.showToast(
                              msg: data,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIos: 2,
                              backgroundColor: Colors.grey[300],
                              fontSize: 16.0,
                              textColor: Colors.black,
                            );
                            Navigator.pop(context, topic);
                          }
                        },
                      );
                    }
                  },
                  child: new Padding(
                    padding: new EdgeInsets.all(10.0),
                    child: new Text(
                      '发布',
                      style: new TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
