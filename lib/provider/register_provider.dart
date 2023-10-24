import 'package:chatsy/routes/route_names.dart';
import 'package:chatsy/services/firebase_storage_services.dart';
import 'package:chatsy/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class registerProvider extends ChangeNotifier {
  late String url;
  final _image = ImagePicker();
  late XFile? image;
  File? fileImage;
  bool isLoading = false;

  Future uploadData(String name, String description, String image,
      BuildContext context) async {
    try {
      await FirestoreServices().registerUser(name, description, image);
      Navigator.pushNamed(context, RouteName.homeRoute);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future uploadImg(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
      image = await _image.pickImage(source: ImageSource.gallery);
      fileImage = File(image!.path);
      url = await firebaseStorageServices().uploadImage(fileImage);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));

      notifyListeners();
    }
  }
}
