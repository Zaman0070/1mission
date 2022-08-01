import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../provider/cat_provider.dart';

class ImagePickerMotor extends StatefulWidget {
  @override
  State<ImagePickerMotor> createState() => _ImagePickerMotorState();
}

class _ImagePickerMotorState extends State<ImagePickerMotor> {
  File _image;
  bool uploading = false;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<CategoryProvider>(context);

    /// upload image

    Future<String> uploadFile() async {
      File file = File(_image.path);

      String imageName =
          'productImage/${DateTime.now().microsecondsSinceEpoch}';
      String downloadUrl;

      try {
        await FirebaseStorage.instance.ref(imageName).putFile(file);

        downloadUrl =
        await FirebaseStorage.instance.ref(imageName).getDownloadURL();

        // if (downloadUrl != null) {
        //   setState(() {
        //     _image = null;
        //     _provider.getImage(downloadUrl);
        //   });
        // }
      } on FirebaseException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cancelled')),
        );
      }
      return downloadUrl;
    }

    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            title: Text(
              translate('uploadImage'),
              style: TextStyle(color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    if (_image != null)
                      Positioned(
                        right: 0,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _image = null;
                            });
                          },
                          icon: Icon(Icons.clear),
                        ),
                      ),
                    Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      child: FittedBox(
                        child: _image == null
                            ? Icon(
                          CupertinoIcons.photo_on_rectangle,
                          color: Colors.grey,
                        )
                            : Image.file(_image),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                if (_provider.urlList.isNotEmpty)
                  Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: GalleryImage(
                        imageUrls: _provider.urlList,
                      )),
                if (_image != null)
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            /// save and upload file to firebase storage,
                            setState(() {
                              uploading = true;
                              uploadFile().then((url) {
                                if (url != null) {
                                  setState(() {
                                    uploading = false;
                                  });
                                }
                              });
                            });
                          },
                          child: Container(
                            height: 35,
                            decoration: BoxDecoration(
                              color: Colors.green.shade300,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: Text(
                                translate('save'),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _image = null;
                            });
                          },
                          child: Container(
                            height: 35,
                            decoration: BoxDecoration(
                              color: Colors.red.shade300,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: Text(
                                translate('cancel'),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: getImage,
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        _provider.urlList.isNotEmpty
                            ? translate('uploadMoreImage')
                            : translate('uploadImage'),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (uploading)
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
