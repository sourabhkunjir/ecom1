import 'package:flutter_riverpod/flutter_riverpod.dart';

// Class name should be properly capitalized and consistent
class SelectedCategoryProvider extends StateNotifier<String> {
  SelectedCategoryProvider() : super("");

  void setSelectedCategory(String cat) {
    state = cat;
  }
}

// Properly define the provider
final selectedCategoryProvider = StateNotifierProvider<SelectedCategoryProvider, String>(
  (ref) => SelectedCategoryProvider(),
);
