import 'package:ecom/data(models)/categories.dart';
import 'package:ecom/networking/api_endpoints.dart';
import 'package:ecom/networking/dio_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryRepo {
  final Ref ref;
  CategoryRepo(this.ref);

  Future<List<CategoryModal>> getAllCategories() async {
    try {
      final response = await ref.read(dioClientProvider).get(APIEndpoints.GetAllCategoriesEndPoint);
      if (response.statusCode == 200) {
        final List<dynamic> dataList = response.data; 
        final List<CategoryModal> categoryList = dataList
            .map<CategoryModal>((item) => CategoryModal.fromJson(item as Map<String, dynamic>))
            .toList();
        return categoryList;
      } else {
        throw Exception("Unable to Fetch Data");
      }
    } catch (e) {
      // Handle or log the exception here
      throw Exception("An error occurred: $e");
    }
  }
}

final categoryRepoProvider = Provider<CategoryRepo>((ref) => CategoryRepo(ref));
