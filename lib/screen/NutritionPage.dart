import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/FoodItem.dart';

class NutritionPage extends StatefulWidget {
  @override
  _NutritionPageState createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  List<FoodItem> foodItems = [];
  bool isLoading = true;
  late TextEditingController _queryController;

  @override
  void initState() {
    super.initState();
    _queryController = TextEditingController();
    fetchNutritionData();
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  Future<void> fetchNutritionData({String? query}) async {
    final baseUrl = Uri.parse('https://nutrition-by-api-ninjas.p.rapidapi.com/v1/nutrition');
    final url = query != null ? baseUrl.replace(queryParameters: {'query': query}) : baseUrl;

    try {
      final response = await http.get(
        url,
        headers: {
          'X-RapidAPI-Key': '8ec235d2f6mshbffe97c67b86260p1a6cb8jsna608fd681823', // Replace with your API key
          'X-RapidAPI-Host': 'nutrition-by-api-ninjas.p.rapidapi.com',
        },
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        List<dynamic> decodedData = json.decode(response.body);
        setState(() {
          foodItems = decodedData.map((item) => FoodItem.fromJson(item)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void onSearch() {
    String query = _queryController.text;
    if (query.isNotEmpty) {
      setState(() {
        isLoading = true;
        foodItems.clear();
      });
      fetchNutritionData(query: query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nutrition Information'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: onSearch,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _queryController,
              decoration: InputDecoration(
                labelText: 'Enter query',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => onSearch(),
            ),
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : foodItems.isNotEmpty
          ? SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Calories')),
            DataColumn(label: Text('Serving Size (g)')),
            DataColumn(label: Text('Total Fat (g)')),
            DataColumn(label: Text('Saturated Fat (g)')),
            DataColumn(label: Text('Protein (g)')),
            DataColumn(label: Text('Sodium (mg)')),
            DataColumn(label: Text('Potassium (mg)')),
            DataColumn(label: Text('Cholesterol (mg)')),
            DataColumn(label: Text('Total Carbohydrates (g)')),
            DataColumn(label: Text('Fiber (g)')),
            DataColumn(label: Text('Sugar (g)')),
          ],
          rows: foodItems.map((foodItem) {
            return DataRow(cells: [
              DataCell(Text(foodItem.name)),
              DataCell(Text(foodItem.calories.toStringAsFixed(2))),
              DataCell(Text(foodItem.servingSize.toStringAsFixed(2))),
              DataCell(Text(foodItem.fatTotal.toStringAsFixed(2))),
              DataCell(Text(foodItem.fatSaturated.toStringAsFixed(2))),
              DataCell(Text(foodItem.protein.toStringAsFixed(2))),
              DataCell(Text(foodItem.sodium.toStringAsFixed(2))),
              DataCell(Text(foodItem.potassium.toStringAsFixed(2))),
              DataCell(Text(foodItem.cholesterol.toStringAsFixed(2))),
              DataCell(Text(foodItem.carbohydratesTotal.toStringAsFixed(2))),
              DataCell(Text(foodItem.fiber.toStringAsFixed(2))),
              DataCell(Text(foodItem.sugar.toStringAsFixed(2))),
            ]);
          }).toList(),
        ),
      )
          : Center(child: Text('No data available')),
    );
  }}