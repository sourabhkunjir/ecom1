import 'package:dio/dio.dart';
import 'package:ecom/data(models)/products.dart';
import 'package:ecom/networking/api_endpoints.dart';
import 'package:ecom/networking/dio_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsRepo {
  final Ref ref;

  ProductsRepo(this.ref);

  Future<List<ProductsModel>> getAllProducts({String? slug}) async {
    Response response;
    // slug means == dummmyjson.com/products.category/slug(beauty,fragnance,etc etc)
    try {
      //this is for category card
      if (slug != null) {
        response = await ref
            .read(dioClientProvider)
            .get("${APIEndpoints.GetProductsByCategoryEndPoint}/$slug");
            //this is for normal show first page
      } else {
        response = await ref
            .read(dioClientProvider)
            .get(APIEndpoints.GetProductsEndPoint);
      }

      if (response.statusCode == 200) {
        final List<ProductsModel> allProductsList =
            (response.data['products'] as List)
                .map<ProductsModel>((product) => ProductsModel.fromJson(product))
                .toList();
        return allProductsList;
      } else {
        return Future.error('Failed to fetch products ${response.statusCode}');
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<ProductsModel> getProductFromId(String id) async {
    try {
      final response = await ref
          .read(dioClientProvider)
          .get("${APIEndpoints.GetProductsEndPoint}/$id");
      if (response.statusCode == 200) {
        return ProductsModel.fromJson(response.data);
      } else {
        return Future.error("falied to fetch product ${response.statusCode}");
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}

// Provider for ProductsRepo
final productsRepoProvider = Provider<ProductsRepo>((ref) => ProductsRepo(ref));




