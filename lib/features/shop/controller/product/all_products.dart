import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enyad_store_3/common/shimmers/vertical_shimmer.dart';
import 'package:enyad_store_3/common/widgets/appbar/appBar.dart';
import 'package:enyad_store_3/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:enyad_store_3/features/shop/screens/all_products/all_products_controller.dart';
import 'package:enyad_store_3/utils/constants/colors.dart';
import 'package:enyad_store_3/utils/constants/sizes.dart';
import 'package:enyad_store_3/utils/helper/cloud_helper_function.dart';
import 'package:enyad_store_3/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/products/Filter/filter.dart';
import '../../models/product_model.dart';

class SAllProductsScreen extends StatelessWidget {
  const SAllProductsScreen(
      {super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query<Map<String, dynamic>>? query;

  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunction.isDarkMode(context);
    final controller = Get.put(AllProductsController());
    return Scaffold(
      backgroundColor: dark ? SColors.darkerPurple : SColors.purple,
      appBar: SAppBar(
        title: Text(
          title,
          style: TextStyle(color: dark ? SColors.grey : SColors.white),
        ),
        showBackButton: true,
        buttonBackgroundColor: true,
      ),
      body: SPrimaryHeaderContainer(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(SSize.defautSpace),
            child: FutureBuilder<List<ProductModel>>(
                future: futureMethod ?? controller.getProductsByQuery(query!),
                builder: (context, snapshot) {
                  const loader = SVerticalShimmer();
                  final widget = SCloudHelperFunction.checkMultipleRecordState(
                      snapshot: snapshot, loader: loader);
                  if (widget != null) return widget;
                  final products = snapshot.data!;
                  return SSortableProducts(products: products);
                }),
          ),
        ),
      ),
    );
  }
}
