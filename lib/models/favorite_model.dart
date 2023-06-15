class FavoriteListModel {
  String? status;
  String? message;
  List<Data>? data;

  FavoriteListModel({
    this.status,
    this.message,
    this.data,
  });

  FavoriteListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
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
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? channelId;
  String? channelName;
  String? categoryName;
  int? categoryId;
  int? memberId;
  String? nickname;
  String? url;

  Data({
    this.channelId,
    this.channelName,
    this.categoryName,
    this.categoryId,
    this.memberId,
    this.nickname,
    this.url,
  });

  Data.fromJson(Map<String, dynamic> json) {
    channelId = json['channelId'];
    channelName = json['channelName'];
    categoryName = json['categoryName'];
    categoryId = json['categoryId'];
    memberId = json['memberId'];
    nickname = json['nickname'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['channelId'] = channelId;
    data['channelName'] = channelName;
    data['categoryName'] = categoryName;
    data['categoryId'] = categoryId;
    data['memberId'] = memberId;
    data['nickname'] = nickname;
    data['url'] = url;
    return data;
  }
}
