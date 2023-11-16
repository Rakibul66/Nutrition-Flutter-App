import 'package:flutter/material.dart';

import '../model/FoodItem.dart';

class NutritionDataTable extends StatelessWidget {
  final List<FoodItem> foodItems;

  const NutritionDataTable({Key? key, required this.foodItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Calories')),
        DataColumn(label: Text('Serving Size (g)')),
        // Add other DataColumn definitions here based on your FoodItem model
      ],
      rows: foodItems.map((foodItem) {
        return DataRow(cells: [
          DataCell(Text(foodItem.name)),
          DataCell(Text(foodItem.calories.toString())),
          DataCell(Text(foodItem.servingSize.toString())),
          // Add other DataCell widgets corresponding to each DataColumn
        ]);
      }).toList(),
    );
  }
}