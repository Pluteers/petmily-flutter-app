import 'package:flutter/material.dart';
import 'package:petmily/providers/get_channel.dart';
import 'package:petmily/screens/channel.dart';

import 'package:petmily/widgets/variable_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamicColor = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

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
          HomeGrideView(),
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
          getChannel();
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

// 메인화면 그리드 뷰
class HomeGrideView extends StatefulWidget {
  const HomeGrideView({super.key});

  @override
  State<HomeGrideView> createState() => _HomeGrideViewState();
}

class _HomeGrideViewState extends State<HomeGrideView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final dynamicColor = Theme.of(context).colorScheme;

    return SizedBox(
      width: width * .9,
      height: height * 0.7,
      child: FutureBuilder(
          future: getChannel(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return GridView.builder(
                itemCount: snapshot.data!.data!.length,
                itemBuilder: (context, index) {
                  var channelTitle = snapshot.data!.data![index].channelName;
                  var channelId = snapshot.data!.data![index].channelId;
                  return Container(
                    decoration: BoxDecoration(
                        color: dynamicColor.primaryContainer,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Container(
                              width: width,
                              height: 50,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: dynamicColor.primary,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  )),
                              child: VariableText(
                                value: "$channelTitle",
                                size: 18,
                                color: dynamicColor.onPrimary,
                                wght: 500,
                              )),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChannelScreen(
                                          channelId: channelId,
                                        )));
                          },
                        ),
                      ],
                    ),
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                  childAspectRatio: 1 / 1.3, //item 의 가로 1, 세로 1.5 의 비율
                  mainAxisSpacing: 10, //수평 Padding
                  crossAxisSpacing: 10, //수직 Padding
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
