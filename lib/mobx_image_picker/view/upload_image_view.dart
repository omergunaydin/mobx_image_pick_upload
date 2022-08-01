import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../viewmodel/upload_image_view_model.dart';

class UploadImageView extends StatefulWidget {
  UploadImageView({Key? key}) : super(key: key);

  @override
  State<UploadImageView> createState() => _UploadImageViewState();
}

class _UploadImageViewState extends State<UploadImageView> {
  final _uploadImageViewModel = UploadImageViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Uploader Demo'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Card(
                child: Observer(builder: (_) {
                  return Container(
                    height: 400,
                    width: 400,
                    color: const Color.fromARGB(153, 232, 232, 232),
                    child: _uploadImageViewModel.pickedFile != null
                        ? InkWell(
                            onTap: () {
                              _uploadImageViewModel.selectFile();
                            },
                            child: Image.file(
                              File(_uploadImageViewModel.pickedFile!.path!),
                              fit: BoxFit.cover,
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              _uploadImageViewModel.selectFile();
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Select Image  ',
                                  style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white),
                                ),
                                const Icon(Icons.upload_file),
                              ],
                            ),
                          ),
                  );
                }),
              ),
              Observer(builder: (_) {
                return _uploadImageViewModel.isSelected
                    ? ElevatedButton(
                        onPressed: () {
                          _uploadImageViewModel.uploadImage();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text('Upload Image  '),
                            Icon(Icons.upload_file),
                          ],
                        ),
                      )
                    : const SizedBox.shrink();
              }),
              Observer(builder: (_) {
                return StreamBuilder<TaskSnapshot>(
                  stream: _uploadImageViewModel.uploadTask?.snapshotEvents,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!;
                      double progress = data.bytesTransferred / data.totalBytes;
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: SizedBox(
                          height: 20,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              LinearProgressIndicator(
                                value: progress,
                                backgroundColor: Colors.grey,
                                color: Colors.blue,
                              ),
                              Center(
                                child: Text(
                                  '${(100 * progress).roundToDouble()}%',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
