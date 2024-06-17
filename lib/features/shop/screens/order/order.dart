import 'package:enyad_store_3/common/widgets/appbar/appBar.dart';
import 'package:enyad_store_3/features/shop/screens/order/widget/order_list.dart';
import 'package:enyad_store_3/utils/constants/colors.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../utils/helper/helper_function.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunction.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? SColors.darkerPurple : SColors.purple,
      appBar: SAppBar(
          buttonBackgroundColor: true,
          showBackButton: true,
          showBackground: false,
          title: Text('My Orders',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: SColors.white))),
      body: const Padding(
        padding: EdgeInsets.all(SSize.defautSpace / 2),
        child: SOrderListItems(),
      ),
    );
  }
}
