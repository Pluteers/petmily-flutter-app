class MyPostModel {
  List<Data>? data;

  MyPostModel({this.data});

  MyPostModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
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

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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
