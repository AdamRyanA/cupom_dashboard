import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart';
import 'package:image_picker/image_picker.dart';

class PickerImage {

  static Future<Uint8List?> getImage(String origemImagem) async {
    final picker = ImagePicker();
    try {
      XFile? pickedFile;
      switch (origemImagem) {
        case "camera":
          pickedFile = await picker.pickImage(source: ImageSource.camera, imageQuality: 100, maxHeight: 1920, maxWidth: 1080);
          break;
        case "galeria":
          pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 100, maxHeight: 1920, maxWidth: 1080);
          break;
      }
      if (pickedFile != null) {
        Uint8List fileUint8List = await pickedFile.readAsBytes();
        return fileUint8List;
      } else {
        if (kDebugMode) {
          print("No picture");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("ERRO: $e");
      }
    }
    return null;
  }

  static  Future<Uint8List?> getImageMac() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        allowedExtensions: ['jpg', 'png', 'jpeg']
    );
    if (result != null) {
      PlatformFile pickedFile = result.files.first;
      if (pickedFile.name.endsWith(".jpg") || pickedFile.name.endsWith(".jpeg") || pickedFile.name.endsWith(".png")) {
        File file = File("${pickedFile.path}");
        Uint8List fileUint8List = file.readAsBytesSync();
        Image? image = decodeImage(fileUint8List);
        if (image != null) {
          int sizeWidth = image.data!.width;
          int sizeHeight = image.data!.height;
          Image resized = copyResize(image,
              height: sizeHeight > 1920
                  ? 1920 : sizeHeight,
              width: sizeWidth > 1080
                  ? 1080
                  : sizeWidth
          );
          fileUint8List = encodeJpg(resized);
        }
        return fileUint8List;
      }else{
        if (kDebugMode) {
          print("Not a image");
        }
      }
    } else {
      if (kDebugMode) {
        print("No picture");
      }
    }
    return null;
  }

  static Future<Uint8List> loadImageFromNetwork(String imageUrl) async {
    try {
      final response = await Dio().get<List<int>>(
        imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      return Uint8List.fromList(response.data!);
    } catch (e) {
      throw Exception('Failed to load image: $e');
    }
  }

  static Future<List<Uint8List>> loadImagesFromNetwork(List<String>? images) async {
    List<Uint8List> result = [];
    if (images != null) {
      for (var value in images) {
        try {
          final response = await Dio().get<List<int>>(
            value,
            options: Options(responseType: ResponseType.bytes),
          );

          Uint8List uint8list = Uint8List.fromList(response.data!);
          result.add(uint8list);
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }
        }
      }
    }
    return result;
  }

  static String convertUint8ListToBase64(Uint8List data) {
    // Encode the Uint8List to Base64
    String base64String = base64Encode(data);
    return base64String;
  }
}