

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../styles.dart';

Widget customTile(
    {required String dayName,

    required String day,
    required String eventName,
    required String duration}) {
  final styles = Styles();
  int index;

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
  return Padding(
    padding: const EdgeInsets.all(15),
    child: Card(
        color: Colors.black12,
        elevation: 5.0,
        child: Container(
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
  );
}
