import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petmily/providers/add_post.dart';

import 'package:image_picker/image_picker.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:petmily/providers/upload_image.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key, required this.channelId});
  final channelId;

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  List<Asset> images = <Asset>[];
  XFile? _pickedFile;

  List<String>? imagePaths;
  _getCameraImage() async {
    final pickedFile = await MultipleImagesPicker.pickImages(
      maxImages: 300,
      enableCamera: true,
      selectedAssets: images,
      cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
      materialOptions: MaterialOptions(
        actionBarColor: "#abcdef",
        actionBarTitle: "Example App",
        allViewTitle: "All Photos",
        useDetailsView: false,
        selectCircleStrokeColor: "#000000",
      ),
    );
    setState(() {
      images.addAll(pickedFile);
    });
    // imagePaths = pickedFile.map((file) => file.path).cast<String>().toList();
    // List<String> imagePaths = pickedFile.map((file) => file.path).toList();
    // List<String> imagePaths =
    //     pickedFile.map((file) => file).cast<String>().toList();
    // if (pickedFile != null) {
    //   setState(() {
    //     _pickedFile = pickedFile;
    //   });
    // } else {
    //   log('message');
    // }
  }

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
            Expanded(
              flex: 1,
              child: Container(
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
            ),
            Expanded(
                flex: 1,
                child: Container(
                  width: width,
                  height: 100,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: dynamicColor.primaryContainer,
                      borderRadius: BorderRadius.circular(15)),
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: IconButton(
                              onPressed: () {
                                _getCameraImage();
                              },
                              icon: const FaIcon(FontAwesomeIcons.images)),
                        ),
                        Expanded(
                          child: images.isEmpty
                              ? const SizedBox()
                              : SizedBox(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: images.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        Asset asset = images[index];
                                        return AssetThumb(
                                            asset: asset,
                                            width: 80,
                                            height: 80);
                                      }),
                                ),
                        )
                      ],
                    ),
                  ),
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
                )),
            Expanded(
                flex: 4,
                child: Container(
                  width: width,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: dynamicColor.primaryContainer,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 8.0),
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
                )),
            const Expanded(flex: 1, child: SizedBox())
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // AddPost.addPost(widget.channelId);
          UploadImage.uploadImage(images);
        },
        label: const Text('게시글 등록하기'),
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
