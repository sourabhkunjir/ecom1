import 'package:ecom/data(models)/products.dart';
import 'package:ecom/provider/cart_provider.dart';
import 'package:ecom/provider/fav_provider.dart';
import 'package:ecom/provider/product_from_id_future_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailPage extends ConsumerWidget {
  // Changed Consumer to ConsumerWidget
  const ProductDetailPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<ProductsModel> productData =
        ref.watch(productFromIDFutureProvider(id));// here

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Detail Page"),
      ),
      // this below applicable only when you are provider "FutureProvider.family" that is in productsfromidfustureprovider....if we not go for traditional back method instead of this..when method
      body: productData.when(//here
        data: (product) {//here
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(product.images!.first),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product.title!,//here
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product.description!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '\$${product.price.toString()}',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // for add to cart 
                  ref.read(cartProvider.notifier).addProductToCart(product);
                  
                },
                child: const Text("Add to Cart"),
              ),
              ElevatedButton(
                onPressed: () {
                  //for add to fav
                  ref.read(favoriteProvider.notifier).addProductToFavorites(product);
                  
                },
                child: const Text("Add to favorites"),
              )
            ],
          );
        },
        //here
        error: (error, stack) {
          return Center(
            child: Text('Error: $error'),
          );
        },
        //here
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
