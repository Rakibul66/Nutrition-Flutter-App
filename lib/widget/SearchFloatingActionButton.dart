import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/NutritionController.dart';

class SearchFloatingActionButton extends StatelessWidget {
  final NutritionController nutritionController;

  const SearchFloatingActionButton({Key? key, required this.nutritionController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return SearchBottomSheet(nutritionController: nutritionController);
          },
        );
      },
      child: Icon(Icons.find_in_page),
    );
  }
}

class SearchBottomSheet extends StatelessWidget {
  final NutritionController nutritionController;

  const SearchBottomSheet({Key? key, required this.nutritionController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.6),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter query',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.blueAccent.withOpacity(0.6),
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.blueAccent,
                        width: 2,
                      ),
                    ),
                  ),
                  onSubmitted: (String value) {
                    if (value.isNotEmpty) {
                      nutritionController.fetchNutritionData(query: value);
                      Get.back(); // Close the bottom sheet after submitting the query
                    }
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Perform search operation
                    // Call fetchNutritionData() or any action needed here
                    Get.back(); // Close the bottom sheet after clicking the search button
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Text(
                      'Search',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}