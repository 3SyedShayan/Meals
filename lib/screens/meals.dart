import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item.dart';

class Meals extends StatelessWidget {
  Meals({
    super.key,
    this.title,
    required this.meals,
  });
  String? title;
  List<Meal> meals;
  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) => MealItem(
        meal: meals[index],
      ),
    );

    if (meals.isEmpty) {
      content = Center(
        child: Text("No meals found, please check your filters!"),
      );
    }

    if (title == null) {
      return content;
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(title!),
        ),
        body: content,
      );
    }
  }
}
