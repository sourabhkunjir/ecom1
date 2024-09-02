import 'package:ecom/provider/fav_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoriteProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Screen"),
      ),
      body: favorites.isEmpty
          ? const Center(child: Text("No favorites yet"))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final product = favorites[index];
                return ListTile(
                  leading: Image.network(
                    product.images!.first,
                    width: 75,
                    fit: BoxFit.fitWidth,
                  ),
                  title: Text(product.title!),
                  subtitle: Text(product.description!),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('\$${product.price.toString()}'),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          ref.read(favoriteProvider.notifier).removeProductFromFavorites(product);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
