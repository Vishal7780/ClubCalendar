import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_calendar/features/app_review/controller/app_feedback_provider.dart';
import 'package:club_calendar/features/app_review/view/widgets/rating_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
//import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../styles.dart';
import '../../events/view/widgets/drawer.dart';

class AppFeedBackScreen extends StatefulWidget {
  const AppFeedBackScreen({Key? key}) : super(key: key);
  static const routeName = "/appFeedBackScreen";
  @override
  State<AppFeedBackScreen> createState() => _AppFeedBackScreenState();
}

class _AppFeedBackScreenState extends State<AppFeedBackScreen> {
  @override
  Styles styles = new Styles();
  final CollectionReference reviews =
      FirebaseFirestore.instance.collection("reviews");
  final _reviewTextCon = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    //double deviceHeight = MediaQuery.of(context).size.height;
    return Consumer<ReviewProvider>(
      builder: (context, review, _) => Scaffold(
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
              "Club Calendar",
              style: styles.titleStyle(),
            ),
          ),
          backgroundColor: Styles.backgroundColor,
          drawer: customDrawer(context),
          body: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minWidth: constraints.maxWidth,
                        minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                        child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Column(
                              children: [
                                Column(children: [
                                  Text("Like Using Club Calendar",
                                      style: styles.headingStyle()),
                                  Image.asset("assets/phone_feedback.PNG",
                                      fit: BoxFit.fill, scale: 0.4),
                                  Consumer<ReviewProvider>(
                                      builder: (context, review, _) =>
                                          RatingCard("Overall Experience",
                                              context, review)),
                                  //TODO : DO WE REALLY NEED THIS?
                                  Consumer<ReviewProvider>(
                                      builder: (context, review, _) =>
                                          RatingCard("Event Experience",
                                              context, review)),
                                ]),
                              ],
                            ),
                          ),
                        ),
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: AlignmentDirectional.bottomStart,
                          children: [
                            Image.asset("assets/Vector_feedback1.png",
                                fit: BoxFit.fill, scale: 0.1),
                            Image.asset("assets/Vector_feedback2.png",
                                fit: BoxFit.fill, scale: 0.1),
                            Positioned(
                              left: deviceWidth * 0.05,
                              right: deviceWidth * 0.05,
                              child: Column(
                                children: [
                                  //Card
                                  Container(
                                    child: Neumorphic(
                                      style: NeumorphicStyle(
                                          shape: NeumorphicShape.concave,
                                          boxShape:
                                              NeumorphicBoxShape.roundRect(
                                                  BorderRadius.circular(12)),
                                          depth: 4,
                                          intensity: 0.35,
                                          color: Colors.black12),
                                      child: Card(
                                        elevation: 3,
                                        color: Styles.backgroundColor,
                                        child: Center(
                                          child: Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: AspectRatio(
                                                aspectRatio: 3,
                                                child: TextFormField(
                                                  controller: _reviewTextCon,
                                                  minLines: 1,
                                                  maxLines: 5,
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  style: const TextStyle(
                                                      color: Styles.fontColor),
                                                  decoration:
                                                      const InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              "Write review here",
                                                          hintStyle: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                          focusColor:
                                                              Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  //Button
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Styles.buttonColor,
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0)),
                                        minimumSize:
                                            Size(100, 40),
                                      ),
                                      onPressed: () {
                                        User? user = FirebaseAuth.instance.currentUser;
                                        String uid =
                                            FirebaseAuth.instance.currentUser!.uid;
                                        print(review.experienceRating.toString());
                                        reviews.doc(uid).set({
                                          'name': user!.email,
                                          'overallExp': review.overallRating,
                                          'eventExp': review.experienceRating,
                                          'rating': _reviewTextCon.text.toString()
                                        });

                                        print("clicked");
                                        setState(() {
                                          print('set state');
                                          review.setExperienceRating(2);
                                          print(review.experienceRating);
                                          review.setOverallRating(2);
                                          _reviewTextCon.clear();
                                        });
                                      },
                                      child: const Text('Rate Us',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400)),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ))));
          })),
    );
  }
}
