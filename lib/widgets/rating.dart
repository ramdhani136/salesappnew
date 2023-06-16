// ignore_for_file: must_be_immutable

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  late double rating = 1.0;
  Rating(this.rating, {super.key});

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      ignoreGestures: true,
      initialRating: rating,
      itemCount: 5,
      itemSize: 30.0,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      // itemBuilder: (context, index) {
      //   switch (index) {
      //     case 0:
      //       return const Icon(
      //         Icons.sentiment_very_dissatisfied,
      //         color: Colors.red,
      //       );
      //     case 1:
      //       return const Icon(
      //         Icons.sentiment_dissatisfied,
      //         color: Colors.redAccent,
      //       );
      //     case 2:
      //       return const Icon(
      //         Icons.sentiment_neutral,
      //         color: Colors.amber,
      //       );
      //     case 3:
      //       return const Icon(
      //         Icons.sentiment_satisfied,
      //         color: Colors.lightGreen,
      //       );
      //     case 4:
      //       return const Icon(
      //         Icons.sentiment_very_satisfied,
      //         color: Colors.green,
      //       );
      //     default:
      //       return const Icon(
      //         Icons.sentiment_very_dissatisfied,
      //         color: Colors.red,
      //       );
      //   }
      // },
      onRatingUpdate: (rating) {},
    );
  }
}
