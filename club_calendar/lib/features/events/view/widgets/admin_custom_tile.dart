
import 'package:club_calendar/features/admin/update/delete.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_calendar/features/admin/events/view/widgets/edit.dart';
import 'package:flutter/material.dart';

import '../../../../styles.dart';

import 'package:club_calendar/features/admin/events/view/Manage_events.dart';

final auth=FirebaseAuth.instance;
final editingController=TextEditingController();


CollectionReference ref=FirebaseFirestore.instance.collection('events');



Widget admincustomTile(

    {

      required String dayName,
      required String eventId,
      required String day,
      required String eventName,
      required String duration}) {
      final styles = Styles();



  final dateSection = Padding(
      padding: const EdgeInsets.all(10),

      child: Container(
        //margin: const EdgeInsets.all(40),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Styles.buttonColor)),
          child: Card(
            color: Colors.black12,
            child: Column(

              children: [


                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Text(day,
                      style: styles.cardHeadingStyle(
                        color: Styles.buttonColor,
                        fontWeight: FontWeight.w300,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: Text(dayName,
                      style: styles.cardDurationStyle(
                        color: Styles.buttonColor,
                        fontWeight: FontWeight.w300,
                      )),
                )
              ],
            ),
          )));
  final eventSection =Flexible(

    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(

            padding: const EdgeInsets.all(8.0),
            child: Text(eventName,

                style: styles.cardHeadingStyle()),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Text(duration,
                style: styles.cardDurationStyle()),
          )
        ],
      ),
    ),

  );

  return Slidable (
      key: const ValueKey(0),
    startActionPane: ActionPane(
      motion: const ScrollMotion(),
      dismissible: DismissiblePane(onDismissed: (){},),
      children: [
        SlidableAction(
        onPressed:(BuildContext ctx){DeleteDocument(eventId);
        },
      backgroundColor: const Color(0xFFFE4A49),
      foregroundColor: Colors.white,
      icon: Icons.delete,
      label: 'Delete',
    ),
        SlidableAction(
          onPressed:(BuildContext ctx) {
           Navigator.push(ctx, MaterialPageRoute(builder:(_)=> edit()));


        },
          backgroundColor: const Color(0xFF40C4FF),
          foregroundColor: Colors.white,
          icon: Icons.edit,
          label: 'Edit',
        ),


      ],
    ),


    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Card(
          color: Colors.black12,
          elevation: 5.0,
          child: SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dateSection,
                eventSection,
                //text_section
              ],
            ),
          )),
    ),
  );

}
void DeleteDocument(id) {
  FirebaseFirestore.instance.collection('events').doc(id).delete();
  Fluttertoast.showToast(msg: "Event deleted Successfully");

}