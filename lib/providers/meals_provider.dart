import 'package:meals/data/data.dart';
import 'package:riverpod/riverpod.dart';

final mealsProvider = Provider((ref) {
  return dummyMeals;
});
