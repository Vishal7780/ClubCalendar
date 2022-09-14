import 'package:club_calendar/features/app_review/model/app_feedback_model.dart';
import 'package:club_calendar/features/app_review/view/app_feedback_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'features/app_review/controller/app_feedback_provider.dart';
import 'features/auth/view/login_screen.dart';
import 'features/events/controller/event_provider.dart';
import 'features/events/view/event_screen.dart';
import 'features/events/view/past_event_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      //home: ,//EventScreen(),
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return ChangeNotifierProvider<EventsProvider>(
                    create: (_) => EventsProvider(), child: EventScreen());
                //return UserInfoScreen(user: snapshot.data);
              }
            }
            return LoginScreen();
          }),
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        EventScreen.routeName: (context) =>
            ChangeNotifierProvider<EventsProvider>(
                create: (_) => EventsProvider(), child: EventScreen()),
        AppFeedBackScreen.routeName: (context) =>
            ChangeNotifierProvider<ReviewProvider>(
                create: (_) =>ReviewProvider(),
                child: AppFeedBackScreen()),
        PastEventsScreen.routeName: (context) => ChangeNotifierProvider<EventsProvider>(
                create: (_) => EventsProvider(), child: PastEventsScreen())
      },
      title: 'Flutter Demo',
    );
  }
}
