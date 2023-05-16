import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:petmily/providers/detail_post_provider.dart';
import 'package:provider/provider.dart';

class DetailPostScreen extends StatelessWidget {
  const DetailPostScreen(
      {super.key, required this.channelId, required this.postId});
  final channelId;
  final postId;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final dynamicColor = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
            width: width,
            height: height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Consumer<DetailPostProvider>(
                    builder: (context, value, child) {
                      return value.getDetailPostProvider(channelId, postId) !=
                              null
                          ? PostDetail(channelId: channelId, postId: postId)
                          : const Center(
                              child: Text('No Data'),
                            );
                    },
                  ),
                  PostComment()
                ],
              ),
            )),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 80,
        color: dynamicColor.surfaceVariant,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: FloatingActionButton(
        backgroundColor: dynamicColor.secondary,
        elevation: 0,
        onPressed: () {
          DetailPostProvider().getDetailPostProvider(channelId, postId);
        },
        tooltip: 'Add',
        child: Icon(
          Icons.add,
          color: dynamicColor.onSecondary,
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
    final getDetail = DetailPostProvider();
    return Container(
        width: width * .9,
        height: 500,
        decoration: BoxDecoration(
            color: dynamicColor.primaryContainer,
            borderRadius: BorderRadius.circular(15)),
        child: FutureBuilder(
          future: getDetail.getDetailPostProvider(channelId, postId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: dynamicColor.primary,
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              var postTitle = snapshot.data!.title;
              var postContent = snapshot.data!.content;
              var postLike = snapshot.data!.likePost;
              var postWriter = snapshot.data!.nickname;
              return Column(
                children: [Text("$postTitle")],
              );
            } else {
              return const Center(
                child: Text("data"),
              );
            }
          },
        ));
  }
}

class PostComment extends StatelessWidget {
  const PostComment({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final dynamicColor = Theme.of(context).colorScheme;
    return Container(
      width: width * .9,
      height: 200,
      decoration: BoxDecoration(
          color: dynamicColor.primaryContainer,
          borderRadius: BorderRadius.circular(15)),
    );
  }
}
