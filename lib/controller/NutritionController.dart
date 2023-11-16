import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/FoodItem.dart';

class NutritionController extends ChangeNotifier {
  final RxList<FoodItem> foodItems = <FoodItem>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool noData = false.obs;

  Future<void> fetchNutritionData({String? query}) async {
    isLoading(true);
    noData(false); // Reset the noData flag when fetching new data

    try {
      final baseUrl = Uri.parse('https://nutrition-by-api-ninjas.p.rapidapi.com/v1/nutrition');
      final url = query != null ? baseUrl.replace(queryParameters: {'query': query}) : baseUrl;

      final response = await http.get(
        url,
        headers: {
          'X-RapidAPI-Key': '8ec235d2f6mshbffe97c67b86260p1a6cb8jsna608fd681823', // Replace with your actual API key
          'X-RapidAPI-Host': 'nutrition-by-api-ninjas.p.rapidapi.com',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> decodedData = json.decode(response.body);
        final List<FoodItem> items = decodedData.map((item) => FoodItem.fromJson(item)).toList();

        foodItems.assignAll(items);

        if (items.isEmpty) {
          noData(true); // Set the noData flag if there are no items
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false); // Set isLoading to false regardless of success or failure
    }
  }
}

