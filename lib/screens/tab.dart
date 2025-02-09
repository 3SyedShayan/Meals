import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/home.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

const kInitialFilters = {
  Filter.Gluten: false,
  Filter.Lactose: false,
  Filter.Vegan: false,
  Filter.Vegetarian: false
};

class _TabScreenState extends State<TabScreen> {
  List<Meal> favMeals = [];
  Map<Filter, bool> selectedMeals = kInitialFilters;
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

  void onDrawerUpdate(String drawerText) async {
    Navigator.of(context).pop();
    if (drawerText == "filters") {
      var result = await Navigator.push<Map<Filter, bool>>(
        context,
        MaterialPageRoute(
          builder: (context) => FiltersScreen(
            currentFilters: selectedMeals,
          ),
        ),
      );
      setState(() {
        selectedMeals = result ?? kInitialFilters;
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
    final availableMeals = dummyMeals.where((meal) {
      if (selectedMeals[Filter.Gluten]! && !meal.isGlutenFree) {
        return false;
      }
      if (selectedMeals[Filter.Lactose]! && !meal.isLactoseFree) {
        return false;
      }
      if (selectedMeals[Filter.Vegan]! && !meal.isVegan) {
        return false;
      }
      if (selectedMeals[Filter.Vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();
    Widget content = Home(
      availableMeals: availableMeals,
      onUpdateFavourites: onUpdateFavourites,
    );
    if (currentIndex == 1) {
      content = Meals(
        meals: favMeals,
        onUpdateFavorites: onUpdateFavourites,
      );
    }
    return Scaffold(
      drawer: MainDrawer(
        onDrawerSelection: onDrawerUpdate,
      ),
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
