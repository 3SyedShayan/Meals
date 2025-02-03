import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';

class CategoryGrid extends StatelessWidget {
  CategoryGrid({
    super.key,
    required this.category,
    required this.onSelectCategory,
  });
  Category category;
  void Function() onSelectCategory;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      color: category.color,
      child: InkWell(
        child: Text(category.title),
        onTap: onSelectCategory,
      ),
    );
  }
}
