
// class Person{
//     String firstName;
//     String? lastName;

//     Person({required this.firstName, this.lastName});
// }
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
  //double prizeMoney;
  
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

  // factory Event.fromJson(Map<String,dynamic> json) {
  //   print("FACTORY Accessed");
  //   Event e = Event(
  //     id: json["id"],
  //     title: json["title"],
  //     description: json["description"],
  //     startDate: json["startDate"],
  //     endDate: json["endDate"],
  //     organizer: json["organizer"],
  //     locationName: json["location"],
  //     //prizeMoney: json["prizeMoney"],
  //   );
  //   print("Event");

  //   return Event(
  //     id: json["id"],
  //     title: json["title"],
  //     description: json["description"],
  //     startDate: json["startDate"],
  //     endDate: json["endDate"],
  //     organizer: json["organizer"],
  //     locationName: json["location"],
  //     //prizeMoney: json["prizeMoney"],
  //   );
  //}
}


