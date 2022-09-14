// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_calendar/features/events/view/event_detail_screen.dart';
import 'package:club_calendar/features/events/view/widgets/custom_tile.dart';
import 'package:club_calendar/features/events/view/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../styles.dart';
import '../controller/event_provider.dart';
import '../model/event_model.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);
  static const routeName = "/eventScreen";
  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  String dayNameFromDate(DateTime date) {
    return DateFormat('EEEE').format(date);
  }

  String dayFromDate(DateTime date) {
    return DateFormat('d').format(date);
  }

  // final Stream<QuerySnapshot> _eventsStream =
  //     FirebaseFirestore.instance.collection('events').snapshots();

  @override
  Widget build(BuildContext context) {
    Styles styles = Styles();
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                print("clicked");
                _scaffoldKey.currentState!.openDrawer();
              }),
          backgroundColor: Styles.backgroundColor,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            "Upcoming Events",
            style: styles.headingStyle(),
          ),
        ),
        drawer: customDrawer(context),
        body: FutureBuilder(
            future: Provider.of<EventsProvider>(context).fetchUpcomingEvents(),
            builder: (context, snapshot) {
              print("IN");
              print(snapshot.hasData);
              if (snapshot.hasData) {
                print("GOT DATA");
                print("DATA"+ snapshot.data.toString());
                if (snapshot.data.toString() == "[null]" || snapshot.data.toString() == "[]") {
                  return const Center(
                    child: Text("No events",
                        style: TextStyle(color: Colors.white)),
                  );
                }

                List<Event?> temp = snapshot.data as List<Event?>;
                final List<Event?> events = temp.whereType<Event>().toList();
                Map<String, List<Event?>> data =
                    new Map<String, List<Event?>>();
                for (int i = 0; i < events.length; i++) {
                  String monthName =
                      DateFormat('MMM').format(events[i]!.eventStartDate);
                  data.putIfAbsent(monthName, () => <Event?>[]).add(events[i]);
                }

                print(data);
                return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.keys.length,
                    itemBuilder: (context, monthIndex) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    padding: const EdgeInsets.only(
                                        top: 4, bottom: 4, right: 20, left: 10),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(100),
                                          bottomRight: Radius.circular(100)),
                                      color: Styles.buttonColor,
                                    ),
                                    child: Text(
                                      data.keys.elementAt(monthIndex),
                                      style: styles.headingStyle(),
                                    )),
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 4, bottom: 4, right: 10, left: 20),
                                  child: Text(
                                    data[data.keys.elementAt(monthIndex)]!
                                        .length
                                        .toString()+ " event(s)",
                                    style: styles.headingStyle(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  data[data.keys.elementAt(monthIndex)]!.length,
                              itemBuilder: (context, eventIndex) {
                                print("here");
                                List<Event?> monthEvents =
                                    data[data.keys.elementAt(monthIndex)]!;
                                return GestureDetector(
                                  onTap: (){
                                    print(monthEvents[eventIndex]);
                                    Navigator.push(context, 
                                    MaterialPageRoute(builder: ((context) => 
                                         EventDetailScreen(
                                          event: monthEvents[eventIndex]!
                                        ))
                                    ));
                                  },
                                  child: customTile(
                                    dayName: dayNameFromDate(
                                            monthEvents[eventIndex]!.eventStartDate)
                                        .substring(0, 3),
                                    day: dayFromDate(monthEvents[eventIndex]!.eventStartDate),
                                    eventName: monthEvents[eventIndex]!.eventName,
                                    duration: monthEvents[eventIndex]!.eventDuration,
                                    
                                  ),
                                );
                              })
                        ],
                      );
                    });
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}
