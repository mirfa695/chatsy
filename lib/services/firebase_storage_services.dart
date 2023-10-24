import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class firebaseStorageServices {
  final _fireStorage = FirebaseStorage.instance;

  Future<String> uploadImage(File? image) async {
    // await Permission.photos.request();
    // var permissionStatus=await Permission.photos.status;
    // if(permissionStatus.isGranted){
    //   image=(await _image.pickImage(source: ImageSource.gallery));
    //   var file=File(image!.path);
    if (image != null) {
      String download = '';
      String uniqueName = DateTime.now().microsecondsSinceEpoch.toString();
      var snapshot = await _fireStorage.ref().child('/image/imageName');
      Reference reference = snapshot.child(uniqueName);
      await reference.putFile(image).whenComplete(() async {
        download = await reference.getDownloadURL();
      });
      return download;
    } else {
      throw ('error');
    }
  }
}
