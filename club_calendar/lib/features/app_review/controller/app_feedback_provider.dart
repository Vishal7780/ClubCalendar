import 'package:flutter/material.dart';

class ReviewProvider with ChangeNotifier {
  double? _overallRating = 3.0;
  double? _experienceRating = 3.0;
  String? _rating;

  double? get overallRating => _overallRating;
  double? get experienceRating => _experienceRating;
  String? get rating => _rating;

  void setOverallRating(double? value) {
    _overallRating = value;
    notifyListeners();
  }

  void setExperienceRating(double? value) {
    _experienceRating = value;
    notifyListeners();
  }

  void setRating(String? value) {
    _rating = value;
    notifyListeners();
  }
}
