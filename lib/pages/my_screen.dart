import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:ui';
import 'package:dio/dio.dart';
import '../data/MyData.dart';

class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyDatalist();
  }
}

class MyDatalist extends StatefulWidget {
  @override
  createState() => new MyDatalistState();
}

class MyDatalistState extends State<MyDatalist> {
  Data myDatas;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      backgroundColor: Color.fromRGBO(240, 240, 240, 10),
      body: SizedBox(
        // height: 220,
        child: new Center(
          child: _isLoading
              ? Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.fromLTRB(0, 50, 0, 20),
                        margin: EdgeInsets.all(0),
                        alignment: Alignment.bottomCenter,
                        height: 230,
                        width: 430,
                        color: Colors.blue,
                        child: Column(
                          children: <Widget>[
                            ClipOval(
                              child: Image.network(
                                'https://cdn.nlark.com/yuque/0/2018/png/164272/1540470801359-2440731a-e0c0-4608-8dfc-c48bb2bc8cea.png?x-oss-process=image/resize,m_fill,w_192,h_192/format,png',
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              alignment: Alignment.topCenter,
                              child: FlatButton(
                                child: Text(
                                  "${myDatas.username}",
                                  //"123",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        )),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              'ideas   ${myDatas.idea}',
                              textAlign: TextAlign.left,
                            ),
                            leading: Icon(Icons.lightbulb_outline,
                                color: Colors.black26, size: 22.0),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () => Navigator.pushNamed(context, "/"),
                          ),
                          Divider(
                            height: 1,
                          ),
                          ListTile(
                            title: Text(
                              'stars   ${myDatas.star}',
                              textAlign: TextAlign.left,
                            ),
                            leading: Icon(Icons.whatshot,
                                color: Colors.black26, size: 22.0),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () =>
                                Navigator.pushNamed(context, "/collection"),
                          ),
                          Divider(
                            height: 1,
                          ),
                          ListTile(
                            title: Text(
                              '关注了  ${myDatas.followed}',
                              textAlign: TextAlign.left,
                            ),
                            leading: Icon(Icons.camera,
                                color: Colors.black26, size: 22.0),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () =>
                                Navigator.pushNamed(context, "/following"),
                          ),
                          Divider(
                            height: 1,
                          ),
                          ListTile(
                            title: Text(
                              '关注者 ${myDatas.follower}',
                              textAlign: TextAlign.left,
                            ),
                            leading: Icon(Icons.laptop_chromebook,
                                color: Colors.black26, size: 22.0),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () =>
                                Navigator.pushNamed(context, "/follower"),
                          ),
                          Divider(
                            height: 1,
                          ),
                          ListTile(
                            title: Text(
                              '设置',
                              textAlign: TextAlign.left,
                            ),
                            leading: Icon(Icons.settings,
                                color: Colors.black26, size: 22.0),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () =>
                                Navigator.pushNamed(context, "/setting"),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
                    backgroundColor: Colors.blue[100],
                  ),
                ),
        ),
      ),
    );
  }

  getMyselfData() async {
    Dio dio = new Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String getToken(String key) => prefs.getString(key);
    String token = getToken("token");
    Options options = Options(headers: {"authorization": token});

    try {
      Response response = await dio.get(
        'https://star.exql.top/api/user/home',
        options: options,
      );

      // print(response.headers);
      // print(response.statusCode);

      MyselfData myselfData = MyselfData.fromJson(response.data);

      setState(() {
        myDatas = myselfData.data;
        _isLoading = true;
      });

      return myselfData;
    } catch (e) {
      MyselfData myselfData;
      return myselfData;
    }
  }

  fen() {
    getMyselfData();
  }
}

// Material(
//       borderRadius: BorderRadius.circular(20.0),
//       shadowColor: Colors.blue.shade200,
//       elevation: 0.0,
//       child: new MaterialButton(
//       onPressed: (){},
//       minWidth: 750.0,
//       height: 250.0,
//       color: Colors.blue,
//       child:Text('Buy Now'),

//       ),
//     );
