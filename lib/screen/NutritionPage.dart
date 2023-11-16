import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controller/FoodItemController.dart';
import '../model/FoodItem.dart';
import '../repo/product_repo.dart';
import '../widget/NoDataWidget.dart';
import '../widget/NutritionDataTable.dart';
import '../widget/SearchFloatingActionButton.dart'; // Import your ProductRepo if not already imported


final foodItemControllerProvider = Provider((ref) {
  final productRepo = ref.watch(productRepoProvider);
  return FoodItemController(productRepo: productRepo);
});

class NutritionPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodItemController = ref.read(foodItemControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Nutrition Information'),
      ),
      body: NutritionBody(foodItemController: foodItemController),

    );
  }
}

class NutritionBody extends ConsumerWidget {
  final FoodItemController foodItemController;

  const NutritionBody({Key? key, required this.foodItemController})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<FoodItem>>(
      future: ref.watch(foodItemControllerProvider).fetchNutritionData(query: 'apple'), // Pass the query parameter here
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Error: Failed to load data'));
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: NutritionDataTable(foodItems: snapshot.data!),
          );
        }
      },
    );
  }
}



