import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'package:petmily/screens/post/edit_post_screen.dart';
import 'package:petmily/services/comment_service.dart';
import 'package:petmily/services/detail_post_service.dart';
import 'package:petmily/services/get_commentList.dart';
import 'package:petmily/services/post_postLike.dart';
import 'package:petmily/services/post_service.dart';
import 'package:petmily/services/scrap_service.dart';
import 'package:petmily/widgets/snackbar_widget.dart';
import 'package:petmily/widgets/variable_text.dart';

class DetailPostScreen extends StatefulWidget {
  const DetailPostScreen({
    super.key,
    required this.channelId,
    required this.postId,
  });

  final int channelId;
  final int postId;

  @override
  State<DetailPostScreen> createState() => _DetailPostScreenState();
}

class _DetailPostScreenState extends State<DetailPostScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
                ),
              ),
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
                setState(
                  () {
                    Future.delayed(
                      const Duration(milliseconds: 15000),
                      () {
                        Provider.of<DetailPostProvider>(context, listen: false)
                            .getDetailPostProvider(
                          widget.channelId,
                          widget.postId,
                        );
                      },
                    );
                  },
                );
              },
            ),
            IconButton(
              icon: FaIcon(
                FontAwesomeIcons.penToSquare,
                color: dynamicColor.primary,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditPostScreen(
                      channelId: widget.channelId,
                      postId: widget.postId,
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: FaIcon(
                FontAwesomeIcons.trash,
                color: dynamicColor.primary,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: dynamicColor.secondaryContainer,
                      title: VariableText(
                        value: "게시글을 삭제하시겠어요?",
                        size: 19,
                        wght: 500,
                        color: dynamicColor.onSecondaryContainer,
                      ),
                      actions: [
                        GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 5,
                              bottom: 5,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                color: dynamicColor.secondary),
                            child: VariableText(
                              value: "삭제",
                              size: 12,
                              wght: 400,
                              color: dynamicColor.onSecondary,
                            ),
                          ),
                          onTap: () {
                            PostService()
                                .deletePost(widget.channelId, widget.postId);
                            snackBar(context, "게시글을 삭제했어요!");
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: FloatingActionButton(
        backgroundColor: dynamicColor.secondary,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: dynamicColor.secondaryContainer,
                title: VariableText(
                  value: "댓글 추가",
                  size: 19,
                  wght: 500,
                  color: dynamicColor.onSecondaryContainer,
                ),
                content: TextFormField(
                  controller: CommentService().addCommentContent,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: '댓글',
                    labelStyle:
                        TextStyle(color: dynamicColor.onSecondaryContainer),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        CommentService().addCommentContent.clear();
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        width: 1,
                        color: dynamicColor.onSecondaryContainer,
                      ),
                    ),
                  ),
                ),
                actions: [
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 5,
                        bottom: 5,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: dynamicColor.secondary),
                      child: VariableText(
                        value: "등록",
                        size: 12,
                        wght: 400,
                        color: dynamicColor.onSecondary,
                      ),
                    ),
                    onTap: () {
                      snackBar(context, "댓글을 추가했어요.");
                      CommentService().addComment(widget.postId);
                    },
                  )
                ],
              );
            },
          );
        },
        tooltip: "댓글 등록",
        child: FaIcon(
          FontAwesomeIcons.comment,
          color: dynamicColor.onPrimary,
        ),
      ),
    );
  }
}

class PostDetail extends StatelessWidget {
  const PostDetail({
    super.key,
    required this.channelId,
    required this.postId,
  });

