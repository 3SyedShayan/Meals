import 'package:flutter/material.dart';
import 'package:meals/providers/favourites_provider.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/home.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

const kInitialFilters = {
  Filter.Gluten: false,
  Filter.Lactose: false,
  Filter.Vegan: false,
  Filter.Vegetarian: false
};

class _TabScreenState extends ConsumerState<TabScreen> {
  // List<Meal> favMeals = [];
  Map<Filter, bool> selectedMeals = kInitialFilters;
  int currentIndex = 0;
  // void showSnacks(String message) {

  // }

  // void onUpdateFavourites(Meal meal) {
  //   if (favMeals.contains(meal)) {
  //     setState(() {
  //       favMeals.remove(meal);
  //       showSnacks('Removed from favorites');
  //     });
  //   } else {
  //     setState(() {
  //       favMeals.add(meal);
  //       showSnacks('Added to favorites');
  //     });
  //   }
  // }

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

    final availableMeals = ref.watch(filteredMealsProvider);
    Widget content = Home(
      availableMeals: availableMeals,
      // onUpdateFavourites: onUpdateFavourites,
    );
    if (currentIndex == 1) {
      content = Meals(
        meals: ref.watch(favMealsProvider),
        // onUpdateFavorites: onUpdateFavourites,
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
