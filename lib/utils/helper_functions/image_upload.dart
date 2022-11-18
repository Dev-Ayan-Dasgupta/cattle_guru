import 'dart:io';

import 'package:cattle_guru/utils/helper_functions/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload {
  static Future<File?> pickImage(BuildContext context, ImageSource source, Future<File?> Function(File file) cropImage) async {
    File? image;
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
    if(pickedImage != null){
      image = File(pickedImage.path);
      
    }
    } on PlatformException catch (e) {
      ShowSnackbar.showSnackBar(context, e.message!);
    }
    return cropImage(image!);
  }
}