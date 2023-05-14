import 'package:club_calendar/features/admin/events/view/widgets/admin_drawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../../../styles.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);
  static const routeName = 'dashboard';
  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  Styles styles = Styles();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
       appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {

                  if (kDebugMode) {
                    print("clicked");

                }
                _scaffoldKey.currentState!.openDrawer();
              }),
          backgroundColor: Styles.backgroundColor,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            "Admin Panel",
            style: styles.headingStyle(),
          ),
        ),

        drawer: adminDrawer(context),
    );
  }
}