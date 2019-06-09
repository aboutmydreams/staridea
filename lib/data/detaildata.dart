class TopicDetail {
  Topic topic;
  bool love;
  List<Comments> comments;
  int loveCount;

  TopicDetail({this.topic, this.love, this.comments, this.loveCount});

  TopicDetail.fromJson(Map<String, dynamic> json) {
    topic = json['topic'] != null ? new Topic.fromJson(json['topic']) : null;
    love = json['love'];
    if (json['comments'] != null) {
      comments = new List<Comments>();
      json['comments'].forEach((v) {
        comments.add(new Comments.fromJson(v));
      });
    }
    loveCount = json['love_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.topic != null) {
      data['topic'] = this.topic.toJson();
    }
    data['love'] = this.love;
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    data['love_count'] = this.loveCount;
    return data;
  }
}

class Topic {
  int topicId;
  String content;
  User user;
  String dateModify;
  int userId;
  String title;
  int priority;
  List<Labels> labels;
  String dateCreate;
  String brief;

  Topic(
      {this.topicId,
      this.content,
      this.user,
      this.dateModify,
      this.userId,
      this.title,
      this.priority,
      this.labels,
      this.dateCreate,
      this.brief});

  Topic.fromJson(Map<String, dynamic> json) {
    topicId = json['topic_id'];
    content = json['content'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    dateModify = json['date_modify'];
    userId = json['user_id'];
    title = json['title'];
    priority = json['priority'];
    if (json['labels'] != null) {
      labels = new List<Labels>();
      json['labels'].forEach((v) {
        labels.add(new Labels.fromJson(v));
      });
    }
    dateCreate = json['date_create'];
    brief = json['brief'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['topic_id'] = this.topicId;
    data['content'] = this.content;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['date_modify'] = this.dateModify;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['priority'] = this.priority;
    if (this.labels != null) {
      data['labels'] = this.labels.map((v) => v.toJson()).toList();
    }
    data['date_create'] = this.dateCreate;
    data['brief'] = this.brief;
    return data;
  }
}

class User {
  int pendant;
  int userId;
  String photo;
  String truename;
  String department;
  String jobposition;
  String desc;

  User(
      {this.pendant,
      this.userId,
      this.photo,
      this.truename,
      this.department,
      this.jobposition,
      this.desc});

  User.fromJson(Map<String, dynamic> json) {
    pendant = json['pendant'];
    userId = json['user_id'];
    photo = json['photo'];
    truename = json['truename'];
    department = json['department'];
    jobposition = json['jobposition'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pendant'] = this.pendant;
    data['user_id'] = this.userId;
    data['photo'] = this.photo;
    data['truename'] = this.truename;
    data['department'] = this.department;
    data['jobposition'] = this.jobposition;
    data['desc'] = this.desc;
    return data;
  }
}

class Labels {
  int labelId;
  String labelName;
  String imgName;

  Labels({this.labelId, this.labelName, this.imgName});

  Labels.fromJson(Map<String, dynamic> json) {
    labelId = json['label_id'];
    labelName = json['label_name'];
    imgName = json['img_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label_id'] = this.labelId;
    data['label_name'] = this.labelName;
    data['img_name'] = this.imgName;
    return data;
  }
}

class Comments {
  User user;
  BeReplied beReplied;
  Comment comment;

  Comments({this.user, this.beReplied, this.comment});

  Comments.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    beReplied = json['beReplied'] != null
        ? new BeReplied.fromJson(json['beReplied'])
        : null;
    comment =
        json['comment'] != null ? new Comment.fromJson(json['comment']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.beReplied != null) {
      data['beReplied'] = this.beReplied.toJson();
    }
    if (this.comment != null) {
      data['comment'] = this.comment.toJson();
    }
    return data;
  }
}

class BeReplied {
  User user;
  Comment comment;

  BeReplied({this.user, this.comment});

  BeReplied.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    comment =
        json['comment'] != null ? new Comment.fromJson(json['comment']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.comment != null) {
      data['comment'] = this.comment.toJson();
    }
    return data;
  }
}

class Comment {
  int topicId;
  String content;
  String dateCreate;
  int userId;
  int commentId;

  Comment(
      {this.topicId,
      this.content,
      this.dateCreate,
      this.userId,
      this.commentId});

  Comment.fromJson(Map<String, dynamic> json) {
    topicId = json['topic_id'];
    content = json['content'];
    dateCreate = json['date_create'];
    userId = json['user_id'];
    commentId = json['comment_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['topic_id'] = this.topicId;
    data['content'] = this.content;
    data['date_create'] = this.dateCreate;
    data['user_id'] = this.userId;
    if (this.commentId != null) {
      data['comment_id'] = this.commentId;
    }
    return data;
  }
}
