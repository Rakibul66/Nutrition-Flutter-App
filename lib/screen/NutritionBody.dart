import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/FoodItemController.dart';
import '../model/FoodItem.dart';
import '../repo/product_repo.dart';
import '../widget/NoDataWidget.dart';
import '../widget/NutritionDataTable.dart';
// Assuming this widget displays nutrition data

final foodItemControllerProvider = Provider((ref) {
  final productRepo = ref.watch(productRepoProvider);
  return FoodItemController(productRepo: productRepo);
});

class NutritionBody extends ConsumerWidget {
  final FoodItemController foodItemController;

  const NutritionBody({Key? key, required this.foodItemController})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<FoodItem>> asyncValue = ref
        .watch(foodItemControllerProvider)
        .fetchNutritionData(query: null) as AsyncValue<List<FoodItem>>; // Updated method name here

    return asyncValue.when(
      data: (foodItems) {
        if (foodItems.isEmpty) {
          return const Center(child: Text('Error: Failed to load data'));
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: NutritionDataTable(foodItems: foodItems),
          );
        }
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => NoDataWidget(), // Customize error handling here
    );
  }
}
