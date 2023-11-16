import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../model/FoodItem.dart';

final productRepoProvider = Provider((ref) => ProductRepo());

class ProductRepo {
  Future<List<FoodItem>> fetchNutritionData({String? query}) async {
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
      return items;
    } else {
      // If the API call fails, throw an exception or handle the error accordingly
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
