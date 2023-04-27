import 'package:flutter/material.dart';
import 'package:petmily/widgets/variable_text.dart';

class ChannelScreen extends StatelessWidget {
  const ChannelScreen({super.key, this.channelId});
  final channelId;

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
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Container(
              margin: const EdgeInsets.only(left: 20),
              width: width,
              alignment: Alignment.topLeft,
              child: VariableText(
                value: channelId,
                size: 40,
                wght: 300,
                color: dynamicColor.primary,
              )),
          Container(
              width: width,
              padding: const EdgeInsets.only(left: 20),
              alignment: Alignment.topLeft,
              child: VariableText(
                value: "총 ${channelPostList.length} 건",
                size: 14,
                wght: 300,
                color: dynamicColor.onSurface,
              )),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: height * 0.7,
            width: width,
            child: ListView.builder(
                itemCount: channelPostList.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(10),
                    color: dynamicColor
                        .surfaceVariant, //? figma surface-container 라고 되어 있는데 dynamicColor에 없는듯
                    elevation: 0,
                    child: Column(
                      children: [
                        Container(
                            width: width,
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(left: 10, top: 10),
                            child: Row(
                              children: [
                                const Icon(Icons.person),
                                Text(channelPostList[index].postWriter),
                              ],
                            )),
                        Container(
                          margin: const EdgeInsets.all(10),
                          alignment: Alignment.centerLeft,
                          width: width,
                          height: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              // alignment: Alignment.topLeft,
                              image: AssetImage(channelPostList[index]
                                  .postImagePath), // 이미지 파일 경로
                              fit: BoxFit.fitHeight, // 이미지 채우는 방법
                            ),
                          ),
                        ),
                        Container(
                          width: width,
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(left: 10, bottom: 10),
                          child: Text(channelPostList[index].postTitle),
                        ),
                        Container(
                          width: width,
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(left: 10, bottom: 10),
                          child: Text(channelPostList[index].postSubTitle),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 10, right: 10),
                          child: Row(
                            children: [
                              const Expanded(
                                flex: 2,
                                child: SizedBox(),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                        "${channelPostList[index].postFavoriteCount}"),
                                    const Text("Favorites"),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                        "${channelPostList[index].postCommentCount}"),
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
          )
        ]),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 80,
        color: dynamicColor.surfaceVariant,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: FloatingActionButton(
        backgroundColor: dynamicColor.secondary,
        elevation: 0,
        onPressed: () {},
        tooltip: 'Add',
        child: Icon(
          Icons.add,
          color: dynamicColor.onSecondary,
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
