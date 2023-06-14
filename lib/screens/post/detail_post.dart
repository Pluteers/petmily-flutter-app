import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import 'package:petmily/services/detail_post_service.dart';
import 'package:petmily/services/get_commentList.dart';
import 'package:petmily/services/post_postLike.dart';
import 'package:petmily/widgets/variable_text.dart';
import 'package:provider/provider.dart';

class DetailPostScreen extends StatefulWidget {
  const DetailPostScreen(
      {super.key, required this.channelId, required this.postId});
  final int channelId;
  final int postId;

  @override
  State<DetailPostScreen> createState() => _DetailPostScreenState();
}

class _DetailPostScreenState extends State<DetailPostScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final dynamicColor = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SizedBox(
          width: width,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: ChangeNotifierProvider<DetailPostProvider>.value(
                  value: DetailPostProvider(),
                  child: PostDetail(
                      channelId: widget.channelId, postId: widget.postId),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: PostComment(
                    postId: widget.postId,
                  ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 80,
        color: dynamicColor.surfaceVariant,
        child: Row(
          children: [
            IconButton(
              icon: FaIcon(
                FontAwesomeIcons.bone,
                color: dynamicColor.primary,
              ),
              onPressed: () {
                PostLike().postLike(widget.channelId, widget.postId);
                setState(() {
                  Future.delayed(Duration(milliseconds: 15000), () {
                    Provider.of<DetailPostProvider>(context, listen: false)
                        .getDetailPostProvider(widget.channelId, widget.postId);
                  });
                });
              },
            ),
            IconButton(
              icon: FaIcon(
                FontAwesomeIcons.penToSquare,
                color: dynamicColor.primary,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: FaIcon(
                FontAwesomeIcons.trash,
                color: dynamicColor.primary,
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: FloatingActionButton(
        backgroundColor: dynamicColor.secondary,
        onPressed: () {
          // GetCommentList.getCommentList(widget.postId);
        },
        tooltip: '댓글 등록',
        child: FaIcon(
          FontAwesomeIcons.comment,
          color: dynamicColor.onPrimary,
        ),
      ),
    );
  }
}

class PostDetail extends StatelessWidget {
  const PostDetail({super.key, required this.channelId, required this.postId});
  final channelId;
  final postId;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final dynamicColor = Theme.of(context).colorScheme;

    return FutureBuilder(
        future: Provider.of<DetailPostProvider>(context)
            .getDetailPostProvider(channelId, postId),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(
                color: dynamicColor.primary,
              ),
            );
          }
          var postTitle = snapshot.data!.title;
          var postContent = snapshot.data!.content;
          var postLike = snapshot.data!.likePost;
          var postWriter = snapshot.data!.nickname;
          var imagePath = snapshot.data!.imagePath;

          return SizedBox(
              width: width * .9,
              child: Scaffold(
                body: SizedBox(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: width,
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 1,
                                          color: dynamicColor.primary)),
                                  child: Center(
                                    child: FaIcon(
                                      FontAwesomeIcons.user,
                                      color: dynamicColor.primary,
                                    ),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 40,
                                alignment: Alignment.center,
                                child: VariableText(
                                  value: "$postWriter",
                                  size: 20,
                                  wght: 600,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      imagePath == "www.imagepath.com"
                          ? Container(
                              width: width * .9,
                              height: 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2,
                                      color: dynamicColor.primaryContainer),
                                  borderRadius: BorderRadius.circular(25)),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Lottie.network(
                                        "https://assets4.lottiefiles.com/packages/lf20_OT15QW.json"),
                                  ),
                                  const Expanded(
                                      flex: 3,
                                      child: VariableText(
                                        value: "이미지가 없는 게시물이에요!",
                                        size: 19,
                                        wght: 400,
                                      ))
                                ],
                              ),
                            )
                          : Container(
                              width: width * .9,
                              height: 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage("$imagePath")),
                              ),
                              child: Text("$imagePath"),
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          width: width,
                          height: 30,
                          margin: const EdgeInsets.only(left: 10),
                          alignment: Alignment.centerLeft,
                          child: VariableText(
                            value: "좋아요 $postLike 개",
                            size: 15,
                            wght: 400,
                          )),
                      Container(
                          width: width * .9,
                          height: 150,
                          margin: const EdgeInsets.all(10),
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              Container(
                                width: width,
                                alignment: Alignment.centerLeft,
                                child: VariableText(
                                  value: "$postTitle",
                                  size: 15,
                                  wght: 300,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: width,
                                alignment: Alignment.centerLeft,
                                child: VariableText(
                                  value: "$postContent",
                                  size: 15,
                                  wght: 200,
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              ));
        });
  }
}

class PostComment extends StatelessWidget {
  const PostComment({super.key, required this.postId});
  final postId;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final dynamicColor = Theme.of(context).colorScheme;
    return Container(
      width: width * .9,
      height: 200,
      child: Column(
        children: [
          Container(
              width: width,
              alignment: Alignment.topLeft,
              child: Row(
                children: const [
                  FaIcon(FontAwesomeIcons.comments),
                  SizedBox(
                    width: 10,
                  ),
                  VariableText(
                    value: "댓글 목록",
                    size: 15,
                    wght: 300,
                  ),
                ],
              )),
          SizedBox(
            height: 20,
          ),
          FutureBuilder(
              future: GetCommentList().getCommentList(postId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: dynamicColor.primary,
                    ),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: VariableText(
                        value: "댓글을 불러오는 중 오류가 발생했어요!",
                        size: 15,
                        wght: 300,
                      ),
                    );
                  } else {
                    return SizedBox(
                      height: 208,
                      child: snapshot.data!.comment!.isEmpty
                          ? const Center(
                              child: VariableText(
                                value: "댓글이 없는 게시물이에요",
                                size: 15,
                                wght: 300,
                              ),
                            )
                          : ListView.builder(
                              itemCount: snapshot.data!.comment!.length,
                              itemBuilder: (context, index) {
                                var nickName =
                                    snapshot.data!.comment![index].nickname;
                                var content =
                                    snapshot.data!.comment![index].content;
                                return Card(
                                  child: SizedBox(
                                    height: 80,
                                    child: Row(
                                      children: [
                                        const Expanded(
                                            flex: 1,
                                            child: Center(
                                                child: FaIcon(
                                                    FontAwesomeIcons.user))),
                                        Expanded(
                                            flex: 3,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: VariableText(
                                                        value: "$nickName",
                                                        size: 15,
                                                        wght: 500,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: VariableText(
                                                        value: "$content",
                                                        size: 12,
                                                        wght: 300,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: dynamicColor.primary,
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}

Widget commentContainer(width, context, nickName, commentContent) {
  final dynamicColor = Theme.of(context).colorScheme;
  return Container(
    width: width,
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10),
    decoration: BoxDecoration(
        border: Border.all(width: 1, color: dynamicColor.secondary)),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
              width: width,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 1, color: dynamicColor.primary)),
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.userAstronaut,
                  color: dynamicColor.primary,
                ),
              )),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 3,
          child: Container(
            width: width * .9,
            height: 50,
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: VariableText(
                      value: "$nickName",
                      size: 15,
                      wght: 300,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: VariableText(
                      value: "$commentContent",
                      size: 12,
                      wght: 300,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
