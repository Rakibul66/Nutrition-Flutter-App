class FoodItem {
  final String name;
  final double calories;
  final double servingSize;
  final double fatTotal;
  final double fatSaturated;
  final double protein;
  final double sodium;
  final double potassium;
  final double cholesterol;
  final double carbohydratesTotal;
  final double fiber;
  final double sugar;

  FoodItem({
    required this.name,
    required this.calories,
    required this.servingSize,
    required this.fatTotal,
    required this.fatSaturated,
    required this.protein,
    required this.sodium,
    required this.potassium,
    required this.cholesterol,
    required this.carbohydratesTotal,
    required this.fiber,
    required this.sugar,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      name: json['name'],
      calories: json['calories'].toDouble(),
      servingSize: json['serving_size_g'].toDouble(),
      fatTotal: json['fat_total_g'].toDouble(),
      fatSaturated: json['fat_saturated_g'].toDouble(),
      protein: json['protein_g'].toDouble(),
      sodium: json['sodium_mg'].toDouble(),
      potassium: json['potassium_mg'].toDouble(),
      cholesterol: json['cholesterol_mg'].toDouble(),
      carbohydratesTotal: json['carbohydrates_total_g'].toDouble(),
      fiber: json['fiber_g'].toDouble(),
      sugar: json['sugar_g'].toDouble(),
    );
  }
}
