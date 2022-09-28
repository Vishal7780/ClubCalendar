import 'package:club_calendar/features/events/model/event_model.dart';
import 'package:club_calendar/features/events/view/widgets/custom_tile.dart';
import 'package:club_calendar/features/events/view/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../styles.dart';
import '../controller/event_provider.dart';
import 'event_detail_screen.dart';

class PastEventsScreen extends StatefulWidget {
  const PastEventsScreen({Key? key}) : super(key: key);
  static const routeName = "/pastEventsScreen";
  @override
  State<PastEventsScreen> createState() => _PastEventsScreenState();
}

class _PastEventsScreenState extends State<PastEventsScreen> {
  String dayNameFromDate(DateTime date) {
    return DateFormat('EEEE').format(date);
  }

  String dayFromDate(DateTime date) {
    return DateFormat('d').format(date);
  }

  @override
  Widget build(BuildContext context) {
    Styles styles = Styles();
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                print("clicked");
                _scaffoldKey.currentState!.openDrawer();
              }),
          backgroundColor: Styles.backgroundColor,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            "Completed Events",
            style: styles.headingStyle(),
          ),
        ),
        drawer: customDrawer(context),
        body: FutureBuilder(
            future: Provider.of<EventsProvider>(context).fetchPastEvents(),
            builder: (context, snapshot) {
              print("IN");
              print(snapshot.hasData);
              if (snapshot.hasData) {
                print("GOT DATA");
                print(snapshot.data.toString());
                //TODO: Used Jugaad find proper method
                // if (snapshot.data.toString() == "[null]"||snapshot.data.toString() == "[]") {
                //   return const Center(
                //     child: Text("No past events",
                //         style: TextStyle(color: Colors.white)),
                //   );
                // }
                //print("Lol it came here");
                List<Event?> temp = snapshot.data as List<Event?>;
                final List<Event?> events = temp.whereType<Event>().toList();
                Map<String, List<Event?>> data =
                    new Map<String, List<Event?>>();
                for (int i = 0; i < events.length; i++) {
                  String monthName =
                      DateFormat('MMM').format(events[i]!.eventStartDate);
                  data.putIfAbsent(monthName, () => <Event?>[]).add(events[i]);
                }

                print(data.isEmpty);
                if(data.isEmpty){
                  return const Center(
                    child: Text("No events",
                        style: TextStyle(color: Colors.white)),
                  );
                }
                return ListView.builder(
                  physics : const BouncingScrollPhysics(),
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
                                        .toString()+" event(s)",
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
                                    day: dayFromDate(
                                        monthEvents[eventIndex]!.eventStartDate),
                                    eventName: monthEvents[eventIndex]!.eventName,
                                    duration: monthEvents[eventIndex]!.eventDuration
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
