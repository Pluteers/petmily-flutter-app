// //http://petmily.duckdns.org/image/upload
import 'dart:convert';
import 'dart:developer';
// import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

final dio = Dio();

class UploadImage {
  static Future<void> uploadImage(List<Asset> files) async {
    var accessToken =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTY4NjA0MjgzOSwiZW1haWwiOiJ0ZXN0NEBuYXZlci5jb20ifQ.svOFWFpDQvIT0XPqf4D5fvBFIqULVE5hL_LaaNl3bC1AQ103lz9xtCofr_kbufXMi7CbNtyPG9feEOTUTbLIsw";
    // var headers = {'Authorization': 'Bearer $accessToken'};
    // var request = http.MultipartRequest(
    //     'POST', Uri.parse('http://petmily.duckdns.org/image/upload'));

    // request.files.add(await http.MultipartFile.fromPath('image', file,
    //     filename: '$file.jpg',
    //     contentType: MediaType.parse('multipart/form-data')));
    // // request.files.add(await http.MultipartFile('imgae',input,filename: '$input',contentType: MediaType.parse('multipart/form-data')));
    // request.headers.addAll(headers);
    // FormData formData = FormData.fromMap({
    //   "key": await MultipartFile.fromFile(
    //     file,
    //   ),
    // });
    // var response = await dio.post("http://petmily.duckdns.org/image/upload",
    //     options: Options(
    //       headers: {
    //         'Authorization': 'Bearer $accessToken',
    //       },
    //     ),
    //     data: formData);
    // Future getImage() async {
    //   XFile? _image;
    //   final picker = ImagePicker();

    //   var _pickedFile = await picker.pickImage(
    //       source: ImageSource.camera,
    //       imageQuality: 50, // <- Reduce Image quality
    //       maxHeight: 500, // <- reduce the image size
    //       maxWidth: 500);
    //   if (_pickedFile != null) {
    //     _image = _pickedFile;
    //     return _image;
    //   } else {
    //     log('Image File Faile');
    //   }
    // }

    // final responseData = response.data;
    // var resData = responseData;
    // log('channelPostSuccess : $resData');
    //   Dio dio = Dio();
    //   FormData formData = FormData();

    //   for (int i = 0; i < files.length; i++) {
    //     var asset = files[i];
    //     XFile xFile = await convertAssetToXFile(asset);

    //     List<int> imageData = await xFile.readAsBytes();
    //     String fileName = path.basename(xFile.path);

    //     formData.files.add(MapEntry(
    //       'image$i',
    //       MultipartFile.fromBytes(
    //         imageData,
    //         filename: fileName,
    //       ),
    //     //   FormData.fromMap({
    //     //   "key":  MultipartFile.fromBytes(
    //     //     imageData,
    //     //   ),
    //     // })
    //     ));
    //     // FormData formData =

    //     // });
    //   }

    //   try {
    //     final response = await dio.post(
    //       "http://petmily.duckdns.org/image/upload",
    //       options: Options(
    //           headers: {
    //             'Authorization': 'Bearer $accessToken',
    //           },
    //           followRedirects: false,
    //           validateStatus: (status) {
    //             return status! < 500;
    //           }),
    //       data: formData,
    //     );

    //     // Handle response here
    //     log(jsonEncode(response.data));
    //   } catch (error) {
    //     // Handle error here
    //     log("UpLoad Error : ${error.toString()}");
    //   }
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://petmily.duckdns.org/image/upload'));
    for (int i = 0; i < files.length; i++) {
      var asset = files[i];
      XFile xFile = await convertAssetToXFile(asset);
      request.files.add(await http.MultipartFile.fromPath('file', xFile.path));

      // List<int> imageData = await xFile.readAsBytes();
      // String fileName = path.basename(xFile.path);
    }

    var headers = {'Authorization': 'Bearer $accessToken'};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      log(await response.stream.bytesToString());
    } else {
      log("${response.reasonPhrase}");
    }
  }
}

Future<XFile> convertAssetToXFile(Asset asset) async {
  final byteData = await asset.getByteData(); // Asset의 바이트 데이터 가져오기
  final tempDir = await getTemporaryDirectory(); // 임시 디렉토리 가져오기
  final filePath = path.join(tempDir.path, asset.name); // 파일 경로 생성
  final file = await File(filePath)
      .writeAsBytes(byteData.buffer.asUint8List()); // 파일로 저장

  return XFile(file.path); // XFile로 변환하여 반환
}
