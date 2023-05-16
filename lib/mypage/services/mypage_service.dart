import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyPageScreen extends StatefulWidget {
  final String accessToken;

  MyPageScreen({required this.accessToken});

  @override
  _MyPageScreenState createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  late Future<Map<String, dynamic>> _fetchMyPageInfo;

  @override
  void initState() {
    super.initState();

    _fetchMyPageInfo = _fetchMyPageInfoFromApi();
  }

  Future<Map<String, dynamic>> _fetchMyPageInfoFromApi() async {
    String apiUrl = "http://petmily.duckdns.org/user/info";

    Map<String, String> headers = {
      'Authorization': 'Bearer ${widget.accessToken}',
    };

    http.Response response =
        await http.get(Uri.parse(apiUrl), headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
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
                      'Name: ${myPageInfo['name']}',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Email: ${myPageInfo['email']}',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Phone: ${myPageInfo['phone']}',
                      style: TextStyle(fontSize: 18.0),
                    ),
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
