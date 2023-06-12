class MyPageData {
  String? email;
  String? password;
  String? nickname;
  String? createDate;

  MyPageData({this.email, this.password, this.nickname, this.createDate});

  MyPageData.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    nickname = json['nickname'];
    createDate = json['createDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['nickname'] = this.nickname;
    data['createDate'] = this.createDate;
    return data;
  }
}
