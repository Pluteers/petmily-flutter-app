import 'package:flutter/material.dart';
import 'package:petmily/screens/channel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamicColor = Theme.of(context).colorScheme;
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
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
    ];
    return Scaffold(
      backgroundColor: dynamicColor.background,
      appBar: AppBar(
        title: SizedBox(width: _width, child: const Text('channel')),
      ),
      body: SafeArea(
        child: SizedBox(
          height: _height * 0.7,
          child: GridView.count(
            crossAxisCount: 2,
            children: List.generate(imageDataList.length, (index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage(
                            imageDataList[index].imagePath), // 이미지 파일 경로
                        fit: BoxFit.cover, // 이미지 채우는 방법
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: _width,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: dynamicColor.primary,
                            ),
                            child: Text(
                              imageDataList[index].name,
                              style: TextStyle(color: dynamicColor.onPrimary),
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
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: dynamicColor.surfaceVariant,
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
