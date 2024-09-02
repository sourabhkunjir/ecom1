import 'package:ecom/provider/category_provider.dart';
import 'package:ecom/provider/products_provider.dart';
import 'package:ecom/ui/pages/all_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {

  @override
  void initState() {
    super.initState();
    // init todo list
    Future.microtask(
      () async {
        try {
          // Fetch products
          await ref.read(productsProvider.notifier).getAllProducts();
          // Fetch products
          await ref.read(categoryProvider.notifier).getAllCategories().then(
            (value) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => AllProductScreen(),
                ),
                (route) => false,
              );
            },
          );
        } catch (e) {
          print('Error fetching products: $e');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
