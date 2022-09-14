import 'package:club_calendar/features/events/view/widgets/feedback_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart' as neu;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../styles.dart';
import '../../model/event_model.dart';

Widget currentEventSlider(BuildContext context, Event event, bool isPresent) {
  print(isPresent);
  double deviceHeight = MediaQuery.of(context).size.height,
      deviceWidth = MediaQuery.of(context).size.width;
  Styles styles = new Styles();
  return SlidingSheet(
    color: Styles.backgroundColor,
    elevation: 8,
    cornerRadius: 33,
    snapSpec: const SnapSpec(
      snap: true,
      snappings: [70, 230, 550],
      positioning: SnapPositioning.pixelOffset,
    ),
    builder: (context, state) {
      var styles = Styles();
      //Contains all details of more details page
      return Container(
        // width: MediaQuery.of(buildcontext).size.width,
        decoration: const BoxDecoration(
          color: Styles.backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(33.0),
            topRight: Radius.circular(33.0),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              //Names
              ListTile(
                  leading: styles.leadingListTile('assets/speaker.png'),
                  title: Text(event.eventSpeakers)),

              SizedBox(
                height: 20,
              ),

              //Info used here
              Container(
                height: 80,
                child: GridView(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2.7,
                    ),
                    children: [
                      ListTile(
                        onTap: ()async{
                           await launchUrl(Uri.parse(event.eventRecordings));
                        },
                        leading: styles.leadingListTile('assets/checklists2.png'),
                        title: Text(
                          event.eventRecordings=="NA"? "NA": "Click Here",
                          softWrap: true,
                          style: styles.customStyle(size: 20.0,color: Styles.detailsColor),
                        ),
                        subtitle: const Text(' '),
                      ),
                       ListTile(
                        leading: styles.leadingListTile('assets/award 1.png'),
                        title: Text(
                          event.eventPrizeMoney == "0" ? "NA" : event.eventPrizeMoney,
                          softWrap: false,
                          style: styles.customStyle(size: 20.0,color: Styles.detailsColor),
                        ),
                        subtitle: const Text(' '),
                      )
                    ],
                  ),
              ),

              //Divider
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.87,
                  alignment: Alignment.center,
                  color: Styles.buttonColor,
                  height: 1.5,
                  padding: EdgeInsets.all(16),
                ),
              ),

              event.eventPrizes == "NA"
                  ? ListTile(
                      leading: styles.leadingListTile('assets/medal.png',
                          radius: 60.0),
                      title: Text("NA",
                          style: styles.customStyle(
                              size: 20.0, color: Styles.detailsColor)))
                  : Column(
                      children: [
                        ListTile(
                          leading: styles.leadingListTile('assets/medal.png',
                              radius: 60.0),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '1st Prize',
                                style: styles.customStyle(
                                    size: 20.0, color: Styles.detailsColor),
                              ),
                              Text(
                                event.eventPrizes.split(",")[0],
                                style: styles.customStyle(
                                    size: 20.0, color: Styles.detailsColor),
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          leading: styles.leadingListTile(
                              'assets/silver_medal.png',
                              radius: 60.0),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '2nd Prize',
                                style: styles.customStyle(
                                    size: 20.0, color: Styles.detailsColor),
                              ),
                              Text(
                                event.eventPrizes.split(",")[1],
                                style: styles.customStyle(
                                    size: 20.0, color: Styles.detailsColor),
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          leading: styles.leadingListTile(
                              'assets/bronze_medal.png',
                              radius: 60.0),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '3rd Prize',
                                style: styles.customStyle(
                                    size: 20.0, color: Styles.detailsColor),
                              ),
                              Text(
                                event.eventPrizes.split(",")[2],
                                style: styles.customStyle(
                                    size: 20.0, color: Styles.detailsColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

              SizedBox(
                height: 20,
              ),

              isPresent
                  ? ListTile(
                      leading: styles.leadingListTile('assets/feedback1.png'),
                      title: Text("NA",
                          style: styles.customStyle(
                              size: 20.0, color: Styles.detailsColor)),
                    )
                  : ListTile(
                      leading: styles.leadingListTile('assets/feedback1.png'),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: RatingBar.builder(
                              initialRating: 3,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: deviceWidth * 0.05,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              unratedColor: Colors.white,
                              onRatingUpdate: (rating) {
                                print("Overall Experience : ${rating}");
                              },
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        feedbackDialog(event));
                              },
                              child: const Center(
                                child: Text(
                                  'Rate Now',
                                  style: TextStyle(color: Styles.buttonColor),
                                ),
                              ))
                        ],
                      ),
                    ),
            ],
          ),
        ),
      );
    },
    headerBuilder: (context, state) {
      return Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(33.0),
            topRight: Radius.circular(33.0),
          ),
          color: Styles.backgroundColor,
        ),
        child: neu.NeumorphicButton(
          onPressed: () {
            print('hi');
          },
          style: _style(context),
          child: Center(
            child: Text(
              'More Details',
              style: styles.descriptionStyle(color: Styles.buttonColor),
            ),
          ),
        ),
      );
    },
  );
}

neu.NeumorphicStyle _style(BuildContext ctx) {
  return neu.NeumorphicStyle(
    lightSource: neu.LightSource.top,
    shadowLightColorEmboss: Colors.white,
    shadowLightColor: Styles.backgroundColor,
    boxShape: neu.NeumorphicBoxShape.roundRect(
      BorderRadius.only(
        topLeft: Radius.circular(MediaQuery.of(ctx).size.height * 0.0387820513),
        topRight:
            Radius.circular(MediaQuery.of(ctx).size.height * 0.0387820513),
      ),
    ),
    color: Styles.backgroundColor,
    intensity: 0.56,
    shape: neu.NeumorphicShape.concave,
    depth: -19.96877, //MediaQuery.of(context).size.height*0.023,
    oppositeShadowLightSource: true,
  );
}
