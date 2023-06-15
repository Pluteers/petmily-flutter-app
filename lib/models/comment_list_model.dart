class CommentListModel {
  List<Comment>? comment;

  CommentListModel({this.comment});

  CommentListModel.fromJson(Map<String, dynamic> json) {
    if (json['comment'] != null) {
      comment = <Comment>[];
      json['comment'].forEach((v) {
        comment!.add(Comment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (comment != null) {
      data['comment'] = comment!.map((v) => v.toJson()).toList();
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

  Comment({
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
