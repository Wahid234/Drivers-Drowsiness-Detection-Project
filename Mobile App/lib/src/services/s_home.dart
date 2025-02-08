import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:hather_app/src/models/user.dart';
import 'package:hather_app/src/utils/dio/dio_client.dart';
import 'package:hather_app/src/utils/local/preferences.dart';

class SHome {
  final DioClient _dioClient;

  SHome(this._dioClient);

  Future<Either> uploadImage(String imagePath) async {
    // Create FormData object to send the image
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(imagePath, filename: "image.jpeg"),
    });

    // Send POST request with FormData
    final either = await _dioClient.post("create", data: formData);

    return either;
  }
}
