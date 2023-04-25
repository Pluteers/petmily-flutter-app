import 'package:flutter/material.dart';
import 'package:petmily/screens/channel.dart';

import 'package:petmily/widgets/variable_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamicColor = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;
    List<ImageData> imageDataList = [
      ImageData(
        imagePath: "assets/images/image1.png",
        name: "CTG01",
        description: "This is the first image.",
      ),
      ImageData(
        imagePath: "assets/images/image1.png",
        name: "CTG02",
        description: "This is the first image.",
      ),
      ImageData(
        imagePath: "assets/images/image1.png",
        name: "CTG03",
        description: "This is the first image.",
      ),
      ImageData(
        imagePath: "assets/images/image1.png",
        name: "CTG04",
        description: "This is the first image.",
      ),
      ImageData(
        imagePath: "assets/images/image1.png",
        name: "CTG05",
        description: "This is the first image.",
      ),
      ImageData(
        imagePath: "assets/images/image1.png",
        name: "CTG06",
        description: "This is the first image.",
      ),
    ];
    return Scaffold(
      backgroundColor: dynamicColor.background,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: width,
              child: VariableText(
                value: "채널",
                color: dynamicColor.primary,
                size: 40.0,
                wght: 300.0,
              ),
            ),
          ),
          HomeGrideView(
            imageDataList: imageDataList,
          ),
        ],
      )),
      bottomNavigationBar: BottomAppBar(
        height: 80,
        color: dynamicColor.surfaceVariant,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: FloatingActionButton(
        backgroundColor: dynamicColor.secondary,
        elevation: 0,
        onPressed: () {
          //TODO : 카테고리 추가 가능하도록 구현
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

class ImageData {
  final String imagePath;
  final String name;
  final String description;

  // Constructor for the class
  ImageData({
    required this.imagePath,
    required this.name,
    required this.description,
  });
}

//메인화면 그리드 뷰
class HomeGrideView extends StatelessWidget {
  const HomeGrideView({super.key, required this.imageDataList});
  final imageDataList;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final dynamicColor = Theme.of(context).colorScheme;
    return SizedBox(
      height: height * 0.7,
      child: GridView.count(
        crossAxisCount: 2, //한 줄에 들어가는 컨텐츠 숫자
        children: List.generate(imageDataList.length, (index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image:
                        AssetImage(imageDataList[index].imagePath), // 이미지 파일 경로
                    fit: BoxFit.cover, // 이미지 채우는 방법
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: width,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          color: dynamicColor.primary.withOpacity(0.9),
                        ),
                        child: VariableText(
                          value: imageDataList[index].name,
                          size: 18,
                          color: dynamicColor.onPrimary,
                          wght: 500,
                        )),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(imageDataList[index].description),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChannelScreen(
                              channelId: imageDataList[index].name,
                            )));
              },
            ),
          );
        }),
      ),
    );
  }
}
