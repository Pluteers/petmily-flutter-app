import 'package:flutter/material.dart';

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
        name: "Image 1",
        description: "This is the first image.",
      ),
      ImageData(
        imagePath: "assets/images/image1.png",
        name: "Image 1",
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
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: dynamicColor.error, width: 1)),
                  child: Column(
                    children: [
                      Container(
                          alignment: Alignment.topLeft,
                          height: _height * 0.15,
                          decoration: BoxDecoration(),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(imageDataList[index].name),
                          )),
                      Text(imageDataList[index].description),
                    ],
                  ),
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
