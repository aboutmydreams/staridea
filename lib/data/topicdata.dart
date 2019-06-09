class MyIdeaData {
  int status;
  String message;
  List<Data> data;

  MyIdeaData({this.status, this.message, this.data});

  MyIdeaData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int ideaId;
  String title;
  String content;
  List<String> labels;
  bool isFinish;
  bool isPublish;
  User user;
  // int createTime;

  Data({
    this.ideaId,
    this.title,
    this.content,
    this.labels,
    this.isFinish,
    this.isPublish,
    this.user,
  });

  Data.fromJson(Map<String, dynamic> json) {
    ideaId = json['idea_id'];
    title = json['title'];
    content = json['content'];
    labels = json['labels'].cast<String>();
    isFinish = json['is_finish'];
    isPublish = json['is_publish'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    // createTime = json['create_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idea_id'] = this.ideaId;
    data['title'] = this.title;
    data['content'] = this.content;
    data['labels'] = this.labels;
    data['is_finish'] = this.isFinish;
    data['is_publish'] = this.isPublish;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    // data['create_time'] = this.createTime;
    return data;
  }
}

class User {
  String username;
  int userId;

  User({this.username, this.userId});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['user_id'] = this.userId;
    return data;
  }
}
