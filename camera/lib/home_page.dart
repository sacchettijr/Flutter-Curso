import 'dart:io';

import 'package:camera/upload_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File _file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Hello Camera",
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.file_upload,
              color: Colors.white,
            ),
            onPressed: _onClickUpload,
          )
        ],
      ),
      body: _body(),
      floatingActionButton: _floatingActionButton(),
    );
  }

  _body() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Tire uma foto",
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          _file != null
              ? Image.file(
                  _file,
                )
              : Image.asset(
                  "assets/img/camera.png",
                  width: 140,
                ),
        ],
      ),
    );
  }

  _floatingActionButton() {
    return FloatingActionButton(
      onPressed: _onClickCamera,
      tooltip: "Camera",
      child: Icon(
        Icons.camera,
      ),
    );
  }

  void _onClickCamera() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );

    print(image);

    setState(() {
      this._file = image;
    });
  }

  void _onClickUpload() {
    if (_file != null) {
      UploadService.upload(_file);
    }
  }
}
