import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../styles.dart';


Widget RatingCard(String title,context, review) {
  var styles = Styles();
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 0,
        color: Styles.backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: styles.cardHeadingStyle(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: RatingBar.builder(
                initialRating: title =="Overall Experience"? (review.overallRating == null? 3: review.overallRating): (review.experienceRating == null? 3: review.experienceRating),
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                unratedColor: Colors.white,
                onRatingUpdate: (rating) {
                   if(title == "Overall Experience"){
                    review.setOverallRating(rating);
                   }else{
                     review.setExperienceRating(rating);
                   }
                },
              ),
            )
          ],
        ),
      ),
    );
  
}