  final int channelId;
  final int postId;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: width,
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 1,
                                        color: dynamicColor.primary,
                                      ),
                                    ),
                                    child: Center(
                                      child: FaIcon(
                                        FontAwesomeIcons.user,
                                        color: dynamicColor.primary,
                                      ),
                                    ),
                                  ),
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
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: () {
                                    ScrapService().addScrap(postId);
                                    snackBar(context, "스크랩을 추가했어요.");
                                  },
                                  icon: Icon(
                                    Icons.post_add,
                                    size: 32,
                                    color: dynamicColor.primary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  imagePath == "www.imagepath.com"
                      ? Expanded(
                          flex: 2,
                          child: Container(
                            width: width * .9,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: dynamicColor.primaryContainer,
                              ),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Lottie.network(
                                    "https://assets4.lottiefiles.com/packages/lf20_OT15QW.json",
                                  ),
                                ),
                                const Expanded(
                                  flex: 3,
                                  child: VariableText(
                                    value: "이미지가 없는 게시물이에요.",
                                    size: 19,
                                    wght: 400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Expanded(
                          flex: 2,
                          child: Container(
                            width: width * .9,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: dynamicColor.primaryContainer,
                              ),
                              borderRadius: BorderRadius.circular(25.0),
                              image: DecorationImage(
                                image: NetworkImage("$imagePath"),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(height: 20),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Container(
                          width: width,
                          height: 30,
                          margin: const EdgeInsets.only(left: 10),
                          alignment: Alignment.centerLeft,
                          child: VariableText(
                            value: "좋아요 $postLike 개",
                            size: 15,
                            wght: 400,
                          ),
                        ),
                        Container(
                          width: width,
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 10),
                          child: VariableText(
                            value: "$postTitle",
                            size: 15,
                            wght: 300,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: width,
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 10),
                          child: VariableText(
                            value: "$postContent",
                            size: 15,
                            wght: 200,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class PostComment extends StatefulWidget {
  const PostComment({
    super.key,
    required this.postId,
  });

  final int postId;

  @override
  State<PostComment> createState() => _PostCommentState();
}

class _PostCommentState extends State<PostComment> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final dynamicColor = Theme.of(context).colorScheme;
    var commentFuture = GetCommentList().getCommentList(widget.postId);
    return SizedBox(
      width: width * .9,
      height: 200,
      child: Column(
        children: [
          Container(
            width: width,
            alignment: Alignment.topLeft,
            child: const Row(
              children: [
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
            ),
          ),
          const SizedBox(height: 20),
          FutureBuilder(
            future: commentFuture,
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
                      value: "댓글을 불러오는 중 오류가 발생했어요.",
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
                              value: "댓글이 없는 게시물이에요.",
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
                              var like =
                                  snapshot.data!.comment![index].commentLike;
                              var commentId =
                                  snapshot.data!.comment![index].commentId;
                              return InkWell(
                                child: Card(
                                  child: SizedBox(
                                    height: 90,
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: FaIcon(
                                              FontAwesomeIcons.user,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  flex: 2,
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
                                                  flex: 2,
                                                  child: Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: VariableText(
                                                      value: "$content",
                                                      size: 12,
                                                      wght: 300,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 8.0),
                                                          child: Icon(
                                                            Icons.favorite,
                                                            size: 15,
                                                            color: dynamicColor
                                                                .primary,
                                                          ),
                                                        ),
                                                        VariableText(
                                                          value: "$like",
                                                          size: 12,
                                                          wght: 300,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onDoubleTap: () async {
                                  CommentService().likeComment(commentId!);
                                  setState(
                                    () {
                                      commentFuture = GetCommentList()
                                          .getCommentList(widget.postId);
                                    },
                                  );
                                },
                              );
                            },
                          ),
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: dynamicColor.primary,
                  ),
                );
              }
            },
          ),
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
    padding: const EdgeInsets.only(
      left: 10.0,
      bottom: 10.0,
      right: 10,
    ),
    decoration: BoxDecoration(
      border: Border.all(
        width: 1,
        color: dynamicColor.secondary,
      ),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            width: width,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 1,
                color: dynamicColor.primary,
              ),
            ),
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.userAstronaut,
                color: dynamicColor.primary,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
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
