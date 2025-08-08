import 'package:flutter/material.dart';
import '../models/review.dart';

// PUBLIC_INTERFACE
/// Manages reviews given by the user.
class ReviewProvider extends ChangeNotifier {
  final List<Review> _reviews = [];

  List<Review> get reviews => _reviews;

  // PUBLIC_INTERFACE
  Future<void> addReview(Review review) async {
    // TODO: API to submit review.
    _reviews.add(review);
    notifyListeners();
  }

  // PUBLIC_INTERFACE
  Future<void> fetchReviews(String restaurantId) async {
    // TODO: API to fetch reviews for a restaurant.
    notifyListeners();
  }
}
