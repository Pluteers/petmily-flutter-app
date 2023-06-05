import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:petmily/screens/login_view.dart';
import 'package:petmily/services/auth_service.dart';
import 'package:petmily/services/comment_service.dart';
import 'package:petmily/services/mypage_service.dart';
import 'package:petmily/widgets/variable_text.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamicColor = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;

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
                    return Column(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                      margin: EdgeInsets.all(20),
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
                                              value: "$email",
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
                                              value: "$nickname",
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
                              child: MyPageTabView(),
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
          // CommentService().deleteComment();
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
          bottom: TabBar(
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
        body: TabBarView(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: MyChannelPostView(),
          ),
          Center(
            child: Text("data2"),
          ),
          Center(
            child: Text("data3"),
          ),
        ]),
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
