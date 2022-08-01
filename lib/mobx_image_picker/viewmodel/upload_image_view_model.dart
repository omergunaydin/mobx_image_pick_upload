import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_image_pick_upload/mobx_image_picker/service/upload_image_service.dart';
part 'upload_image_view_model.g.dart';

class UploadImageViewModel = _UploadImageViewModelBase with _$UploadImageViewModel;

abstract class _UploadImageViewModelBase with Store {
  @observable
  PlatformFile? pickedFile;
  @observable
  UploadTask? uploadTask;
  @observable
  bool isSelected = false;

  @action
  void filePicked(FilePickerResult? filePickerResult) {
    if (filePickerResult == null) return;
    pickedFile = filePickerResult.files.first;
    //print('Picked file : -->  $pickedFile');
    isSelected = true;
  }

  @action
  void uploadTaskPutFile(Reference ref, File file) {
    uploadTask = ref.putFile(file);
  }

  @action
  void uploadTaskNull() {
    uploadTask = null;
  }

  Future<void> selectFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'jpeg', 'png', 'gif']);
    filePicked(result);
  }

  @action
  Future<void> uploadImage() async {
    uploadTask = await ImageUploadService().uploadFile(pickedFile, uploadTask);

    final snapshot = await uploadTask!.whenComplete(() => {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    if (kDebugMode) {
      print('Download Link : $urlDownload');
    }
    uploadTaskNull();
  }
}
