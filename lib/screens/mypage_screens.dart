import 'package:flutter/material.dart';

import 'package:petmily/screens/login_view.dart';
import 'package:petmily/services/auth_service.dart';
import 'package:petmily/services/favorite_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petmily/services/mypage_service.dart';
import 'package:petmily/services/scrap_service.dart';
import 'package:petmily/widgets/variable_text.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamicColor = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;

    String userId = "";
    String userNickname = "";

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Container(
            width: width,
            height: 80,
            alignment: Alignment.centerLeft,
            child: VariableText(
              value: "회원 정보",
              color: dynamicColor.primary,
              size: 35.0,
              wght: 400.0,
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginView(),
                    ));
                AuthService().signOut();
              },
              icon: Icon(
                Icons.exit_to_app,
                color: dynamicColor.onBackground,
                size: 30,
              ))
        ],
      ),
      body: SafeArea(
          child: SizedBox(
              width: width,
              child: FutureBuilder(
                future: UserService().userInfo(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: dynamicColor.primary,
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    var email = snapshot.data!.email;
                    var nickname = snapshot.data!.nickname;

                    var createDate =
                        snapshot.data!.createDate!.substring(0, 10);
                    userId = email!;
                    userNickname = nickname!;
                    return Column(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                      margin: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: dynamicColor.primary),
                                    )),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                              alignment: Alignment.topLeft,
                                              child: VariableText(
                                                value: "E-mail",
                                                size: 17,
                                                wght: 500,
                                                color:
                                                    dynamicColor.onBackground,
                                              )),
                                          Container(
                                            alignment: Alignment.bottomRight,
                                            margin: const EdgeInsets.only(
                                                right: 20),
                                            child: VariableText(
                                              value: email,
                                              size: 17,
                                              wght: 300,
                                              color: dynamicColor.onBackground,
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                              alignment: Alignment.topLeft,
                                              child: VariableText(
                                                value: "NickName",
                                                size: 17,
                                                wght: 500,
                                                color:
                                                    dynamicColor.onBackground,
                                              )),
                                          Container(
                                            alignment: Alignment.bottomRight,
                                            margin: const EdgeInsets.only(
                                                right: 20),
                                            child: VariableText(
                                              value: nickname,
                                              size: 17,
                                              wght: 300,
                                              color: dynamicColor.onBackground,
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                              alignment: Alignment.topLeft,
                                              child: VariableText(
                                                value: "Create Day",
                                                size: 17,
                                                wght: 500,
                                                color:
                                                    dynamicColor.onBackground,
                                              )),
                                          Container(
                                            alignment: Alignment.bottomRight,
                                            margin: const EdgeInsets.only(
                                                right: 20),
                                            child: VariableText(
                                              value: createDate,
                                              size: 17,
                                              wght: 300,
                                              color: dynamicColor.onBackground,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                        Expanded(
                            flex: 2,
                            child: SizedBox(
                              width: width * .9,
                              child: const MyPageTabView(),
                            ))
                      ],
                    );
                  } else {
                    return Center(
                        child: VariableText(
                      value: "데이터를 불러오는데 실패했어요",
                      size: 30,
                      wght: 500,
                      color: dynamicColor.primary,
                    ));
                  }
                },
              ))),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: dynamicColor.primaryContainer,
        tooltip: "회원 정보 수정",
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return EditBottomSheet(
                  userId: userId,
                  userNickname: userNickname,
                );
              });
        },
        icon: Icon(
          Icons.edit,
          color: dynamicColor.onPrimaryContainer,
        ),
        label: VariableText(
          value: "Edit",
          size: 17,
          color: dynamicColor.onPrimaryContainer,
          wght: 300,
        ),
      ),
    );
  }
}

class MyPageTabView extends StatefulWidget {
  const MyPageTabView({super.key});

  @override
  State<MyPageTabView> createState() => _MyPageTabViewState();
}

class _MyPageTabViewState extends State<MyPageTabView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 30,
          bottom: const TabBar(
            tabs: [
              Center(
                child: VariableText(
                  value: "내가 작성한",
                  size: 15,
                  wght: 500,
                ),
              ),
              Center(
                child: VariableText(
                  value: "즐겨찾기",
                  size: 15,
                  wght: 500,
                ),
              ),
              Center(
                child: VariableText(
                  value: "스크랩",
                  size: 15,
                  wght: 500,
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: MyChannelPostView(),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: UserFavoriteList(),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: UserScrapList(),
          ),
        ]),
      ),
    );
  }
}

class UserFavoriteList extends StatelessWidget {
  const UserFavoriteList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
          onPressed: () {
            ScrapService().userScrapList();
          },
          child: Text("data")),
    );
  }
}

