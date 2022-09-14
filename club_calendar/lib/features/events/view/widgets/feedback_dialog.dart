
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../styles.dart';
import '../../model/event_model.dart';

Widget feedbackDialog(Event e) {
  double finalRating = 3;
  TextEditingController reviewController = TextEditingController();
  return Dialog(
    backgroundColor: Colors.transparent,
    insetPadding: EdgeInsets.all(10),
    child: AspectRatio(
      aspectRatio: 1,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: Container(
          decoration: const BoxDecoration(
              color: Styles.backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Rate Event",
                style: TextStyle(
                  color: Styles.buttonColor,
                  fontSize: 25,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RatingBar.builder(
                  initialRating: finalRating,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 30,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  unratedColor: Colors.white,
                  onRatingUpdate: (rating) {
                    finalRating = rating;
                    print("Overall Experience : ${rating}");
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: Neumorphic(
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(12)),
                        depth: 4,
                        intensity: 0,
                        color: Colors.black12),
                    child: Card(
                      elevation: 0,
                      color: Styles.backgroundColor,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: TextFormField(
                            controller: reviewController,
                            minLines: 1,
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                            style: const TextStyle(color: Styles.fontColor),
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Write review here",
                                hintStyle: TextStyle(color: Colors.white),
                                focusColor: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Styles.buttonColor,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    minimumSize: const Size(100, 40), 
                  ),
                  onPressed: () {
                    String id = e.eventId;
                    CollectionReference _reviews = FirebaseFirestore.instance.collection("events/$id/reviews");
                    _reviews.add({
                        "rating": finalRating,
                        "review": reviewController.text.toString()
                    });
                    
                      reviewController.clear();
                      finalRating = 3;
                
                  },
                  child: const Text('Rate Us',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w400)),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
