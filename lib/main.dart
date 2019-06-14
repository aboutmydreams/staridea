import 'dart:convert';
import 'package:doorapp/pages/someweb.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './pages/loginus.dart';
import './pages/setting.dart';
import './data/userlogin.dart';
import './pages/my_screen.dart';

import './pages/talkview.dart';
import './pages/someweb.dart';
import './pages/aboutwork.dart';
import './pages/talkdetail.dart';
import './pages/addtopic.dart';
import './pages/addcomment.dart';
import './pages/birthview.dart';
import './pages/firstpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'US',
      initialRoute: '/first',
      routes: {
        '/': (context) => MyHomePage(),
        '/first': (context) => FirstPage(),
        '/my': (context) => MyScreen(),
        '/login': (context) => LoginPage(),
        '/setting': (context) => SettingPage(),
        '/aboutwork': (context) => AboutWorkPage(),
        '/addtopic': (context) => AddTopicPage(),
        '/addcomment': (context) => AddComment(),
        '/collection': (context) =>
            WebWithToken("stars", "https://idea.exql.top/collection"),
        '/following': (context) =>
            WebWithToken("我关注了", "https://idea.exql.top/following/"),
        '/follower': (context) =>
            WebWithToken("关注者", "https://idea.exql.top/follower/"),
        '/register': (context) =>
            WebWithToken("注册", "https://idea.exql.top/register/"),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        highlightColor: Color.fromRGBO(255, 255, 255, 0.2),
        splashColor: Colors.white30,
        // accentColor: Color.fromRGBO(5, 254, 255, 1.0),
      ),
      // home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return theController(context);
  }
}

DefaultTabController theController(context) => DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          // toolbarOpacity: 1.0,
          // bottomOpacity: 5.0,
          // title: Text(
          //   'US',
          //   style: TextStyle(
          //       color: Colors.white, fontSize: 19.0, fontWeight: FontWeight.w500),
          // ),

          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(Icons.search),
          //     tooltip: 'Search',
          //     onPressed: () => debugPrint('Search button is pressed.'),
          //   )
          // ],

          elevation: 0.0,
          leading: GestureDetector(
            child: Container(
              height: 40,
              margin: EdgeInsets.all(7),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://exqlnet-note.oss-cn-shenzhen.aliyuncs.com/star/2.png"),
                radius: 18.0,
              ),
            ),
            onTap: () => Navigator.pushNamed(context, "/my"),
          ),
          title: TabBar(
            // isScrollable: true,
            unselectedLabelColor: Colors.white70,
            labelColor: Colors.yellow,
            indicatorColor: Colors.yellow,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3.0,
            tabs: <Widget>[
              Tab(
                // icon: Icon(Icons.local_florist),
                text: "星星✨",
              ),
              Tab(
                // icon: Icon(Icons.change_history),
                text: "夜空",
              ),
            ],
          ),
        ),
        // drawer: DrawerDemo(),
        // endDrawer: DrawerDemo(),

        body: TabBarView(
          children: <Widget>[
            Container(
              height: 6000,
              child: ListViewDemo(),
            ),
            Container(
              child: TimeLinePage(),
            ),
          ],
        ),

        // bottomNavigationBar: BottomNavigationBarDemo(),
      ),
    );
