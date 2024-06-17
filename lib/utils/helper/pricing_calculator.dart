

class SPricingCalculator {
  static double calculateTotalPrice(double subTotal, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = subTotal * taxRate;

    double deliveryCost = getDeliveryCost(location);

    double totalPrice = subTotal + taxAmount + deliveryCost;
    return totalPrice;
  }

  static double calculateDeliveryCost(double subTotal, String location) {
    double deliveryCost = getDeliveryCost(location);
    return deliveryCost;
  }

  static double calculateTax(double subTotal, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = subTotal * taxRate;
    return taxAmount;
  }

  static double getTaxRateForLocation(String location) {
    return 0.0165;
  }

  static double getDeliveryCost(String location) {
    return 2000.00;
  }

// static String formatPrice(double price) {
//   final NumberFormat formatter = NumberFormat("#,##0.00");
//   return formatter.format(price);
// }
// static double calculateCartTotal(CartModel cart){
//   return cart.items.map((e)) => e.price).fold(0,(previousPrice,currentPrice)=>previousPrice + (currentPrice ?? 0));
// }
}
