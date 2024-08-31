import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'riverpod_models.dart';

final userData = ChangeNotifierProvider<UserData>((ref) {
  return UserData();
});

final mealData = ChangeNotifierProvider<MealData>((ref) {
  return MealData();
});

final mealDataOptions = ChangeNotifierProvider<MealDataOptions>((ref) {
  return MealDataOptions();
});
