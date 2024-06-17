import 'package:enyad_store_3/features/shop/controller/product/cart_item_controller.dart';
import 'package:enyad_store_3/features/shop/controller/product/images_controller.dart';
import 'package:enyad_store_3/features/shop/models/product_model.dart';
import 'package:get/get.dart';

import '../../models/product_variations_model.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;

  void onAttributesSelected(

      /// add the selected attribute to selectedAttributes
      ProductModel product,
      attributeName,
      attributeValue) {
    final selectedAttributes =
        Map<String, dynamic>.from(this.selectedAttributes);
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;

    final selectedVariation = product.productVariations!.firstWhere(
      (variation) => _isSameAttributeValue(
          variation.attributesVariables, selectedAttributes),
      orElse: () => ProductVariationModel.empty(),
    );

    ///show selected image as main
    if (selectedVariation.image.isNotEmpty) {
      ImagesController.instance.selectedProductImage.value =
          selectedVariation.image;
    }

    if (selectedVariation.id.isNotEmpty) {
      final cartController = CartItemController.instance;
      cartController.productQuantityInCart.value = cartController
          .getVariationQuantityInCart(product.id, selectedVariation.id);
    }

    ///assign selected variation
    this.selectedVariation.value = selectedVariation;

    getProductVariationStockStatus();
  }

  ///helper function to check if the attribute selected matches the variations
  bool _isSameAttributeValue(Map<String, dynamic> variationAttributes,
      Map<String, dynamic> selectedAttributes) {
    ///if selected contain 3 attributes and current variation is 2 the return
    if (variationAttributes.length != selectedAttributes.length) return false;

    /// if attributes are different then return
    for (final key in variationAttributes.keys) {
      ///attribute key equals value which code be e.g [small,blue,wood]
      if (variationAttributes[key] != selectedAttributes[key]) return false;
    }
    return true;
  }

  /// check if the attribute is available
  Set<String?> getAttributesAvailabilityInVariation(
      List<ProductVariationModel> variations, String attributeName) {
    final availableVariationAttributeValue = variations
        .where((variations) =>

            /// check if out of stock
            variations.attributesVariables[attributeName] != null &&
            variations.attributesVariables[attributeName]!.isNotEmpty &&
            variations.stock > 0)

        ///get all attributes of the variant if not out of stock
        .map((variations) => variations.attributesVariables[attributeName])
        .toSet();
    return availableVariationAttributeValue;
  }

  String getVariationPrice() {
    return (selectedVariation.value.salePrice > 0
            ? selectedVariation.value.salePrice
            : selectedVariation.value.price)
        .toString();
  }

  void getProductVariationStockStatus() {
    variationStockStatus.value =
        selectedVariation.value.stock > 0 ? 'In Stock' : 'Out Stock';
  }

  void resetSelectedAttributes() {
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVariationModel.empty();
  }
}
