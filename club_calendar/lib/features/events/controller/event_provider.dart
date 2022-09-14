import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/event_model.dart';

class EventsProvider with ChangeNotifier {
  Future<List<Event?>> fetchUpcomingEvents() async {
    print("in fetch upcoming");
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('events').get();
    List<Event?> upcomingEvents = snapshot.docs.map((d) {
      print('await done in docs');
      if (d["eventEndDate"].toDate().compareTo(DateTime.now()) >= 0) {
        print("present event");
        return Event(
          eventId: d["eventId"],
          eventDescription: d["eventDescription"],
          eventDuration: d["eventDuration"],
          eventEndDate: d["eventEndDate"].toDate(),
          eventLocation: d["eventLocation"],
          eventName: d["eventName"],
          eventPrizeMoney: d["eventPrizeMoney"],
          eventPrizes: d["eventPrizes"],
          eventRecordings: d["eventRecordings"],
          eventSpeakers: d["eventSpeakers"],
          eventStartDate: d["eventStartDate"].toDate()
        );
      }
    }).toList();
    return upcomingEvents;
  }
  Future<List<Event?>> fetchPastEvents() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('events').get();
    List<Event?> pastEvents = snapshot.docs.map((d) {
      //print(d["startDate"].toDate().compareTo(DateTime.now()));
      if (d["eventEndDate"].toDate().compareTo(DateTime.now()) <0) {
        print("past event");
        return Event(
          eventId: d["eventId"],
          eventDescription: d["eventDescription"],
          eventDuration: d["eventDuration"],
          eventEndDate: d["eventEndDate"].toDate(),
          eventLocation: d["eventLocation"],
          eventName: d["eventName"],
          eventPrizeMoney: d["eventPrizeMoney"],
          eventPrizes: d["eventPrizes"],
          eventRecordings: d["eventRecordings"],
          eventSpeakers: d["eventSpeakers"],
          eventStartDate: d["eventStartDate"].toDate()
        );
      }
    }).toList();
    return pastEvents;
  }
}
