import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../../styles.dart';
import '../events/view/widgets/admin_drawer.dart';

class ViewAppFeedback extends StatefulWidget {
  const ViewAppFeedback({Key? key}) : super(key: key);
  static const routeName = 'view_feedback';
  @override
  State<ViewAppFeedback> createState() => _ViewAppFeedbackState();
}

class _ViewAppFeedbackState extends State<ViewAppFeedback> {
  Styles styles = Styles();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Stream<QuerySnapshot> get _reviewStream =>
      FirebaseFirestore.instance.collection("reviews").snapshots();
  @override
  Widget build(BuildContext context) {
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
            "App feedback",
            style: styles.headingStyle(),
          ),
        ),
        drawer: adminDrawer(context),
        body: Column(
          
          children: [
            Expanded(
              flex: 1,
              child: StreamBuilder<QuerySnapshot>(
                  stream: _reviewStream,
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.data!.size == 0) {
                      return const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Center(
                          child: Text(
                            "No reviews",
                          ),
                        ),
                      );
                    }

                    return ListView(
                        shrinkWrap: true,
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          return Card(

                            shadowColor: Colors.black,
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.person_2_outlined),
                                  Text( ("Email : " +data["name"]),
                                    style:styles.descriptionStyle(
                                    ),
                                  ),
                                  Text("Experience of Events : " +data["eventExp"].toString(), style:styles.descriptionStyle()),
                                  Text("Overall Experience : "+ data["overallExp"].toString(), style:styles.descriptionStyle()),
                                  Text(data["rating"]==""? "No rating added": data["rating"].toString(), style:styles.descriptionStyle())
                                ],
                              ),
                            ),
                          );
                        }).toList());
                  }),
            ),
          ],
        ));
  }
}
