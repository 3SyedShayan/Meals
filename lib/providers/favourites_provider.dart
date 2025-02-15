import 'package:meals/models/meal.dart';
import 'package:riverpod/riverpod.dart';

class FavouritesProvider extends StateNotifier<List<Meal>> {
  FavouritesProvider() : super([]);

  bool toggleMealOnFavStatus(Meal meal) {
    final isFav = state.contains(meal);

    if (isFav) {
      state = state.where((e) => e.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  } 
}

final favMealsProvider = StateNotifierProvider<FavouritesProvider, List<Meal>>(
  (ref) {
    return FavouritesProvider();
  },
);
