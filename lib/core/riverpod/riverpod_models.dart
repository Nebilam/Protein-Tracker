import 'package:flutter/widgets.dart';
import 'package:myapp/main.dart';

class Proteins extends ChangeNotifier {
  int currentIntake;
  int goalIntake;
  int increment;

  Proteins(
      {required this.currentIntake,
      required this.goalIntake,
      required this.increment});

  double get percentageIntake => (currentIntake / goalIntake).toDouble();
  int get roundPercentageIntake => (percentageIntake * 100).round();

  void incrementFunc({int increment = 1}) {
    currentIntake += increment;
    notifyListeners();
  }
}

class UserData extends ChangeNotifier {
  void updateName(String newName) async {
    await supabase
        .from('profiles')
        .update({'username': newName}).eq('id', supabase.auth.currentUser!.id);
  }

  late final userName = supabase
      .from('profiles')
      .select('username')
      .eq('id', supabase.auth.currentUser!.id);

  UserData();
}

class MealData extends ChangeNotifier {
  final userId = supabase.auth.currentUser!.id;

  late final breakfastData =
      supabase.from('breakfast').select('*').eq('user_id', userId);
  late final lunchData =
      supabase.from('lunch').select('*').eq('user_id', userId);
  late final dinnerData =
      supabase.from('dinner').select('*').eq('user_id', userId);
  late final snacksData =
      supabase.from('snacks').select('*').eq('user_id', userId);
  MealData();
}
