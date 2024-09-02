import 'package:ecom/data(models)/categories.dart';
import 'package:ecom/repo/categoory_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryProvider extends StateNotifier<List<CategoryModal>> {
  final Ref ref;

  CategoryProvider(this.ref) : super([]);//related to empty api list

  Future<void> getAllCategories({String? slug}) async {
    try {
      await ref.read(categoryRepoProvider).getAllCategories().then((value) {
        state = value;
      });
    } catch (e) {
      // Handle or log the exception here
      print("Error fetching categories: $e");
    }
  }
}

final categoryProvider =
    StateNotifierProvider<CategoryProvider, List<CategoryModal>>(
  (ref) => CategoryProvider(ref),
);
