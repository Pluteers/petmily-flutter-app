import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamicColor = Theme.of(context).colorScheme;
    List<ImageData> imageDataList = [
      ImageData(
        imagePath: "assets/images/test.webp",
        name: "Image 1",
        description: "This is the first image.",
      ),
    ];
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
          ),
          children: imageDataList.map((imageData) {
            return Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.asset(imageData.imagePath),
                  const SizedBox(height: 8.0),
                  Text(imageData.name),
                  Text(imageData.description),
                ],
              ),
            );
          }).toList(),
        ),
      )),
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
