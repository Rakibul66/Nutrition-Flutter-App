
import '../model/FoodItem.dart';
import '../repo/product_repo.dart';

class FoodItemController {
  final ProductRepo _productRepo;

  FoodItemController({required ProductRepo productRepo})
      : _productRepo = productRepo;

  Future<List<FoodItem>> fetchNutritionData({String? query}) async {
    return await _productRepo.fetchNutritionData(query: query);
  }
}
