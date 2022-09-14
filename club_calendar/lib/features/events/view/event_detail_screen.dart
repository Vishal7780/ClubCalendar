import 'package:club_calendar/features/events/view/widgets/current_event_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../styles.dart';
import '../model/event_model.dart';

class EventDetailScreen extends StatefulWidget {
  final Event event;
  EventDetailScreen({Key? key, required this.event}) : super(key: key);

  static const routeName = "/eventDetailScreen";
  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  getImageUrl(String fileName) async {
    print("Method accessed: ");
    print(fileName + ".jpg");
    final ref = FirebaseStorage.instance.ref().child(fileName + ".jpg");

    var url = await ref.getDownloadURL();
    print(url);
    return (url);
  }

  String dayNameFromDate(DateTime date) {
    return DateFormat('EEEE').format(date);
  }

  String dayFromDate(DateTime date) {
    return DateFormat('d').format(date);
  }



  Styles styles = Styles();
  @override
  Widget build(BuildContext context) {
    print(widget.event.eventId);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close)),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                  future: getImageUrl(widget.event.eventId),
                  builder: (context, snap) {
                    print(snap.data);
                    if (snap.hasData) {
                      print(snap.data);
                      return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.45,
                          width: double.infinity,
                          child: Image.network(
                            snap.data.toString(),
                            fit: BoxFit.fill,
                          ));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.event.eventName,
                  style: styles.titleStyle(),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                  
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  child: Row(
                    // physics: const NeverScrollableScrollPhysics(),
                    // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //   crossAxisCount: 2,
                    //   childAspectRatio: 1,
                    // ),
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.5,
                        child: ListTile(
                          leading: styles.getIcon(Icons.calendar_today),
                          title: Text(dayFromDate(widget.event.eventStartDate) + " "+DateFormat('MMM').format(widget.event.eventStartDate) ),
                          subtitle: Text(dayNameFromDate(widget.event.eventStartDate)),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.5,
                        child: ListTile(
                          leading: styles.getIcon(Icons.access_time),
                          title: Text(widget.event.eventDuration),
                        ),
                      )
                    ],
                  )),
              ListTile(
                leading: styles.getIcon(Icons.location_on,
                    radius: 30.0, defaultSize: 30.0),
                title: Text(
                  widget.event.eventLocation,
                  softWrap: false,
                  style: styles.headingStyle(fontWeight: FontWeight.normal),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  widget.event.eventDescription,
                  style: styles.descriptionStyle(),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
        currentEventSlider(context,widget.event, widget.event.eventEndDate.compareTo(DateTime.now())>=0,)
      ]
      ),
    );
  }
}
