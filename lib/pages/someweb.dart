import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';

_getUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String getToken(String key) => prefs.getString(key);
  String token = getToken("token");
  String photoUrl = getToken("photo");
  String trueName = getToken("truename");
  String email = getToken("email");
  String role = getToken("role");
  String dateCreate = getToken("date_create");
  print(token);
  Map theData = {
    "token": token,
  };
  return theData;
}

// void initState() {
//   super.initState();
//   _getUserData();
// }
var tokendata = _getUserData();

WebWithToken(String title, String url) {
  return FutureBuilder(
    future: _getUserData(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        print(snapshot.data["token"]);
        return webToken(snapshot.data["token"], title, url);
      }
    },
  );
}

WebWithNoToken(String title, String url) {
  return web(title, url);
}

WebWithLoc(String title, String url) {
  return FutureBuilder(
    future: _getUserData(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        print(snapshot.data["token"]);
        return webLoc(
            snapshot.data["token"], snapshot.data["role"], title, url);
      }
    },
  );
}

web(String text, String url) {
  WebviewScaffold voteWeb = WebviewScaffold(
    url: url,
    appBar: new AppBar(
      title: new Text("$text"),
    ),
  );
  return voteWeb;
}

webToken(String token, String text, String url) {
  WebviewScaffold voteWeb = WebviewScaffold(
    url: url,
    withLocalStorage: true,
    headers: {"authorization": token},
    appBar: new AppBar(
      title: new Text("$text"),
    ),
  );
  return voteWeb;
}

// WebviewScaffold monthstarWeb = WebviewScaffold(
//   url: "https://us.ncuhomer.cn/darkhut/month_star",
//   appBar: new AppBar(
//     title: new Text("每月之星"),
//   ),
// );

webLoc(String token, String role, String text, String url) {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  //flutterWebviewPlugin.launch(url).whenComplete(action)
  flutterWebviewPlugin.launch(
    url,
    withLocalStorage: true,
    withJavascript: true,
    enableAppScheme: true,
    hidden: false,
    headers: {"authorization": token},
    // appBar: new AppBar(
    //   title: new Text("$text"),
    // ),
  ).whenComplete(() {
    final res = flutterWebviewPlugin.evalJavascript(
        "(function() { try { window.localStorage.setItem('us-token', '$token'); window.localStorage.setItem('us-auth', '$role');} catch (err) { return err; } })();");
    // Wrapped `setItem` into a func that would return some helpful info in case it throws.
    print("Eval result: $res");
  });
  return flutterWebviewPlugin;
}
