import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

import '../controller/NutritionController.dart';
import '../widget/NoDataWidget.dart';
import '../widget/NutritionDataTable.dart';
import '../widget/SearchFloatingActionButton.dart';

class NutritionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NutritionController nutritionController =
    Provider.of<NutritionController>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Nutrition Information'),
      ),
      body: NutritionBody(nutritionController: nutritionController),
      floatingActionButton: SearchFloatingActionButton(
        nutritionController: nutritionController,
      ),
    );
  }
}

class NutritionBody extends StatelessWidget {
  final NutritionController nutritionController;

  const NutritionBody({Key? key, required this.nutritionController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (nutritionController.isLoading.isTrue) {
        return const Center(child: CircularProgressIndicator());
      } else if (nutritionController.noData.isTrue) {
        return NoDataWidget();
      } else if (nutritionController.foodItems.isEmpty) {
        return const Center(child: Text('Error: Failed to load data'));
      } else {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: NutritionDataTable(
            foodItems: nutritionController.foodItems,
          ),
        );
      }
    });
  }
}