import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';

class SRatingBarIndicator extends StatelessWidget {
  const SRatingBarIndicator({
    super.key,
    required this.rating,
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
        rating: rating,
        itemSize: 25,
        itemBuilder: (_, __) => const Icon(Iconsax.star, color: Colors.orange));
  }
}
