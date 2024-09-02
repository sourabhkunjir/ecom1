import 'package:ecom/data(models)/products.dart';
import 'package:ecom/repo/products_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productFromIDFutureProvider =
    FutureProvider.family<ProductsModel, String>((ref, id) async {
  return await ref.read(productsRepoProvider).getProductFromId(id);
});
