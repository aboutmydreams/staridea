import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:flukit/flukit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/loginus.dart';
import '../data/userlogin.dart';
import '../main.dart';

class SettingPage extends StatefulWidget {
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              '退出登录',
              textAlign: TextAlign.left,
            ),
            leading: Icon(Icons.power_settings_new,
                color: Colors.black12, size: 22.0),
            onTap: () async {
              // Navigator.pushNamed(context, "/login");
              Navigator.of(context).pushAndRemoveUntil(
                  new MaterialPageRoute(
                    builder: (BuildContext context) => new LoginPage(),
                  ),
                  (Route route) => route == null);
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
            },
          ),
        ],
      ),
    );
  }
}
