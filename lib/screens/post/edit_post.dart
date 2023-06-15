import 'package:flutter/material.dart';
import 'package:petmily/services/post_service.dart';
import 'package:petmily/widgets/variable_text.dart';

class EditPostScreen extends StatelessWidget {
  const EditPostScreen(
      {super.key, required this.channelId, required this.postId});
  final int channelId;
  final int postId;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final dynamicColor = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            width: width,
            alignment: Alignment.centerLeft,
            child: VariableText(
              value: "게시글 수정",
              size: 20,
              wght: 500,
              color: dynamicColor.surfaceTint,
            ),
          )),
      body: SafeArea(
          child: SizedBox(
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
                child: TextFormField(
                  controller: PostService().editTitle,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: '게시물 제목',
                    labelStyle: TextStyle(color: dynamicColor.primary),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        PostService().editTitle.clear();
                      },
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide:
                            BorderSide(width: 1, color: dynamicColor.primary)),
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 4,
                child: Container(
                  width: width,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1, color: dynamicColor.onBackground),
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 8.0),
                    child: TextFormField(
                      controller: PostService().editContent,
                      obscureText: false,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          labelText: '게시물 내용',
                          labelStyle: TextStyle(color: dynamicColor.primary),
                          border: InputBorder.none),
                    ),
                  ),
                )),
            const Expanded(flex: 1, child: SizedBox())
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: VariableText(
                  value: "게시글을 수정하시겠습니까?",
                  size: 20,
                  wght: 300,
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        PostService().editPost(channelId, postId);
                      },
                      child: VariableText(
                        value: "수정",
                        size: 20,
                        wght: 300,
                      ))
                ],
              );
            },
          );
        },
        label: const Text('게시글 수정'),
        icon: const Icon(Icons.edit),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
