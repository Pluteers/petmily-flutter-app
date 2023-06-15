class MyCommentModel {
  String? status;
  String? message;
  String? commentWriter;
  List<Data>? data;

  MyCommentModel({this.status, this.message, this.commentWriter, this.data});

  MyCommentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    commentWriter = json['commentWriter'];
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
    data['commentWriter'] = this.commentWriter;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? createDate;
  String? lastModifiedDate;
  int? commentId;
  String? content;
  int? commentLike;
  String? nickname;
  int? memberId;
  String? postTitle;
  int? postId;

  Data(
      {this.createDate,
      this.lastModifiedDate,
      this.commentId,
      this.content,
      this.commentLike,
      this.nickname,
      this.memberId,
      this.postTitle,
      this.postId});

  Data.fromJson(Map<String, dynamic> json) {
    createDate = json['createDate'];
    lastModifiedDate = json['lastModifiedDate'];
    commentId = json['commentId'];
    content = json['content'];
    commentLike = json['commentLike'];
    nickname = json['nickname'];
    memberId = json['memberId'];
    postTitle = json['postTitle'];
    postId = json['postId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createDate'] = this.createDate;
    data['lastModifiedDate'] = this.lastModifiedDate;
    data['commentId'] = this.commentId;
    data['content'] = this.content;
    data['commentLike'] = this.commentLike;
    data['nickname'] = this.nickname;
    data['memberId'] = this.memberId;
    data['postTitle'] = this.postTitle;
    data['postId'] = this.postId;
    return data;
  }
}
