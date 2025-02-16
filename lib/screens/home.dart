import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';

class Home extends StatefulWidget {
  Home({super.key, required this.availableMeals});

  List<Meal> availableMeals;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1200),
        lowerBound: 0,
        upperBound: 1);
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void onSelectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where(
          (meal) => meal.categories.contains(
            category.id,
          ),
        )
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Meals(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: EdgeInsets.all(24),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGrid(
              category: category,
              onSelectCategory: () {
                onSelectCategory(context, category);
              },
            )
        ],
      ),
      builder: (context, child) => SlideTransition(
        child: child,
        position: Tween(
          begin: Offset(0, 0.3),
          end: Offset(0, 0.0),
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        ),
      ),
    );
  }
}
