class CommentListModel {
  List<Comment>? comment;

  CommentListModel({this.comment});

  CommentListModel.fromJson(Map<String, dynamic> json) {
    if (json['comment'] != null) {
      comment = <Comment>[];
      json['comment'].forEach((v) {
        comment!.add(new Comment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.comment != null) {
      data['comment'] = this.comment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comment {
  String? createDate;
  String? lastModifiedDate;
  int? commentId;
  String? content;
  int? commentLike;
  String? nickname;
  int? memberId;
  String? postTitle;
  int? postId;

  Comment(
      {this.createDate,
      this.lastModifiedDate,
      this.commentId,
      this.content,
      this.commentLike,
      this.nickname,
      this.memberId,
      this.postTitle,
      this.postId});

  Comment.fromJson(Map<String, dynamic> json) {
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
