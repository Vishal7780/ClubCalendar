import 'package:club_calendar/features/admin/events/view/widgets/admin_drawer.dart';
import 'package:club_calendar/features/events/model/event_model.dart';
import 'package:club_calendar/features/events/view/widgets/admin_custom_tile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '/styles.dart';
import 'package:club_calendar/features/events/controller/event_provider.dart';
import 'package:club_calendar/features/events/view/event_detail_screen.dart';
import 'package:club_calendar/features/events/controller/event_provider.dart';


class ManageEvents extends StatefulWidget {
  const ManageEvents ({Key? key}) : super(key: key);
  static const routeName = "/ManageEvents";
  @override
  State<ManageEvents > createState() => _ManageEvents();

}

class _ManageEvents extends State<ManageEvents > {
  String dayNameFromDate(DateTime date) {
    return DateFormat('EEEE').format(date);
  }

  String dayFromDate(DateTime date) {
    return DateFormat('d').format(date);
  }

  @override
  Widget build(BuildContext context) {
    Styles styles = Styles();
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                if (kDebugMode) {
                  print("clicked");
                }
                scaffoldKey.currentState!.openDrawer();
              }),
          backgroundColor: Styles.backgroundColor,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            "Events",
            style: styles.headingStyle(),
          ),
        ),
        drawer: adminDrawer(context),

        body:
        FutureBuilder(

            future: Provider.of<EventsProvider>(context).fetchEvents(),

            builder: (context, snapshot) {
              if (kDebugMode) {
                print("IN");
              }
              if (kDebugMode) {
                print(snapshot.hasData);
              }
              if (snapshot.hasData) {
                if (kDebugMode) {
                  print("GOT DATA");
                }
                if (kDebugMode) {
                  print(snapshot.data.toString());
                }
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
                <String, List<Event?>>{};
                for (int i = 0; i < events.length; i++) {
                  String monthName =
                  DateFormat('MMM').format(events[i]!.eventStartDate);
                  data.putIfAbsent(monthName, () => <Event?>[]).add(events[i]);
                }


                if (kDebugMode) {
                  print(data.isEmpty);
                }
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
                                    "${data[data.keys.elementAt(monthIndex)]!.length} event(s)",
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
                                if (kDebugMode) {
                                  print("here");
                                }
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
                                  child:admincustomTile(
                                    eventId: monthEvents[eventIndex]!.eventId,

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

