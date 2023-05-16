import 'package:flutter/material.dart';
import 'package:petmily/providers/get_postlist.dart';
import 'package:petmily/screens/post/add_post.dart';
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
    List<PostData> channelPostList = [
      PostData(
          postWriter: "user01",
          postImagePath: "assets/images/image1.png",
          postTitle: "postTitle",
          postSubTitle: "postSubTitle",
          postFavoriteCount: 3,
          postCommentCount: 2),
      PostData(
          postWriter: "user02",
          postImagePath: "assets/images/image1.png",
          postTitle: "postTitle",
          postSubTitle: "postSubTitle",
          postFavoriteCount: 5,
          postCommentCount: 6),
      PostData(
          postWriter: "user98",
          postImagePath: "assets/images/image1.png",
          postTitle: "postTitle",
          postSubTitle: "postSubTitle",
          postFavoriteCount: 12,
          postCommentCount: 5),
    ];
    final dynamicColor = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (context) => GetPostData(),
      child: Scaffold(
        body: SafeArea(child:
            Consumer<GetPostData>(builder: (context, getPostList, child) {
          return Column(children: [
            Container(
                margin: const EdgeInsets.only(left: 20),
                width: width,
                height: 80,
                alignment: Alignment.centerLeft,
                child: VariableText(
                  value: "$channelTitle",
                  size: 40,
                  wght: 300,
                  color: dynamicColor.primary,
                )),
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
                              padding: const EdgeInsets.only(left: 20),
                              alignment: Alignment.topLeft,
                              child: VariableText(
                                value: "총 $channelListLength ",
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
                                  // var postCreatday = getPostList
                                  //     .data[index].createDate!
                                  //     .substring(0, 10);
                                  // var postModiday = getPostList
                                  //     .data[index].lastModifiedDate!
                                  //     .substring(0, 10);
                                  var postWriter =
                                      snapshot.data![index].nickname;
                                  var postId = snapshot.data![index].id;
                                  return Card(
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
                                                alignment: Alignment.topLeft,
                                                height: 40,
                                                child: Row(
                                                  children: [
                                                    const Icon(Icons.person),
                                                    Text('$postWriter'),
                                                  ],
                                                ))),
                                        Container(
                                          margin: const EdgeInsets.all(10),
                                          alignment: Alignment.centerLeft,
                                          width: width,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(channelPostList[
                                                      0]
                                                  .postImagePath), // 이미지 파일 경로
                                              fit: BoxFit
                                                  .fitHeight, // 이미지 채우는 방법
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: width,
                                          alignment: Alignment.topLeft,
                                          padding: const EdgeInsets.only(
                                              left: 10, bottom: 10),
                                          child: Text('$postTitle'),
                                        ),
                                        Container(
                                          width: width,
                                          alignment: Alignment.topLeft,
                                          padding: const EdgeInsets.only(
                                              left: 10, bottom: 10),
                                          child: Text('$postContent'),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              bottom: 10, right: 10),
                                          child: Row(
                                            children: [
                                              const Expanded(
                                                flex: 2,
                                                child: SizedBox(),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text("$postFavorite"),
                                                    const Text("Favorites"),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                        "${channelPostList[0].postCommentCount}"),
                                                    const Text("Comments"),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
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
          ]);
        })),
        bottomNavigationBar: BottomAppBar(
          height: 80,
          color: dynamicColor.surfaceVariant,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
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
          },
          tooltip: 'Add',
          child: Icon(
            Icons.add,
            color: dynamicColor.onSecondary,
          ),
        ),
      ),
    );
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
