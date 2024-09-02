import 'package:ecom/data(models)/products.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartProvider extends StateNotifier<List<ProductsModel>> {
  CartProvider() : super([]);

  void addProductToCart(ProductsModel product) {
    if (!state.any((item) => item.id == product.id)) {
      state = [...state, product];
    }
  }

  void removeProductFromCart(ProductsModel product) {
    state = state.where((item) => item.id != product.id).toList();
  }

  bool isProductInCart(ProductsModel product) {
    return state.any((item) => item.id == product.id);
  }
}

final cartProvider = StateNotifierProvider<CartProvider, List<ProductsModel>>(
  (ref) => CartProvider(),
);
