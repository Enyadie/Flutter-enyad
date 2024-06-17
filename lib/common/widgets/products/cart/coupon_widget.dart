import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helper/helper_function.dart';
import '../../custom_shapes/containers/circular_container.dart';

class SCouponCode extends StatelessWidget {
  const SCouponCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunction.isDarkMode(context);
    return SRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? SColors.darkerGrey : SColors.grey,
      padding: const EdgeInsets.only(
          top: SSize.sm, bottom: SSize.sm, right: SSize.sm, left: SSize.md),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'have a promo code? Enter here',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),

          ///---button---
          SizedBox(
              width: 95,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: SColors.white,
                      backgroundColor:
                          dark ? SColors.darkerPurple : SColors.purple,
                      side: const BorderSide(color: Colors.transparent)),
                  onPressed: () {},
                  child: const Text('Apply')))
        ],
      ),
    );
  }
}
