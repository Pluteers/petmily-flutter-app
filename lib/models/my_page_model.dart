class MyPageModel {
  String? email;
  String? password;
  String? nickname;
  String? createDate;

  MyPageModel({
    this.email,
    this.password,
    this.nickname,
    this.createDate,
  });

  MyPageModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    nickname = json['nickname'];
    createDate = json['createDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['nickname'] = nickname;
    data['createDate'] = createDate;
    return data;
  }
}
