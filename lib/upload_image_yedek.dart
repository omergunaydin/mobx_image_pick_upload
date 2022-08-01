import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UploadImageYedekView extends StatefulWidget {
  UploadImageYedekView({Key? key}) : super(key: key);

  @override
  State<UploadImageYedekView> createState() => _UploadImageYedekViewState();
}

class _UploadImageYedekViewState extends State<UploadImageYedekView> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  bool isSelected = false;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'jpeg', 'png', 'gif']);
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
      isSelected = true;
    });
  }

  Future<void> uploadFile() async {
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() => {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link : $urlDownload');

    setState(() {
      uploadTask = null;
    });
  }

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
                child: Container(
                    height: 400,
                    width: 400,
                    color: const Color.fromARGB(153, 232, 232, 232),
                    child: pickedFile != null
                        ? InkWell(
                            onTap: selectFile,
                            child: Image.file(
                              File(pickedFile!.path!),
                              fit: BoxFit.cover,
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              selectFile();
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
                          )),
              ),
              isSelected
                  ? ElevatedButton(
                      onPressed: () {
                        //upload process
                        uploadFile();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text('Upload Image  '),
                          Icon(Icons.upload_file),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              StreamBuilder<TaskSnapshot>(
                stream: uploadTask?.snapshotEvents,
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
                                style: TextStyle(color: Colors.white),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
