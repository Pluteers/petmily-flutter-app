import 'dart:io';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();

class UploadImage {
  Future<String?> uploadImage(List<Asset> files) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('token');
    String? dataList;

    var request = http.MultipartRequest(
        'POST', Uri.parse('http://petmily.duckdns.org/image/upload'));
    for (int i = 0; i < files.length; i++) {
      var asset = files[i];
      XFile xFile = await convertAssetToXFile(asset);
      request.files.add(await http.MultipartFile.fromPath('file', xFile.path));
    }

    var headers = {'Authorization': 'Bearer $accessToken'};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      log("image upload$responseData");
      final Map<String, dynamic> json = jsonDecode(responseData);
      // uploadImageModel = UploadImageModel.fromJson(json);
      dataList = json['data'][0];

      log("이미지 패스 받아오는지 확인 ");
      return dataList;
    } else {
      log("${response.reasonPhrase}");
      return dataList;
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
