
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
class ImagePickerController extends GetxController {
  RxString imgPath = "".obs;
  String base64Image = "";
  Future<void> getImage(ImageSource source) async {
    ImagePicker imgPicker = ImagePicker();
    if(source == null) {
      Get.snackbar("Error", "Please select Image", backgroundColor: Colors.white);
    } else {
      try {
        final imgSource = await imgPicker.pickImage(source: source);
        imgPath.value = imgSource!.path.toString();
        File file = File(imgSource!.path);
        Uint8List bytes = file.readAsBytesSync();
        base64Image = base64Encode(bytes);
      } catch (e) {
        print(e.toString());
      }
    }
  }
}