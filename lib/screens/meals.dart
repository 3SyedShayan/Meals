import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item.dart';

class Meals extends StatelessWidget {
  Meals(
      {super.key,
      this.title,
      required this.meals,
      required this.onUpdateFavorites});
  String? title;
  void Function(Meal meal) onUpdateFavorites;
  List<Meal> meals;
  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) => MealItem(
        meal: meals[index],
        onUpdateFav: onUpdateFavorites,
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
