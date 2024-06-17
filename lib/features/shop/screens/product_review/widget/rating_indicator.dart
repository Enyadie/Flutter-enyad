import 'package:enyad_store_3/features/shop/screens/product_review/widget/rating_progress_indicator.dart';
import 'package:flutter/material.dart';

class SOverAllProductRating extends StatelessWidget {
  const SOverAllProductRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Text('4.5', style: Theme.of(context).textTheme.displayLarge),
        ),
        const Expanded(
          flex: 6,
          child: Column(
            children: [
              SRatingProgressIndicator(text: '5', value: 1.0),
              SRatingProgressIndicator(text: '4', value: 0.8),
              SRatingProgressIndicator(text: '3', value: 0.6),
              SRatingProgressIndicator(text: '2', value: 0.3),
              SRatingProgressIndicator(text: '1', value: 0.1),
            ],
          ),
        ),
      ],
    );
  }
}
