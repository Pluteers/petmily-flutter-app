class ScrapListModel {
  String? status;
  String? message;
  List<Data>? data;

  ScrapListModel({this.status, this.message, this.data});

  ScrapListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  Post? post;

  Data({this.id, this.post});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    post = json['post'] != null ? new Post.fromJson(json['post']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.post != null) {
      data['post'] = this.post!.toJson();
    }
    return data;
  }
}

class Post {
  String? createDate;
  String? lastModifiedDate;
  int? id;
  String? title;
  String? content;
  String? url;
  int? likePost;
  int? hit;
  String? imagePath;
  int? memberId;
  String? nickname;
  int? channelId;
  String? channelName;
  int? commentCount;

  Post(
      {this.createDate,
      this.lastModifiedDate,
      this.id,
      this.title,
      this.content,
      this.url,
      this.likePost,
      this.hit,
      this.imagePath,
      this.memberId,
      this.nickname,
      this.channelId,
      this.channelName,
      this.commentCount});

  Post.fromJson(Map<String, dynamic> json) {
    createDate = json['createDate'];
    lastModifiedDate = json['lastModifiedDate'];
    id = json['id'];
    title = json['title'];
    content = json['content'];
    url = json['url'];
    likePost = json['likePost'];
    hit = json['hit'];
    imagePath = json['imagePath'];
    memberId = json['memberId'];
    nickname = json['nickname'];
    channelId = json['channelId'];
    channelName = json['channelName'];
    commentCount = json['commentCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createDate'] = this.createDate;
    data['lastModifiedDate'] = this.lastModifiedDate;
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['url'] = this.url;
    data['likePost'] = this.likePost;
    data['hit'] = this.hit;
    data['imagePath'] = this.imagePath;
    data['memberId'] = this.memberId;
    data['nickname'] = this.nickname;
    data['channelId'] = this.channelId;
    data['channelName'] = this.channelName;
    data['commentCount'] = this.commentCount;
    return data;
  }
}
