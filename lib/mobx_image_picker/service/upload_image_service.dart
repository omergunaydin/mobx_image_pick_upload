import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageUploadService {
  ImageUploadService();

  Future<UploadTask> uploadFile(PlatformFile? pickedFile, UploadTask? uploadTask) async {
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    return uploadTask;
  }
}
