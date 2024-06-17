import 'package:enyad_store_3/features/authentication/screens/login/login.dart';
import 'package:enyad_store_3/features/authentication/screens/passwordconfig/forgetpassword.dart';
import 'package:enyad_store_3/features/authentication/screens/signup/signup.dart';
import 'package:enyad_store_3/features/personalization/screens/address/address.dart';
import 'package:enyad_store_3/features/personalization/screens/profile/profile.dart';
import 'package:enyad_store_3/features/personalization/screens/settings/profile_setting.dart';
import 'package:enyad_store_3/features/shop/screens/cart/cart.dart';
import 'package:enyad_store_3/features/shop/screens/checkout/checkout.dart';
import 'package:enyad_store_3/features/shop/screens/order/order.dart';
import 'package:enyad_store_3/features/shop/screens/product_review/product_reviews.dart';
import 'package:enyad_store_3/features/shop/screens/wishlist/wishlist.dart';
import 'package:enyad_store_3/routes/routes.dart';
import 'package:get/get.dart';

import '../features/authentication/screens/onboarding/onboarding.dart';
import '../features/shop/models/product_model.dart';
import '../features/shop/screens/home/home.dart';
import '../features/shop/screens/product_details/product_details.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: SRoutes.home, page: () => const HomeScreen()),
    GetPage(
        name: SRoutes.store,
        page: () => ProductDetailScreen(
              product: ProductModel.empty(),
            )),
    GetPage(name: SRoutes.favourites, page: () => const WishListScreen()),
    GetPage(name: SRoutes.settings, page: () => const ProfileSettingScreen()),
    GetPage(
        name: SRoutes.productReviews, page: () => const ProductReviewScreen()),
    GetPage(name: SRoutes.order, page: () => const OrderScreen()),
    GetPage(name: SRoutes.checkout, page: () => const CheckoutScreen()),
    GetPage(name: SRoutes.cart, page: () => const CartScreen()),
    GetPage(name: SRoutes.userprofile, page: () => const ProfileScreen()),
    GetPage(name: SRoutes.userAddress, page: () => const UserAddressScreen()),
    GetPage(name: SRoutes.signup, page: () => const SignupScreen()),
    GetPage(name: SRoutes.signIn, page: () => const LoginScreen()),
    GetPage(name: SRoutes.forgotPassword, page: () => const ForgetPassword()),
    GetPage(name: SRoutes.onBoarding, page: () => const OnBoardingScreen()),
  ];
}
