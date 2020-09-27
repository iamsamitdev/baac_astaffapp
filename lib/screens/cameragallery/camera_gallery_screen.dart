
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraGalleryScreen extends StatefulWidget {
  CameraGalleryScreen({Key key}) : super(key: key);

  @override
  _CameraGalleryScreenState createState() => _CameraGalleryScreenState();
}

class _CameraGalleryScreenState extends State<CameraGalleryScreen> {

  File _imageFile;
  final picker = ImagePicker();

  _openGallery(BuildContext context) async{
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });

    Navigator.of(context).pop();

  }

  _openCamera(BuildContext context) async{
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });

    Navigator.of(context).pop();

  }


  // ตัวอย่างแสดงเป็น popup
  Future<void> _showChoiceDialog(BuildContext context){
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Please Select Image'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: Text('Gallery'),
                  onTap: () {
                    _openGallery(context);
                  },
                ),
                 SizedBox(height: 10,),
                 GestureDetector(
                  child: Text('Camera'),
                  onTap: () {
                    _openCamera(context);
                  },
                )
              ],
            ),
          ),
        );
      });
  }

  // ตัวอย่างแสดงเป็น bottom sheet
  Future<void> _showChoiceBottomSheet(BuildContext context){
    return showModalBottomSheet(
      context: context, 
      builder: (BuildContext context){
        return Container(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_album),
                title: Text('Gallery'),
                onTap: (){
                  _openGallery(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: (){
                  _openCamera(context);
                },
              )
            ],
          ),
        );
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera and Upload'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _imageFile == null ? Text('No Image Selected!') : Image.file(_imageFile, width: 400, height: 400,),
              RaisedButton(
                onPressed: (){
                  _showChoiceBottomSheet(context);
                },
                child: Text("Select Image", style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}