import 'package:flutter/material.dart';
import 'package:petmily/providers/add_post.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key, required this.channelId});
  final channelId;
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
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              width: width,
              height: 80,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: dynamicColor.primaryContainer,
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                    controller: AddPost.postTitleController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: '게시글 제목',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    )),
              ),
            ),
            Container(
              width: width,
              height: 100,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: dynamicColor.primaryContainer,
                  borderRadius: BorderRadius.circular(15)),
              // child: Row(
              //   children: [
              //     Expanded(
              //       child: Column(
              //         children: [
              //           Container(
              //             width: width,
              //             margin: const EdgeInsets.all(10),
              //             alignment: Alignment.centerLeft,
              //             child: const Text('이미지를 추가해보세요'),
              //           ),
              //           Container(
              //               alignment: Alignment.center,
              //               child: IconButton(
              //                 onPressed: () {},
              //                 icon: const Icon(Icons.photo_camera),
              //               )),
              //         ],
              //       ),
              //     ),
              //     Expanded(child: Text('이미지 미리보기 공간'))
              //   ],
              // ),
            ),
            Container(
              width: width,
              height: height - 300,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: dynamicColor.primaryContainer,
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0),
                child: TextFormField(
                    controller: AddPost.postContentController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: '게시글 제목',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    )),
              ),
            )
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          AddPost.addPost(channelId);
        },
        label: const Text('게시글 등록하기'),
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
