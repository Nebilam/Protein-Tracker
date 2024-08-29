import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'riverpod_models.dart';

// final currentIntake = StateProvider<int>((ref) => 0);

final userData = ChangeNotifierProvider<UserData>((ref) {
  return UserData();
});

final mealData = ChangeNotifierProvider<MealData>((ref) {
  return MealData();
});

final mealDataOptions = ChangeNotifierProvider<MealDataOptions>((ref) {
  return MealDataOptions();
});
