import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:petmily/providers/get_postlist.dart';
import 'package:petmily/screens/post/add_post.dart';
import 'package:petmily/screens/post/detail_post.dart';
import 'package:petmily/services/favorite_service.dart';
import 'package:petmily/widgets/snackbar_widget.dart';
import 'package:petmily/widgets/variable_text.dart';
import 'package:provider/provider.dart';

class ChannelScreen extends StatelessWidget {
  ChannelScreen(
      {super.key, required this.channelId, required this.channelTitle});
  final channelId;
  final channelTitle;

  final getPostList = GetPostData();

  @override
  Widget build(BuildContext context) {
    final dynamicColor = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
        create: (context) => GetPostData(),
        child: Consumer<GetPostData>(builder: (context, getPostList, child) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Container(
                  margin: const EdgeInsets.only(left: 8),
                  width: width,
                  height: 80,
                  alignment: Alignment.centerLeft,
                  child: VariableText(
                    value: "$channelTitle",
                    size: 40,
                    wght: 300,
                    color: dynamicColor.primary,
                  )),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                      onPressed: () {
                        FavoriteService().addFavorite(channelId);
                        snackBar(context, "즐겨찾기에 추가했어요!");
                      },
                      icon: Icon(
                        Icons.favorite_border,
                        color: dynamicColor.primary,
                        size: 35,
                      )),
                )
              ],
            ),
            body: SingleChildScrollView(
                child: Column(children: [
              SizedBox(
                  height: height - 180,
                  child: FutureBuilder(
                    future: getPostList.getPost(channelId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: dynamicColor.primary,
                          ),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        var channelListLength = snapshot.data!.length;
                        return Column(
                          children: [
                            Container(
                                width: width,
                                padding: const EdgeInsets.only(right: 20),
                                alignment: Alignment.topRight,
                                child: VariableText(
                                  value: "총 $channelListLength 건",
                                  size: 14,
                                  wght: 300,
                                  color: dynamicColor.onSurface,
                                )),
                            SizedBox(
                              height: height - 200,
                              child: ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    var postTitle = snapshot.data![index].title;
                                    var postContent =
                                        snapshot.data![index].content;
                                    var postFavorite =
                                        snapshot.data![index].likePost;
                                    var imagePath =
                                        snapshot.data![index].imagePath;
                                    var hit = snapshot.data![index].hit;

                                    var postWriter =
                                        snapshot.data![index].nickname;
                                    var postId = snapshot.data![index].id;
                                    return GestureDetector(
                                      child: Card(
                                        margin: const EdgeInsets.all(10),
                                        color: dynamicColor.surfaceVariant,
                                        elevation: 0,
                                        child: Column(
                                          children: [
                                            Container(
                                                width: width,
                                                alignment: Alignment.topLeft,
                                                padding: const EdgeInsets.only(
                                                    left: 10, top: 10),
                                                child: Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    height: 40,
                                                    child: Row(
                                                      children: [
                                                        const Icon(Icons.person,
                                                            size: 25),
                                                        VariableText(
                                                          value: "$postWriter",
                                                          size: 23,
                                                          wght: 300,
                                                          color: dynamicColor
                                                              .onSurfaceVariant,
                                                        )
                                                      ],
                                                    ))),
                                            imagePath == "www.imagepath.com"
                                                ? Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10,
                                                            bottom: 10),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    width: width,
                                                    height: 150,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 2,
                                                            color: dynamicColor
                                                                .onSurfaceVariant),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25)),
                                                    child: Row(children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Lottie.network(
                                                            "https://assets4.lottiefiles.com/packages/lf20_OT15QW.json"),
                                                      ),
                                                      const Expanded(
                                                          flex: 3,
                                                          child: VariableText(
                                                            value:
                                                                "이미지가 없는 게시물이에요!",
                                                            size: 19,
                                                            wght: 400,
                                                          ))
                                                    ]))
                                                : Container(
                                                    width: width * .9,
                                                    height: 150,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 2,
                                                          color: dynamicColor
                                                              .onSurfaceVariant),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              "$imagePath"),
                                                          fit:
                                                              BoxFit.fitHeight),
                                                    ),
                                                  ),
                                            Container(
                                                width: width,
                                                alignment: Alignment.topLeft,
                                                padding: const EdgeInsets.only(
                                                    left: 10, bottom: 10),
                                                child: VariableText(
                                                  value: "$postTitle",
                                                  size: 17,
                                                  wght: 500,
                                                )),
                                            Container(
                                              width: width,
                                              alignment: Alignment.topLeft,
                                              padding: const EdgeInsets.only(
                                                  left: 10, bottom: 10),
                                              child: VariableText(
                                                value: "$postContent",
                                                size: 15,
                                                wght: 300,
                                              ),
                                            ),
                                            Container(
                                              width: width,
                                              alignment: Alignment.bottomRight,
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10, right: 10),
                                                width: width * .4,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            FaIcon(
                                                              FontAwesomeIcons
                                                                  .heart,
                                                              size: 12,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          5.0),
                                                              child:
                                                                  VariableText(
                                                                value:
                                                                    "$postFavorite",
                                                                size: 12,
                                                                wght: 500,
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            FaIcon(
                                                              FontAwesomeIcons
                                                                  .eye,
                                                              size: 12,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          5.0),
                                                              child:
                                                                  VariableText(
                                                                value: "$hit",
                                                                size: 12,
                                                                wght: 500,
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailPostScreen(
                                                      channelId: channelId,
                                                      postId: postId!,
                                                    )));
                                      },
                                    );
                                  }),
                            ),
                          ],
                        );
                      } else {
                        return Text('에러발생'); // 화면 불러오기 실패에 대한 컨텐츠 제작 예정
                      }
                    },
                  ))
            ])),
            bottomNavigationBar: BottomAppBar(
              height: 80,
              color: dynamicColor.surfaceVariant,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endContained,
            floatingActionButton: FloatingActionButton(
              backgroundColor: dynamicColor.secondary,
              elevation: 0,
              onPressed: () {
                // getPost(channelId);
                /** 포스트 생성 메소드 */
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddPostScreen(
                              channelId: channelId,
                            )));

                snackBar(context, "게시물 추가 성공!");
              },
              tooltip: 'Add',
              child: Icon(
                Icons.add,
                color: dynamicColor.onSecondary,
              ),
            ),
          );
        }));
  }
}

class PostData {
  final String postWriter;
  final String postImagePath;
  final String postTitle;
  final String postSubTitle;
  final int postFavoriteCount;
  final int postCommentCount;

  // Constructor for the class
  PostData(
      {required this.postWriter,
      required this.postImagePath,
      required this.postTitle,
      required this.postSubTitle,
      required this.postFavoriteCount,
      required this.postCommentCount});
}
