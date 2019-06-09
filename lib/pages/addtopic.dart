import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
import '../data/userlogin.dart';

class AddTopicPage extends StatefulWidget {
  _AddTopicPageState createState() => _AddTopicPageState();
}

class _AddTopicPageState extends State<AddTopicPage> {
  TextStyle TheStyle = TextStyle(
      color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.w500);
  var addTitleController = new TextEditingController();
  var contentController = new TextEditingController();

  getTokenData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String getToken(String key) => prefs.getString(key);
    String token = getToken("token");
    //v print(token);
    return token;
  }

  getLocalUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String getIt(String key) => prefs.getString(key);
    String theUsername = getIt("username");
    String thePassword = getIt("password");
    String token = getIt("token");
    // print(token);
    return token;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("添加 idea"),
      ),
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.96),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 25,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: TextField(
              controller: addTitleController,
              keyboardType: TextInputType.text,
              maxLines: 1,
              // 是否自动更正
              autocorrect: false,
              // 是否自动对焦
              autofocus: false,
              decoration: new InputDecoration(
                labelText: "标 题",
                labelStyle: TextStyle(
                    color: Colors.blueAccent,
                    textBaseline: TextBaseline.alphabetic),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                contentPadding: EdgeInsets.all(15.0),
                hintText: ' Ready to drive a car',
                hintStyle: TextStyle(
                  color: Colors.black26,
                  fontSize: 18,
                ),
              ),
              // 输入样式
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: TextField(
              controller: contentController,
              keyboardType: TextInputType.text,

              maxLines: 10,
              // 是否自动更正
              autocorrect: false,
              // 是否自动对焦
              autofocus: false,
              decoration: new InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                // alignLabelWithHint: false,
                // focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.all(15.0),
                labelText: "正 文",
                alignLabelWithHint: true,
                labelStyle: TextStyle(textBaseline: TextBaseline.alphabetic),
                hintText: ' I have a dream, but ...',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black26,
                ),
              ),
              // 输入样式
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
            margin: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            //类似cardview
            child: new Card(
              color: Colors.blueAccent,
              // 阴影
              elevation: 3.0,
              //按钮
              child: new FlatButton(
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                onPressed: () {
                  if (addTitleController.text.isEmpty) {
                    //第三方的插件Toast，https://pub.dartlang.org/packages/fluttertoast
                    Fluttertoast.showToast(
                      msg: "标题不能为空哦",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIos: 2,
                      backgroundColor: Colors.white70,
                      textColor: Colors.grey[800],
                    );
                  } else {
                    var newTitle = addTitleController.text;
                    var newContent = contentController.text;
                    String labelsId = "4";
                    pubTopic(newTitle, newContent, labelsId).then(
                      (res) {
                        if (res == 200) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => new MyHomePage()));
                        } else {
                          Fluttertoast.showToast(
                            msg: "$res",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.white70,
                            fontSize: 16.0,
                            textColor: Colors.black,
                          );
                          Navigator.popAndPushNamed(context, "/");
                          // print(data);
                          // return showDialog(
                          //   context: context,
                          //   builder: (_) {
                          //     return AlertDialog(
                          //       title: Text("喵喵喵 身份错误"),
                          //       content: Text("用户名也可以是当年注册us的邮箱，\n试试看？"),
                          //       actions: <Widget>[
                          //         FlatButton(
                          //             onPressed: () {
                          //               Navigator.of(context).pop();
                          //             },
                          //             child: Text("确定")),
                          //       ],
                          //     );
                          //   },
                          // );
                        }
                      },
                    );
                  }
                },
                child: new Padding(
                  padding: new EdgeInsets.all(10.0),
                  child: new Text(
                    '发布 Idea',
                    style: new TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Dio dio = new Dio();

// login
Future pubTopic(newTitle, newContent, labelsId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String getToken(String key) => prefs.getString(key);
  String token = getToken("token");
  Options options =
      Options(headers: {"authorization": token}, connectTimeout: 3500);
  try {
    Response response = await dio.post(
      'https://star.exql.top/api/idea/crud',
      data: {
        "title": "$newTitle",
        "content": "${newContent.replaceAll('\n', '<br>')}",
        "labels": ["$labelsId"],
        "is_publish": false,
      },
      options: options,
    );
    print(response.data);
    // print(response.headers);
    // print(response.statusCode);

    // UserData userDatas = UserData.fromJson(response.data);
    int b = response.statusCode;
    // prefs.remove("topicTitle");
    return b;
  } on DioError catch (e) {
    print(e);
    if (e.type == DioErrorType.RESPONSE) {
      print(e.response.statusCode); //403 权限不足（token过期）
      return e.response.statusCode;
    } else if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      return '连接超时 后端炸了';
    }
  } catch (e) {
    return e.toString();
  }
}
