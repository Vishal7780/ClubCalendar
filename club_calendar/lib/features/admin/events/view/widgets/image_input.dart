import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPath;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:club_calendar/styles.dart';
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
    return GestureDetector(
      onTap: (){
        _takePicture();
      },
      child: Row(

        children: [

            Container(


              height: 200,
              width: 370,


              decoration: BoxDecoration(border: Border.all(width: 2,
              color: Colors.white),


                borderRadius: BorderRadius.circular(10),



              ),

              child: _storedImage !=null ? Image.file(_storedImage!,
                fit: BoxFit.cover, width: double.infinity,)
                  : Text('Add Poster',textAlign: TextAlign.center,),
              alignment: Alignment.center,
            ),

          const SizedBox(height: 50,),
          const SizedBox(width: 1.6,),

          // Expanded(

              // child: ElevatedButton(
              //
              //   style: ButtonStyle(
              //
              //       backgroundColor:MaterialStateProperty.all(Styles.buttonColor),
              //
              //   ),
              //   child: Row(
              //
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text('Add Poster'),
              //       Icon(Icons.image),
              //
              //     ],
              //   ),
              //
              //
              //     onPressed: _takePicture,
              // ),
              //
              //
              //
              // )

        ],
      ),
    );
  }
}