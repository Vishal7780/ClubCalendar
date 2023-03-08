import 'package:club_calendar/features/admin/events/view/add_event.dart';
import 'package:club_calendar/features/admin/events/view/admin_dashboard.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../../../../styles.dart';
import '../../../../auth/model/google_auth.dart';
import '../../../../auth/view/login_screen.dart';
import '../../../../events/view/widgets/custom_button.dart';
import '../../../view_app_feedback/view_app_feedback.dart';
import 'package:club_calendar/features/events/view/past_event_screen.dart';

Drawer adminDrawer(context){
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
                customButton(context: context, title: "Add Events", callFunction: (){
                  print("Add Event Screen");
                  Navigator.pushReplacementNamed(context, AddEventPage.routeName );
                }),
                
                customButton(context: context, title: "Manage Events", callFunction: (){
                  print("Past Events Screen");
                  Navigator.pushReplacementNamed(context, PastEventsScreen.routeName );
                }),
                
                customButton(context: context, title: "View App Feedback", callFunction: (){
                  print("View App Feedback Screen");
                  Navigator.pushReplacementNamed(context, ViewAppFeedback.routeName );
                }),

                customButton(context: context, title: "DashBoard", callFunction: (){
                  print("View App Feedback Screen");
                  Navigator.pushReplacementNamed(context, AdminDashboard.routeName);
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