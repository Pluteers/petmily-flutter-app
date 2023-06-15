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
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['commentWriter'] = commentWriter;
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

  Data({
    this.createDate,
    this.lastModifiedDate,
    this.commentId,
    this.content,
    this.commentLike,
    this.nickname,
    this.memberId,
    this.postTitle,
    this.postId,
  });

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createDate'] = createDate;
    data['lastModifiedDate'] = lastModifiedDate;
    data['commentId'] = commentId;
    data['content'] = content;
    data['commentLike'] = commentLike;
    data['nickname'] = nickname;
    data['memberId'] = memberId;
    data['postTitle'] = postTitle;
    data['postId'] = postId;
    return data;
  }
}
