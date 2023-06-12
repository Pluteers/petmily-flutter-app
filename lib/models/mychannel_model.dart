class MyChannelModel {
  List<Data>? data;

  MyChannelModel({this.data});

  MyChannelModel.fromJson(Map<String, dynamic> json) {
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
  int? channelId;
  String? channelName;
  String? categoryName;
  int? categoryId;
  int? memberId;
  String? nickname;
  String? url;

  Data(
      {this.channelId,
      this.channelName,
      this.categoryName,
      this.categoryId,
      this.memberId,
      this.nickname,
      this.url});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['channelId'] = this.channelId;
    data['channelName'] = this.channelName;
    data['categoryName'] = this.categoryName;
    data['categoryId'] = this.categoryId;
    data['memberId'] = this.memberId;
    data['nickname'] = this.nickname;
    data['url'] = this.url;
    return data;
  }
}
