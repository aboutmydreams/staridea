class MyselfData {
  int status;
  String message;
  Data data;

  MyselfData({this.status, this.message, this.data});

  MyselfData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String username;
  int userId;
  int follower;
  int followed;
  int star;
  int headPic;
  int idea;
  int finish;

  Data(
      {this.username,
      this.userId,
      this.follower,
      this.followed,
      this.star,
      this.headPic,
      this.idea,
      this.finish});

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    userId = json['user_id'];
    follower = json['follower'];
    followed = json['followed'];
    star = json['star'];
    headPic = json['head_pic'];
    idea = json['idea'];
    finish = json['finish'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['user_id'] = this.userId;
    data['follower'] = this.follower;
    data['followed'] = this.followed;
    data['star'] = this.star;
    data['head_pic'] = this.headPic;
    data['idea'] = this.idea;
    data['finish'] = this.finish;
    return data;
  }
}
