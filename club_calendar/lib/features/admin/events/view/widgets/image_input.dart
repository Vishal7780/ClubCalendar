import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPath;
import 'package:firebase_storage/firebase_storage.dart';
class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput( {required this.onSelectImage});

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {

  File? _storedImage;

  Future<void> _takePicture()async{
    final imageFile =  await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 600 );
    setState(() {
      _storedImage = File(imageFile!.path);
    });

    if(imageFile==null){
      return;
    }

    final appDir = await sysPath.getApplicationDocumentsDirectory();
    final filename = path.basename(imageFile.path);

    final savedImage = await File(imageFile.path).copy('${appDir.path}/$filename');

    widget.onSelectImage(savedImage);


  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Container(
            width: 200, height: 60,
            decoration: BoxDecoration(border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(20)

            ),

            child: _storedImage !=null ? Image.file(_storedImage!,
              fit: BoxFit.cover, width: double.infinity,)
                : Text('No Image Taken',textAlign: TextAlign.center,),
          alignment: Alignment.center,
          ),
          const SizedBox(height: 60,),
          const SizedBox(width: 1.6,),

          Expanded(

              child: ElevatedButton(

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Add Poster'),
                    Icon(Icons.image),

                  ],
                ),


                  onPressed: _takePicture,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                        textStyle: TextStyle(fontSize: 8,fontWeight: FontWeight.bold),
                      elevation: 8,
                      shadowColor: Colors.grey,
                      alignment: Alignment.center,
                      shape: StadiumBorder(),



                    ),



              )
          )
        ],
      ),
    );
  }
}