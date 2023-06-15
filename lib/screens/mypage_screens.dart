import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petmily/screens/initial_screen.dart';

import 'package:petmily/screens/signin_screen.dart';
import 'package:petmily/screens/post/detail_post.dart';
import 'package:petmily/screens/post/post_list.dart';
import 'package:petmily/services/auth_service.dart';
import 'package:petmily/services/chnnel_service.dart';
import 'package:petmily/services/comment_service.dart';
import 'package:petmily/services/favorite_service.dart';
import 'package:petmily/services/mypage_service.dart';
import 'package:petmily/services/post_service.dart';
import 'package:petmily/services/scrap_service.dart';
import 'package:petmily/widgets/variable_text.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamicColor = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
                  builder: (context) => const SignInScreen(),
                ),
              );
              AuthService().signOut();
            },
            icon: Icon(
              Icons.exit_to_app,
              color: dynamicColor.onBackground,
              size: 30,
            ),
          )
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
                var createDate = snapshot.data!.createDate!.substring(0, 10);
                userId = email!;
                userNickname = nickname!;
                // var lottieValue = 0;
                return Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: height,
                              margin: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  width: 1,
                                  color: dynamicColor.primary,
                                ),
                              ),
                              child: Lottie.network(
                                  "https://assets4.lottiefiles.com/packages/lf20_OT15QW.json"),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: VariableText(
                                        value: "E-mail",
                                        size: 17,
                                        wght: 500,
                                        color: dynamicColor.onBackground,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      margin: const EdgeInsets.only(right: 20),
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
                                        color: dynamicColor.onBackground,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      margin: const EdgeInsets.only(right: 20),
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
                                        color: dynamicColor.onBackground,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      margin: const EdgeInsets.only(right: 20),
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
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        width: width * .9,
                        child: const MyPageTabView(),
                      ),
                    )
                  ],
                );
              } else {
                return Center(
                  child: VariableText(
                    value: "데이터를 불러오는데 실패했어요",
                    size: 30,
                    wght: 500,
                    color: dynamicColor.primary,
                  ),
                );
              }
            },
          ),
        ),
      ),
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
    final dynamicColor = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: FutureBuilder(
        future: FavoriteService().userFavoriteList(),
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
              return GridView.builder(
                itemCount: snapshot.data!.data!.length,
                itemBuilder: (context, index) {
                  var channelName = snapshot.data!.data![index].channelName;
                  var channelId = snapshot.data!.data![index].channelId;
                  var categoryId = snapshot.data!.data![index].categoryId;
                  var nickname = snapshot.data!.data![index].nickname;
                  return InkWell(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: VariableText(
                                  value: "$channelName",
                                  size: 15,
                                  wght: 500,
                                ),
                              ),
                            ),
                            categoryId == 1
                                ? Expanded(
                                    flex: 2,
                                    child: Lottie.network(
                                      "https://assets9.lottiefiles.com/packages/lf20_syqnfe7c.json",
                                    ),
                                  )
                                : Expanded(
                                    flex: 2,
                                    child: Lottie.network(
                                      "https://assets4.lottiefiles.com/packages/lf20_OT15QW.json",
                                    ),
                                  ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: VariableText(
                                      value: "$nickname",
                                      size: 12,
                                      wght: 300,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: categoryId == 1
                                          ? FaIcon(
                                              FontAwesomeIcons.bone,
                                              color: dynamicColor.primary,
                                            )
                                          : FaIcon(
                                              FontAwesomeIcons.fish,
                                              color: dynamicColor.primary,
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChannelScreen(
                            channelId: channelId,
                            channelTitle: channelName,
                          ),
                        ),
                      );
                    },
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                  childAspectRatio: 1 / 1, //item 의 가로 1, 세로 1 의 비율
                  mainAxisSpacing: 10, //수평 Padding
                  crossAxisSpacing: 10, //수직 Padding
                ),
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

class UserScrapList extends StatefulWidget {
  const UserScrapList({super.key});

  @override
  State<UserScrapList> createState() => _UserScrapListState();
}

class _UserScrapListState extends State<UserScrapList> {
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
                  var channelId = snapshot.data!.data![index].post!.channelId;
                  var nickname = snapshot.data!.data![index].post!.nickname;
                  var postHit = snapshot.data!.data![index].post!.hit;
                  var postLike = snapshot.data!.data![index].post!.likePost;
                  return InkWell(
                    child: Dismissible(
                      key: ValueKey(snapshot.data?.data![index]),
                      onDismissed: (direction) {
                        setState(() {
                          snapshot.data?.data!.removeAt(index);
                          ChannelService().deleteChannel(channelId);
                        });
                      },
                      background: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: dynamicColor.error),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.delete,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                      secondaryBackground: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: dynamicColor.error),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.delete,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                      child: Card(
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, bottom: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const FaIcon(
                                            FontAwesomeIcons.heart,
                                            size: 12,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: VariableText(
                                              value: "$postLike",
                                              size: 12,
                                              wght: 300,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const FaIcon(
                                            FontAwesomeIcons.eye,
                                            size: 12,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: VariableText(
                                              value: "$postHit",
                                              size: 12,
                                              wght: 300,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      /** 게시물 이동 추가 */
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPostScreen(
                            channelId: channelId!,
                            postId: id!,
                          ),
                        ),
                      );
                    },
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

class MyChannelPostView extends StatefulWidget {
  const MyChannelPostView({super.key});

  @override
  State<MyChannelPostView> createState() => _MyChannelPostViewState();
}

class _MyChannelPostViewState extends State<MyChannelPostView> {
  @override
  Widget build(BuildContext context) {
    final dynamicColor = Theme.of(context).colorScheme;
    return SizedBox.expand(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              child: FutureBuilder(
                future: UserService().myChannel(),
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: dynamicColor.secondaryContainer),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: VariableText(
                              value: "채널",
                              size: 15,
                              wght: 500,
                              color: dynamicColor.onBackground,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: ListView.builder(
                          itemCount: snapshot.data?.data!.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            var title = snapshot.data?.data![index].channelName;
                            var channelId =
                                snapshot.data?.data![index].channelId;
                            return InkWell(
                              child: Dismissible(
                                key: ValueKey(snapshot.data?.data![index]),
                                onDismissed: (direction) {
                                  setState(() {
                                    snapshot.data?.data!.removeAt(index);
                                    ChannelService().deleteChannel(channelId);
                                  });
                                },
                                background: Container(
                                  margin: const EdgeInsets.all(8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: dynamicColor.error),
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.delete,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                ),
                                secondaryBackground: Container(
                                  margin: const EdgeInsets.all(8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: dynamicColor.error),
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.delete,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                ),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: VariableText(
                                        value: "$title",
                                        size: 13,
                                        wght: 500,
                                        color: dynamicColor.onBackground,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChannelScreen(
                                      channelId: channelId,
                                      channelTitle: title,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              child: FutureBuilder(
                future: UserService().myPost(),
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: dynamicColor.secondaryContainer,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: VariableText(
                              value: "게시물",
                              size: 15,
                              wght: 500,
                              color: dynamicColor.onBackground,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: ListView.builder(
                          itemCount: snapshot.data?.data!.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            var title = snapshot.data?.data![index].title;
                            // var hit = snapshot.data?.data![index].hit;
                            // var likePost = snapshot.data?.data![index].likePost;
                            var channelId =
                                snapshot.data?.data![index].channelId;
                            var postId = snapshot.data?.data![index].id;
                            return InkWell(
                              child: Dismissible(
                                key: ValueKey(
                                  snapshot.data?.data![index],
                                ),
                                onDismissed: (direction) {
                                  setState(
                                    () {
                                      snapshot.data?.data!.removeAt(index);
                                      PostService().deletePost(
                                        channelId!,
                                        postId!,
                                      );
                                    },
                                  );
                                },
                                background: Container(
                                  margin: const EdgeInsets.all(8.0),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.0),
                                    color: dynamicColor.error,
                                  ),
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.delete,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                ),
                                secondaryBackground: Container(
                                  margin: const EdgeInsets.all(8.0),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.0),
                                    color: dynamicColor.error,
                                  ),
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.delete,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                ),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: VariableText(
                                        value: "$title",
                                        size: 13,
                                        wght: 500,
                                        color: dynamicColor.onBackground,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPostScreen(
                                      channelId: channelId!,
                                      postId: postId!,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              child: FutureBuilder(
                future: UserService().myComment(),
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: dynamicColor.secondaryContainer,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: VariableText(
                                value: "댓글",
                                size: 15,
                                wght: 500,
                                color: dynamicColor.onBackground,
                              ),
                            ),
                          )),
                      // Expanded(flex: 3, child: SizedBox()),
                      Expanded(
                        flex: 3,
                        child: ListView.builder(
                          itemCount: snapshot.data?.data!.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            var title = snapshot.data?.data![index].content;
                            var commentId =
                                snapshot.data?.data![index].commentId;
                            return Dismissible(
                              key: ValueKey(snapshot.data?.data![index]),
                              onDismissed: (direction) {
                                setState(() {
                                  CommentService().deleteComment(commentId!);
                                  snapshot.data?.data!.removeAt(index);
                                });
                              },
                              background: Container(
                                margin: const EdgeInsets.all(8.0),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  color: dynamicColor.error,
                                ),
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.delete,
                                  size: 25,
                                  color: Colors.white,
                                ),
                              ),
                              secondaryBackground: Container(
                                margin: const EdgeInsets.all(8.0),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  color: dynamicColor.error,
                                ),
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.delete,
                                  size: 25,
                                  color: Colors.white,
                                ),
                              ),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: VariableText(
                                      value: "$title",
                                      size: 13,
                                      wght: 500,
                                      color: dynamicColor.onBackground,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EditBottomSheet extends StatelessWidget {
  final String userId;
  final String userNickname;

  const EditBottomSheet({
    super.key,
    required this.userId,
    required this.userNickname,
  });

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
                padding: const EdgeInsets.only(left: 10.0, top: 10, bottom: 10),
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
                    hintText: "수정할 이메일형식 아이디를 입력해주세요.",
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
                          width: 1, color: dynamicColor.onPrimaryContainer),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        width: 1,
                        color: dynamicColor.onPrimaryContainer,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                          width: 1, color: dynamicColor.onPrimaryContainer),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          UserService().editUserInfo(
            onSuccess: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("회원정보를 수정했습니다. 다시 로그인해주세요."),
                ),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const InitialScreen(),
                ),
              );
              AuthService().signOut();
            },
            onError: (err) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(err),
                ),
              );
            },
          );
        },
        icon: const Icon(Icons.edit_document),
        backgroundColor: dynamicColor.onPrimary,
        label: VariableText(
          value: "수정하기",
          size: 19,
          wght: 700,
          color: dynamicColor.onPrimaryContainer,
        ),
      ),
    );
  }
}
