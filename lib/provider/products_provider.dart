import 'package:ecom/data(models)/products.dart';
import 'package:ecom/repo/products_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsController {
  final bool isLoading;
  final List<ProductsModel> allProducts;
  final bool? isError;
  final String? errorMessage;

  ProductsController({
    required this.isLoading,
    required this.allProducts,
    this.isError,
    this.errorMessage,
  });

  // to give provider multiple values
  ProductsController copyWith({
    bool? isLoading,
    List<ProductsModel>? allProducts,
    bool? isError,
    String? errorMessage,
  }) {
    return ProductsController(
      isLoading: isLoading ?? this.isLoading,
      allProducts: allProducts ?? this.allProducts,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class ProductsProvider extends StateNotifier<ProductsController> {

  //constructor
  ProductsProvider(this.ref)
      : super(ProductsController(isLoading: false, allProducts: []));

  final Ref ref;

  Future<void> getAllProducts({String? slug}) async {
    state = state.copyWith(isLoading: true);

    try {
      final data =
          await ref.read(productsRepoProvider).getAllProducts(slug: slug);
      state = state.copyWith(
        allProducts: data,
        isLoading: false,
        isError: false,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: e.toString(),
      );
    }
  }
}

// Provider for ProductsProvider
final productsProvider =
    StateNotifierProvider<ProductsProvider, ProductsController>(
        (ref) => ProductsProvider(ref));
