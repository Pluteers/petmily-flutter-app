import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petmily/providers/add_post.dart';

import 'package:image_picker/image_picker.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:petmily/providers/upload_image.dart';
import 'package:petmily/widgets/variable_text.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key, required this.channelId});
  final channelId;

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  List<Asset> images = <Asset>[];
  XFile? _pickedFile;
  String? imageString;

  List<String>? imagePaths;
  _getCameraImage() async {
    final pickedFile = await MultipleImagesPicker.pickImages(
      maxImages: 300,
      enableCamera: true,
      selectedAssets: images,
      cupertinoOptions: CupertinoOptions(takePhotoIcon: "추가"),
      materialOptions: MaterialOptions(
        actionBarColor: "#abcdef",
        actionBarTitle: "이미지 추가하기",
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
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            width: width,
            alignment: Alignment.centerLeft,
            child: VariableText(
              value: "게시글 추가",
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
                  controller: AddPost.postTitleController,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: '게시물 제목',
                    labelStyle: TextStyle(color: dynamicColor.primary),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        AddPost.postTitleController.clear();
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
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                            width: 1, color: dynamicColor.onBackground)),
                    child: images.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                    onPressed: () {
                                      _getCameraImage();
                                    },
                                    icon: const FaIcon(
                                        FontAwesomeIcons.solidImages)),
                              ),
                              Expanded(
                                  child: const SizedBox(
                                child: VariableText(
                                  value: "게시글에 이미지를 추가해보세요",
                                  size: 12,
                                  wght: 300,
                                ),
                              ))
                            ],
                          )
                        : Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: images.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      Asset asset = images[index];
                                      return GestureDetector(
                                        child: AssetThumb(
                                            asset: asset,
                                            width: 500,
                                            height: 500),
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                width: width * .5,
                                                height: height * .5,
                                                child: AssetThumb(
                                                  asset: asset,
                                                  width: 500,
                                                  height: 500,
                                                  quality: 100,
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      );
                                    }),
                              ),
                            ),
                          ),
                  ),
                )),
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
                      controller: AddPost.postContentController,
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
          fetchData(images);
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: VariableText(
                  value: "게시글을 등록하시겠습니까?",
                  size: 20,
                  wght: 300,
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        AddPost.addPost(widget.channelId, imageString);
                      },
                      child: VariableText(
                        value: "등록",
                        size: 20,
                        wght: 300,
                      ))
                ],
              );
            },
          );
        },
        label: const Text('게시글 등록하기'),
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void fetchData(image) async {
    String? value = await UploadImage().uploadImage(images);
    setState(() {
      UploadImage().uploadImage(image).then((value) {
        imageString = value;
      });
    });
  }
}
