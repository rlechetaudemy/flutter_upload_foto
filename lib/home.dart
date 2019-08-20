import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_upload_foto/upload_service.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teste Upload"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.file_upload),onPressed: _onClickUpload,)
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Tire uma Foto',
            ),
            SizedBox(
              height: 20,
            ),
            file != null
                ? Image.file(file)
                : Icon(
                    Icons.not_interested,
                    size: 40,
                    color: Colors.red,
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onClickFoto,
        child: Icon(Icons.camera),
      ),
    );
  }

  void _onClickFoto() async {
    File f = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      this.file = f;
    });
  }

  void _onClickUpload() async {
    if(file != null) {
      String url = await UploadService.upload(file);
      print("URL: $url");
    }
  }
}
