import 'package:ecom/provider/category_provider.dart';
import 'package:ecom/provider/selected_category_provider.dart';
import 'package:ecom/ui/pages/cart_screen.dart';
import 'package:ecom/ui/pages/fav_screen.dart';
import 'package:ecom/ui/pages/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecom/provider/products_provider.dart';

class AllProductScreen extends ConsumerWidget {
  const AllProductScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsNotifier = ref.watch(productsProvider);
    final categoryNotifier = ref.watch(categoryProvider);
    final selectedCatNotifier = ref.watch(selectedCategoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ));
              },
              icon: Icon(Icons.shopping_cart)),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FavoriteScreen(),
                ));
              },
              icon: Icon(Icons.favorite))
        ],
      ),
      body: Column(
        children: [
          //1st column
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryNotifier.length,
              itemBuilder: (context, index) {
                final category = categoryNotifier[index];
                return InkWell(
                  onTap: () {
                    //for changing color
                    ref
                        .read(selectedCategoryProvider.notifier)
                        .setSelectedCategory(categoryNotifier[index].name!);
                    //for getting products
                    ref.read(productsProvider.notifier).getAllProducts(
                          slug: category.slug,
                        );
                  },
                  child: Center(
                    child: Card(
                      color: categoryNotifier[index].name == selectedCatNotifier
                          ? Colors.pink
                          : Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(category.slug!),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // 2nd column
          productsNotifier.isLoading
              ? const Center(child: CircularProgressIndicator())
              :productsNotifier.isError ?? false
              ? Text("Error : ${productsNotifier.errorMessage}")
              : productsNotifier.allProducts.isEmpty
                  ? const Center(child: Text('No Products Found'))
                  : Expanded(
                      child: ListView.builder(
                        itemCount: productsNotifier.allProducts.length,
                        itemBuilder: (context, index) {
                          final product = productsNotifier.allProducts[index];
                          return ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProductDetailPage(
                                  id: product.id.toString(),
                                ),
                              ));
                            },
                            leading: Image.network(
                              product.images!.first,
                              width: 75,
                              fit: BoxFit.fitWidth,
                            ),
                            title: Text(product.title!),
                            subtitle: Text(product.description!),
                            trailing: Text('\$${product.price.toString()}'),
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}
