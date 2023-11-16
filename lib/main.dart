import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'controller/NutritionController.dart';
import 'screen/NutritionPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NutritionController(),
      child: GetMaterialApp(
        title: 'Nutrition App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: NutritionPage(),
      ),
    );
  }
}
