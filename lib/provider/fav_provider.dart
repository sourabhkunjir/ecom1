import 'package:ecom/data(models)/products.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteProvider extends StateNotifier<List<ProductsModel>> {
  FavoriteProvider() : super([]);

  void addProductToFavorites(ProductsModel product) {
    if (!state.any((item) => item.id == product.id)) {
      state = [...state, product];
    }
  }

  void removeProductFromFavorites(ProductsModel product) {
    state = state.where((item) => item.id != product.id).toList();
  }

  bool isProductInFavorites(ProductsModel product) {
    return state.any((item) => item.id == product.id);
  }
}

final favoriteProvider = StateNotifierProvider<FavoriteProvider, List<ProductsModel>>(
  (ref) => FavoriteProvider(),
);
