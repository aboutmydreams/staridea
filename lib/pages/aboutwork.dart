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
import 'someweb.dart';

class AboutWorkPage extends StatefulWidget {
  _AboutWorkPageState createState() => _AboutWorkPageState();
}

class _AboutWorkPageState extends State<AboutWorkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            // title: Text('NINGHAO'),
            pinned: true,
            floating: true,
            expandedHeight: 188.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'About Work'.toUpperCase(),
                style: TextStyle(
                  fontSize: 15.0,
                  letterSpacing: 3.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              background: Image.network(
                //'https://resources.ninghao.net/images/overkill.png',
                'https://cdn.nlark.com/yuque/0/2019/png/164272/1557078623315-1f5ea070-d5ad-42f8-9dec-1806dcec4a3c.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverSafeArea(
            sliver: SliverPadding(
                padding: EdgeInsets.all(8.0), sliver: SliverGridDemo()),
          ),
        ],
      ),
    );
  }
}

class SliverGridDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 5.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return InkWell(
            splashColor: Colors.white.withOpacity(0.3),
            highlightColor: Colors.white.withOpacity(0.1),
            onTap: () {
              Navigator.pushNamed(context, urldata[index].route);
            },
            child: ListTile(
              leading: Icon(
                urldata[index].icondata,
                color: Colors.blueAccent,
              ),
              title: Text(
                urldata[index].title,
              ),
              trailing: Icon(Icons.chevron_right),
            ),
            // child: Container(
            //   child: Image.network(
            //     urldata[index].imageUrl,
            //     //"https://upload-images.jianshu.io/upload_images/13145909-e11b1df30828e519?imageMogr2/auto-orient/strip|imageView2/1/w/360/h/240",
            //     fit: BoxFit.cover,
            //   ),
            // ),
          );
        },
        childCount: urldata.length,
        //childCount: 10,
      ),
    );
  }
}

class Urldata {
  Urldata({
    this.title,
    this.imageUrl,
    this.route,
    this.icondata,
  });

  final String title;
  final String imageUrl;
  final String route;
  IconData icondata;
}

final List<Urldata> urldata = [
  Urldata(
    title: "每月之星",
    imageUrl:
        "https://cdn.nlark.com/yuque/0/2019/png/164272/1557109023471-e298d325-93ab-45a0-9ed4-8ff4f13ed1b0.png",
    route: "/monthstar",
    icondata: Icons.star_border,
  ),
  Urldata(
    title: "填工作量",
    imageUrl:
        "https://cdn.nlark.com/yuque/0/2019/png/164272/1557108482314-1bd6b6e5-c51e-40e8-94d8-2b88f2b33b32.png",
    route: "/workload",
    icondata: Icons.web,
  ),
  Urldata(
    title: "投票",
    imageUrl:
        "https://cdn.nlark.com/yuque/0/2019/png/164272/1557111186233-3e0529e4-c9f4-4850-8617-d9ad702f0c46.png",
    route: "/vote",
    icondata: Icons.flag,
  ),
  Urldata(
    title: "活动签到",
    imageUrl:
        "https://cdn.nlark.com/yuque/0/2019/png/164272/1557102986721-495bf7cc-868c-4c49-9bfc-47abe2f24d51.png",
    route: "/meeting",
    icondata: Icons.done_outline,
  ),
  Urldata(
    title: "语雀",
    imageUrl:
        "https://cdn.nlark.com/yuque/0/2019/png/164272/1557103368820-b4e9b08c-6a63-4d6e-acf3-56fd83e40f94.png",
    route: "/yuque",
    icondata: Icons.folder_open,
  ),
  Urldata(
    title: "Teambition",
    imageUrl:
        "https://cdn.nlark.com/yuque/0/2019/png/164272/1557110768198-09b603e7-13f3-4a3b-9ee0-69099fc4ef2d.png",
    route: "/teambition",
    icondata: Icons.supervisor_account,
  ),
  Urldata(
    title: "GitLab",
    imageUrl:
        "https://cdn.nlark.com/yuque/0/2019/png/164272/1557110462447-96902ed4-b8bd-40a8-a087-616f9cab9048.png",
    route: "/gitlab",
    icondata: Icons.code,
  ),
];
