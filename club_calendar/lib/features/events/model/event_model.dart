
// class Person{
//     String firstName;
//     String? lastName;

//     Person({required this.firstName, this.lastName});
// }
import 'package:flutter/foundation.dart';

class Event{
  String eventId;
  String eventName;
  DateTime eventStartDate;
  DateTime eventEndDate;
  String eventSpeakers;
  String eventDescription;
  String eventLocation;
  String eventDuration;
  String eventPrizeMoney;
  String eventPrizes;
  String eventRecordings;

  
  Event({
    required this.eventId,
    required this.eventName,
    required this.eventStartDate,
    required this.eventEndDate,
    required this.eventSpeakers,
    required this.eventDescription,
    required this.eventLocation,
    required this.eventDuration,
    required this.eventPrizeMoney,
    required this.eventPrizes,
    required this.eventRecordings,
  });


  factory Event.fromJson(Map<String,dynamic> json) {
   if (kDebugMode) {
     print("FACTORY Accessed");
   }
  Event e = Event(
     eventId: json["eventId"],
       eventName: json["eventName"],
    eventDescription: json["description"],
    eventStartDate: json["eventStartDate"],
    eventEndDate: json["eventEndDate"],
    eventSpeakers: json["eventSpeakers"],
    eventLocation: json["eventLocation"],
    eventPrizeMoney: json["eventPrizeMoney"],
      eventDuration:json["eventDuration"],
      eventPrizes:json["eventPrizes"],
      eventRecordings:json["eventRecordings"]
    );
    if (kDebugMode) {
      print("Event");
    }

    return Event(
        eventId: json["eventId"],
        eventName: json["eventName"],
        eventDescription: json["description"],
        eventStartDate: json["eventStartDate"],
        eventEndDate: json["eventEndDate"],
        eventSpeakers: json["eventSpeakers"],
        eventLocation: json["eventLocation"],
        eventPrizeMoney: json["eventPrizeMoney"],
        eventDuration:json["eventDuration"],
        eventPrizes:json["eventPrizes"],
        eventRecordings:json["eventRecordings"]
    );
  }
}


