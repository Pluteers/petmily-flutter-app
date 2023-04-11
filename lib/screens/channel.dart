import 'package:flutter/material.dart';
import 'package:petmily/main.dart';
import 'package:petmily/screens/home.dart';
import 'package:petmily/widgets/variable_text.dart';

class ChannelScreen extends StatelessWidget {
  final channelId;
  const ChannelScreen({super.key, this.channelId});

  @override
  Widget build(BuildContext context) {
    List<ImageData> channelImageDataList = [
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
    final dynamicColor = Theme.of(context).colorScheme;
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Container(
              width: _width,
              alignment: Alignment.center,
              child: VariableText(
                value: channelId,
                size: 35,
                wght: 900,
                wdth: 100,
                color: dynamicColor.primary,
              )),
          Container(
              width: _width,
              padding: const EdgeInsets.only(right: 10),
              alignment: Alignment.topRight,
              child: VariableText(
                value: "총 ~ 건",
                size: 11,
                wght: 900,
                wdth: 100,
                color: dynamicColor.onSurface,
              )),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: _height * 0.7,
            width: _width * 0.9,
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          width: _width * 0.8,
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(channelImageDataList[index]
                                  .imagePath), // 이미지 파일 경로
                              fit: BoxFit.fitHeight, // 이미지 채우는 방법
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          child: Center(child: Text('Elevated Card $index')),
                        ),
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
