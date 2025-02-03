import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

class Meals extends StatelessWidget {
  Meals({super.key, required this.title, required this.meals});
  String title;
  List<Meal> meals;
  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) => Card(
        child: Column(
          children: [
            Text(meals[index].title),
          ],
        ),
      ),
    );
    if (meals.isEmpty) {
      content = Center(
        child: Text("No meals found, please check your filters!"),
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: content);
  }
}
