import 'package:flutter_riverpod/flutter_riverpod.dart';

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
