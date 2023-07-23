import 'dart:html';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_calendar/features/admin/events/view/widgets/admin_drawer.dart';
import 'package:club_calendar/features/admin/events/view/widgets/image_input.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/foundation.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';


import 'package:firebase_storage/firebase_storage.dart';

import '../../../../../styles.dart';

class edit extends StatefulWidget {
  const edit({Key? key}) : super(key: key);

  @override
  State<edit> createState() => _editState();
}

class _editState extends State<edit> {
  TextEditingController sampledata1= TextEditingController();
  TextEditingController sampledata2=TextEditingController();
  TextEditingController sampledata3=TextEditingController();
  TextEditingController sampledata4=TextEditingController();
  TextEditingController sampledata5=TextEditingController();
  TextEditingController sampledata6=TextEditingController();
  TextEditingController sampledata7=TextEditingController();
  TextEditingController sampledata8=TextEditingController();
  TextEditingController sampledata9=TextEditingController();
  TextEditingController sampledata10=TextEditingController();
  TextEditingController sampledata11=TextEditingController();
  TextEditingController sampledata12=TextEditingController();
  final auth=FirebaseAuth.instance;
  final ref =FirebaseFirestore.instance.collection("events");


  @override
  Styles styles = Styles();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:AppBar(
        title: Text("edit event"),

      ),

        body: Container(


         child: TextFormField(
          initialValue:event.,
          decoration: InputDecoration(
              labelText: 'Event ID',
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: const Icon(
                Icons.event_rounded,
                size: 18,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade200,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              floatingLabelStyle: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.blue,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(10),
              )),
        ),

        ),

    );
  }
}
