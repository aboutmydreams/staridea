import '../main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'loginus.dart';

import 'dart:async';

class FirstPage extends StatefulWidget {
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  void initState() {
    super.initState();
    Future _login() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String getToken(String key) => prefs.getString(key);
      String username = getToken("phone");
      String password = getToken("password");
      int code = await getUserData(username, password);
      // code.then((data) => data);
      // print(code);
      return code;
    }

    Timer timer = new Timer(
      const Duration(milliseconds: 2500),
      () {
        try {
          _login().then((res) {
            if (res == 200) {
              Navigator.of(context).pushAndRemoveUntil(
                  new MaterialPageRoute(
                    builder: (BuildContext context) => new MyHomePage(),
                  ),
                  (Route route) => route == null); //跳转到主页
            } else {
              Navigator.of(context).pushAndRemoveUntil(
                  new MaterialPageRoute(
                    builder: (BuildContext context) => new LoginPage(),
                  ),
                  (Route route) => route == null);
            }
          });
        } catch (e) {}
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          margin: EdgeInsets.only(
            left: 0,
            top: 0,
          ),
          padding: EdgeInsets.all(0),
          width: double.infinity,
          //height: DateTime.now().toString().substring(6, 10) == "05-16"?double.infinity:500,
          child: Image.network(
            "http://139.199.169.159:3243/startimg",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