class UserScrapList extends StatelessWidget {
  const UserScrapList({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamicColor = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: FutureBuilder(
        future: ScrapService().userScrapList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: CircularProgressIndicator(
                color: dynamicColor.primary,
              ),
            );
          } else {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: dynamicColor.primary,
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: snapshot.data!.data!.length,
                itemBuilder: (context, index) {
                  var postTitle = snapshot.data!.data![index].post!.title;
                  var channelName =
                      snapshot.data!.data![index].post!.channelName;
                  var id = snapshot.data!.data![index].post!.id;
                  var nickname = snapshot.data!.data![index].post!.nickname;
                  var postHit = snapshot.data!.data![index].post!.hit;
                  var postLike = snapshot.data!.data![index].post!.likePost;
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: VariableText(
                              value: "$postTitle",
                              size: 15,
                              wght: 500,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.heart,
                                        size: 12,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: VariableText(
                                          value: "$postLike",
                                          size: 12,
                                          wght: 300,
                                        ),
                                      ),
                                    ],
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.eye,
                                        size: 12,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: VariableText(
                                          value: "$postHit",
                                          size: 12,
                                          wght: 300,
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: VariableText(
                                    value: "$channelName",
                                    size: 12,
                                    wght: 300,
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: VariableText(
                                    value: "$nickname",
                                    size: 12,
                                    wght: 300,
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: dynamicColor.primary,
                ),
              );
            }
          }
        },
      ),
    );
  }
}

class MyChannelPostView extends StatelessWidget {
  const MyChannelPostView({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamicColor = Theme.of(context).colorScheme;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: VariableText(
                        value: "채널",
                        size: 15,
                        wght: 500,
                        color: dynamicColor.onBackground,
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(color: dynamicColor.primary),
                      ))
                ],
              )),
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: VariableText(
                        value: "채널",
                        size: 15,
                        wght: 500,
                        color: dynamicColor.onBackground,
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(color: dynamicColor.primary),
                      ))
                ],
              ))
        ],
      ),
    );
  }
}

class EditBottomSheet extends StatelessWidget {
  const EditBottomSheet({
    super.key,
    required this.userId,
    required this.userNickname,
  });
  final String userId;
  final String userNickname;

  @override
  Widget build(BuildContext context) {
    final dynamicColor = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    UserService().editEmailController.text = userId;
    UserService().editNicknameController.text = userNickname;

    return Scaffold(
      backgroundColor: dynamicColor.primary.withOpacity(0.7),
      body: FractionallySizedBox(
          heightFactor: 1,
          child: SizedBox(
              height: height,
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    width: width,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      color: dynamicColor.onPrimary,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, top: 10, bottom: 10),
                    child: Container(
                      width: width,
                      alignment: Alignment.topLeft,
                      child: VariableText(
                        value: "회원정보 수정하기",
                        size: 19,
                        wght: 700,
                        color: dynamicColor.onPrimary,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * .9,
                    child: TextFormField(
                      controller: UserService().editEmailController,
                      obscureText: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: dynamicColor.primaryContainer,
                        hintText: '수정할 이메일형식 아이디를 입력해주세요.',
                        labelText: userId,
                        labelStyle:
                            TextStyle(color: dynamicColor.onPrimaryContainer),
                        hintStyle:
                            TextStyle(color: dynamicColor.onPrimaryContainer),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            UserService().editEmailController.clear();
                          },
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                                width: 1,
                                color: dynamicColor.onPrimaryContainer)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: width * .9,
                    child: TextFormField(
                      controller: UserService().editNicknameController,
                      obscureText: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: dynamicColor.primaryContainer,
                        hintText: '수정할 닉네임을 입력해주세요.',
                        labelText: userNickname,
                        labelStyle:
                            TextStyle(color: dynamicColor.onPrimaryContainer),
                        hintStyle:
                            TextStyle(color: dynamicColor.onPrimaryContainer),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            UserService().editNicknameController.clear();
                          },
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                                width: 1,
                                color: dynamicColor.onPrimaryContainer)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: width * .9,
                    child: TextFormField(
                      controller: UserService().editPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: dynamicColor.primaryContainer,
                        hintText: '수정할 비밀번호를 입력해주세요',
                        labelStyle:
                            TextStyle(color: dynamicColor.onPrimaryContainer),
                        hintStyle:
                            TextStyle(color: dynamicColor.onPrimaryContainer),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            UserService().editPasswordController.clear();
                          },
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                                width: 1,
                                color: dynamicColor.onPrimaryContainer)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          UserService().editUserInfo(onSuccess: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("회원정보를 수정했습니다. 다시 로그인해주세요."),
            ));
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginView(),
                ));
            AuthService().signOut();
          }, onError: (err) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("$err"),
            ));
          });
        },
        icon: const Icon(Icons.edit_document),
        label: VariableText(
          value: "수정하기",
          size: 19,
          wght: 700,
          color: dynamicColor.onPrimaryContainer,
        ),
        backgroundColor: dynamicColor.onPrimary,
      ),
    );
  }
}
