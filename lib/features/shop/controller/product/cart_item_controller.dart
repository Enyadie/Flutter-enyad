import 'package:enyad_store_3/features/shop/controller/product/variation_controller.dart';
import 'package:enyad_store_3/features/shop/models/cart_item_model.dart';
import 'package:enyad_store_3/features/shop/models/product_model.dart';
import 'package:enyad_store_3/utils/local_storage/local_storage.dart';
import 'package:enyad_store_3/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/enums.dart';

class CartItemController extends GetxController {
  static CartItemController get instance => Get.put(CartItemController());

  RxInt numOfCartItems = 0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxDouble totalCartPrice = 0.00.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final variationController = VariationController.instance;

  CartItemController() {
    loadCartItems();
  }

  void addToCart(ProductModel product) {
    ///check quantity
    if (productQuantityInCart.value < 1) {
      SLoaders.customToast(message: 'Select Quantity');
      return;
    }

    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariation.value.id.isEmpty) {
      SLoaders.customToast(message: 'Select Variation');
      return;
    }

    if (product.productType == ProductType.variable.toString()) {
      if (variationController.selectedVariation.value.stock < 1) {
        SLoaders.warningSnackBar(
            title: 'Oh No!', message: 'Select variation is out of stock');
        return;
      }
    } else {
      if (product.stock < 1) {
        SLoaders.warningSnackBar(
            title: 'Oh No!', message: 'Select product is out of stock');
        return;
      }
    }
    final selectedCartItem =
        convertToCartItem(product, productQuantityInCart.value);

    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == selectedCartItem.productId &&
        cartItem.variationId == selectedCartItem.variationId);

    if (index >= 0) {
      ///if quantity is already add or remove / updated(-)
      cartItems[index].quantity = selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }

    updateCart();
    SLoaders.customToast(message: 'Product has been added to Cart.');
  }

  void addOneToCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);

    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }

    updateCart();
  }

  void removeOneFromCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);

    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        cartItems[index].quantity == 1
            ? removeFromCartDialog(index)
            : cartItems.removeAt(index);
      }
      updateCart();
    }
  }

  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: 'Remove Product',
      middleText: 'Are you sure you want to remove this Product?',
      onConfirm: () {
        cartItems.removeAt(index);
        updateCart();
        SLoaders.customToast(message: 'Product removed from Cart.');
        Get.back();
      },
      onCancel: () => () => Get.back(),
    );
  }

  ///converts a productmodel to a cartitemmodel
  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    if (product.productType == ProductType.single.toString()) {
      ///reset the variation if its single
      variationController.resetSelectedAttributes();
    }

    final variation = variationController.selectedVariation.value;
    final isVariation = variation.id.isNotEmpty;
    final price = isVariation
        ? variation.salePrice > 0.00
            ? variation.salePrice
            : variation.price
        : product.salePrice > 0.00
            ? product.salePrice
            : product.price;

    return CartItemModel(
        quantity: quantity,
        productId: product.id,
        title: product.title,
        price: price,
        variationId: variation.id,
        image: isVariation ? variation.image : product.thumbnail,
        brandName: product.brand != null ? product.brand!.name : '',
        selectedVariation: isVariation ? variation.attributesVariables : null);
  }

  ///update cart values
  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  void updateCartTotals() {
    double calculatedTotalPrice = 0.00;
    int calculatedNumOfItems = 0;

    for (var item in cartItems) {
      calculatedTotalPrice += (item.price) * item.quantity.toDouble();
      calculatedNumOfItems += item.quantity;
    }

    totalCartPrice.value = calculatedTotalPrice;
    numOfCartItems.value = calculatedNumOfItems;
  }

  void saveCartItems() {
    final cartItemsStrings = cartItems.map((item) => item.toJson()).toList();
    SLocalStorage.instance().saveData('cartItems', cartItemsStrings);
  }

  void loadCartItems() {
    final cartItemStrings =
        SLocalStorage.instance().readData<List<dynamic>>('cartItems');

    if (cartItemStrings != null) {
      cartItems.assignAll(cartItemStrings
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>)));

      updateCartTotals();
    }
  }

  int getProductQuantityInCart(String productId) {
    final foundItem = cartItems
        .where((item) => item.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }

  int getVariationQuantityInCart(String productId, String variationId) {
    final foundItem = cartItems.firstWhere(
      (item) => item.productId == productId && item.variationId == variationId,
      orElse: () => CartItemModel.empty(),
    );

    return foundItem.quantity;
  }

  void clearCart() {
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }

  updateAddedProducts(ProductModel product) {
    ///if no variation calculate cart entry and display total number
    ///else entry is zero and show selected entries variations
    if (product.productType == ProductType.single.toString()) {
      productQuantityInCart.value = getProductQuantityInCart(product.id);
    } else {
      final variationId = variationController.selectedVariation.value.id;
      if (variationId.isNotEmpty) {
        productQuantityInCart.value =
            getVariationQuantityInCart(product.id, variationId);
      } else {
        productQuantityInCart.value = 0;
      }
    }
  }
}
