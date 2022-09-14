import 'package:club_calendar/features/events/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../../../styles.dart';
import '../../../app_review/view/app_feedback_screen.dart';
import '../../../auth/model/google_auth.dart';
import '../../../auth/view/login_screen.dart';
import '../event_screen.dart';
import '../past_event_screen.dart';

Drawer customDrawer(context){
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.height;
  return Drawer(
    backgroundColor: Styles.backgroundColor,
    child: SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                //Image
                SizedBox(
                  height: height*0.2, width: width*0.2,
                  child: const Image(image: AssetImage(
                    'assets/CC-Logo(1).png'
                  )),
                ),
                
                const SizedBox(height: 30),
                customButton(context: context, title: "Events", callFunction: (){
                  print("Event Screen");
                  Navigator.pushReplacementNamed(context, EventScreen.routeName );
                }),
                
                customButton(context: context, title: "Past Events", callFunction: (){
                  print("Past Events Screen");
                  Navigator.pushReplacementNamed(context, PastEventsScreen.routeName );
                }),
                
                customButton(context: context, title: "Send Feedback", callFunction: (){
                  print("Feedback Screen");
                  Navigator.pushReplacementNamed(context, AppFeedBackScreen.routeName );
                }),
              ],
            ),
          ),
           Padding(
                padding: const EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: FloatingActionButton(
                    backgroundColor: Colors.grey[800],
                    onPressed: () {
                      Authentication.signOut(context: context);
                      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                    },
                    child: Icon(Icons.logout),
                  ),
                ),
              ),
        ],
      ),
    )
  );
}