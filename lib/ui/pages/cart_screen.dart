import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecom/provider/cart_provider.dart'; 


class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart Screen"),
      ),
      body: cart.isEmpty
          ? const Center(child: Text("Cart is empty"))
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final product = cart[index];
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
                        icon: const Icon(Icons.delete,color: Colors.red,),
                        onPressed: () {
                          ref.read(cartProvider.notifier).removeProductFromCart(product);
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
