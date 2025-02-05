import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/home.dart';
import 'package:meals/screens/meals.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Meal> favMeals = [];
  int currentIndex = 0;
  void showSnacks(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void onUpdateFavourites(Meal meal) {
    if (favMeals.contains(meal)) {
      setState(() {
        favMeals.remove(meal);
        showSnacks('Removed from favorites');
      });
    } else {
      setState(() {
        favMeals.add(meal);
        showSnacks('Added to favorites');
      });
    }
  }

  void onUpdateTab(index) {
    setState(
      () {
        currentIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Home(
      onUpdateFavourites: onUpdateFavourites,
    );
    if (currentIndex == 1) {
      content = Meals(
        meals: favMeals,
        onUpdateFavorites: onUpdateFavourites,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: currentIndex == 0 ? const Text('Home') : const Text('Favorites'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favorites",
          ),
        ],
        currentIndex: currentIndex,
        onTap: onUpdateTab,
      ),
      body: content,
    );
  }
}
