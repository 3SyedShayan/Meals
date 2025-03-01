import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';

enum Filter { Gluten, Vegetarian, Lactose, Vegan }

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.Gluten: false,
          Filter.Lactose: false,
          Filter.Vegan: false,
          Filter.Vegetarian: false,
        });

  void setFilters(Map<Filter, bool> filters) {
    state = filters;
  }

  void setFilter(Filter filter, bool value) {
    state = {
      ...state,
      filter: value,
    };
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
  (ref) => FilterNotifier(),
);

final filteredMealsProvider = Provider((ref) {
  final meal = ref.watch(mealsProvider);
  final selectedMeals = ref.watch(filterProvider);
  return meal.where((meal) {
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
});
