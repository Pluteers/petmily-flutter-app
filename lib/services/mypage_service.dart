import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyPageScreen extends StatefulWidget {
  @override
  _MyPageScreenState createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  late Future<Map<String, dynamic>> _fetchMyPageInfo;
  late String _accessToken;

  @override
  void initState() {
    super.initState();

    getToken().then((String? token) {
      if (token != null) {
        setState(() {
          _accessToken = token;
          _fetchMyPageInfo = _fetchMyPageInfoFromApi();
        });
      }
    });
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Map<String, dynamic>> _fetchMyPageInfoFromApi() async {
    String apiUrl = "http://petmily.duckdns.org/user/info";

    Map<String, String> headers = {
      'Authorization': 'Bearer $_accessToken',
    };

    http.Response response =
        await http.get(Uri.parse(apiUrl), headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      log("마이페이지에러 ${response.bodyBytes}");
      throw Exception('Failed to fetch data from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Page'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchMyPageInfo,
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Map<String, dynamic> myPageInfo = snapshot.data!;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Name: ${myPageInfo['email']}',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Email: ${myPageInfo['nickname']}',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Failed to fetch data from API'),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

// import 'dart:convert';
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class MyPageScreen extends StatefulWidget {
//   final String accessToken;

//   MyPageScreen({required this.accessToken});

//   @override
//   _MyPageScreenState createState() => _MyPageScreenState();
// }

// class _MyPageScreenState extends State<MyPageScreen> {
//   late Future<Map<String, dynamic>> _fetchMyPageInfo;

//   @override
//   void initState() {
//     super.initState();

//     _fetchMyPageInfo = _fetchMyPageInfoFromApi();
//   }

//   Future<Map<String, dynamic>> _fetchMyPageInfoFromApi() async {
//     String apiUrl = "http://petmily.duckdns.org/user/info";

//     Map<String, String> headers = {
//       'Authorization':
//           'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTY4NjA0MjgzOSwiZW1haWwiOiJ0ZXN0NEBuYXZlci5jb20ifQ.svOFWFpDQvIT0XPqf4D5fvBFIqULVE5hL_LaaNl3bC1AQ103lz9xtCofr_kbufXMi7CbNtyPG9feEOTUTbLIsw',
//     };

//     http.Response response =
//         await http.get(Uri.parse(apiUrl), headers: headers);

//     if (response.statusCode == 200) {
//       Map<String, dynamic> data = json.decode(response.body);
//       return data;
//     } else {
//       log("마이페이지에러 ${response.bodyBytes}");
//       throw Exception('Failed to fetch data from API');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Page'),
//       ),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: _fetchMyPageInfo,
//         builder: (BuildContext context,
//             AsyncSnapshot<Map<String, dynamic>> snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasData) {
//               Map<String, dynamic> myPageInfo = snapshot.data!;
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Text(
//                       'Name: ${myPageInfo['email']}',
//                       style: TextStyle(fontSize: 18.0),
//                     ),
//                     SizedBox(height: 10.0),
//                     Text(
//                       'Email: ${myPageInfo['nickname']}',
//                       style: TextStyle(fontSize: 18.0),
//                     ),
//                     SizedBox(height: 10.0),
//                   ],
//                 ),
//               );
//             } else if (snapshot.hasError) {
//               return Center(
//                 child: Text('Failed to fetch data from API'),
//               );
//             } else {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//           } else {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

