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
              margin: const EdgeInsets.only(left: 20),
              width: _width,
              alignment: Alignment.topLeft,
              child: VariableText(
                value: channelId,
                size: 40,
                wght: 300,
                color: dynamicColor.primary,
              )),
          Container(
              width: _width,
              padding: const EdgeInsets.only(left: 20),
              alignment: Alignment.topLeft,
              child: VariableText(
                value: "총 ${channelImageDataList.length} 건",
                size: 14,
                wght: 300,
                color: dynamicColor.onSurface,
              )),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: _height * 0.7,
            width: _width,
            child: ListView.builder(
                itemCount: channelImageDataList.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(10),
                    color: dynamicColor
                        .surfaceVariant, //? figma surface-container 라고 되어 있는데 dynamicColor에 없는듯
                    elevation: 0,
                    child: Column(
                      children: [
                        Container(
                            width: _width,
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(left: 10, top: 10),
                            child: Row(
                              children: [
                                const Icon(Icons.person),
                                Text('User Id $index'),
                              ],
                            )),
                        Container(
                          margin: const EdgeInsets.all(10),
                          alignment: Alignment.centerLeft,
                          width: _width,
                          height: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              // alignment: Alignment.topLeft,
                              image: AssetImage(channelImageDataList[index]
                                  .imagePath), // 이미지 파일 경로
                              fit: BoxFit.fitHeight, // 이미지 채우는 방법
                            ),
                          ),
                        ),
                        Container(
                          width: _width,
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(left: 10, bottom: 10),
                          child: Text('Elevated Card Title $index'),
                        ),
                        Container(
                          width: _width,
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(left: 10, bottom: 10),
                          child: Text('Elevated Card SubTitle $index'),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: const [
                              Expanded(
                                flex: 2,
                                child: SizedBox(),
                              ),
                              Expanded(
                                child: Text("Favorites"),
                              ),
                              Expanded(
                                child: Text("Comments"),
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
