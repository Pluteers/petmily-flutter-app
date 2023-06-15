import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:petmily/providers/get_channel.dart';
import 'package:petmily/screens/chat/chat_screen.dart';
import 'package:petmily/screens/mypage_screens.dart';
import 'package:petmily/screens/post/post_list.dart';
import 'package:petmily/widgets/snackbar_widget.dart';

import 'package:petmily/widgets/variable_text.dart';

import 'package:petmily/providers/post_channel.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final dynamicColor = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Container(
            width: width,
            height: 80,
            alignment: Alignment.centerLeft,
            child: VariableText(
              value: "채널",
              color: dynamicColor.primary,
              size: 40.0,
              wght: 300.0,
            ),
          ),
        ),
      ),
      backgroundColor: dynamicColor.background,
      body: const HomeGrideView(),
      bottomNavigationBar: BottomAppBar(
        height: 80,
        color: dynamicColor.surfaceVariant,
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.person,
                size: 30,
                color: dynamicColor.primary,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyPageScreen()));
              },
            ),
            IconButton(
              icon: FaIcon(
                FontAwesomeIcons.comment,
                color: dynamicColor.primary,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChatScreen()));
              },
            ),
            // IconButton(
            //   icon: FaIcon(
            //     FontAwesomeIcons.search,
            //     color: dynamicColor.primary,
            //   ),
            //   onPressed: () {
            //     // showSearch(context: context, delegate: searchBar());
            //   },
            // ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: FloatingActionButton(
        backgroundColor: dynamicColor.secondary,
        elevation: 0,
        onPressed: () {
          addChannel(context, dynamicColor); //카테고리 추가
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

/**검색 기능 */
// class searchBar extends SearchDelegate {
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     // TODO: implement buildActions
//     IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () => close(context, null),
//     );
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     // TODO: implement buildLeading
//     throw UnimplementedError();
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     // TODO: implement buildResults
//     throw UnimplementedError();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // TODO: implement buildSuggestions
//     throw UnimplementedError();
//   }
// }

/**카테고리 추가 메소드 */
void addChannel(_, dynamicColor) async {
  String selectedDropdown = "1";

  return await showDialog(
      context: _,
      builder: (_) {
        return AlertDialog(
          title: const VariableText(
            value: "채널 추가",
            size: 19,
            wght: 500,
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return SizedBox(
                height: 200,
                child: Column(
                  children: [
                    TextFormField(
                      controller: PostChannel.channelTitleController,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: '채널 제목',
                        labelStyle:
                            TextStyle(color: dynamicColor.onSecondaryContainer),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            PostChannel.channelTitleController.clear();
                          },
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                width: 1,
                                color: dynamicColor.onSecondaryContainer)),
                      ),
                    ),
                    Row(
                      children: [
                        const Expanded(
                            child: VariableText(
                          value: "카테고리",
                          size: 15,
                          wght: 300,
                        )),
                        Expanded(
                          child: DropdownButton(
                            value: selectedDropdown,
                            onChanged: (value) {
                              setState(() {
                                selectedDropdown = value!;
                              });
                            },
                            items: const [
                              DropdownMenuItem(
                                value: "1",
                                child: VariableText(
                                  value: "강아지 일상",
                                  size: 15,
                                  wght: 300,
                                ),
                              ),
                              DropdownMenuItem(
                                value: "2",
                                child: VariableText(
                                  value: "고양이 일상",
                                  size: 15,
                                  wght: 300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(
                onPressed: () {
                  PostChannel.postChannel(selectedDropdown);
                  Navigator.pop(_);

                  snackBar(_, "채널 추가 성공!");
                },
                child: const Text('채널 추가')),
            TextButton(
                onPressed: () {
                  Navigator.pop(_);
                },
                child: const Text('취소'))
          ],
        );
      });
}

// 메인화면 그리드 뷰
class HomeGrideView extends StatefulWidget {
  const HomeGrideView({super.key});

  @override
  State<HomeGrideView> createState() => _HomeGrideViewState();
}

class _HomeGrideViewState extends State<HomeGrideView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final dynamicColor = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: width,
        child: FutureBuilder(
            future: GetChannelData().getChannel(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return GridView.builder(
                  itemCount: snapshot.data!.data!.length,
                  itemBuilder: (context, index) {
                    var channelTitle = snapshot.data!.data![index].channelName;
                    var channelId = snapshot.data!.data![index].channelId;
                    var categoryId = snapshot.data!.data![index].categoryId;
                    return InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                            color: dynamicColor.primaryContainer,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
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
                            ),
                            categoryId == 1
                                ? Expanded(
                                    flex: 2,
                                    child: Lottie.network(
                                        "https://assets9.lottiefiles.com/packages/lf20_syqnfe7c.json"),
                                  )
                                : Expanded(
                                    flex: 2,
                                    child: Lottie.network(
                                        "https://assets4.lottiefiles.com/packages/lf20_OT15QW.json"),
                                  )
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChannelScreen(
                                      channelId: channelId,
                                      channelTitle: channelTitle,
                                    )));
                      },
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                    childAspectRatio: 2 / 2.5, //item 의 가로 1, 세로 1.5 의 비율
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
      ),
    );
  }
}
