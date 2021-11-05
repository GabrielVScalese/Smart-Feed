import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

class ImageUploader {
  static uploadImage(File imgFile) async {
    String clientID = '2f7307ddc860abf';

    String image64 = base64Encode(await imgFile.readAsBytes());

    var dio = Dio();
    var response = await dio.post('https://api.imgur.com/3/image',
        data: {'image': image64},
        options: Options(headers: {
          'Authorization': 'Client-ID $clientID',
          'Content-Type': "application/json"
        }));

    return response.data['data']['link'];
  }
}
