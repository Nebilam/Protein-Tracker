import 'package:flutter/widgets.dart';
import 'package:myapp/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserData extends ChangeNotifier {
  void updateName(String newName) async {
    await supabase
        .from('profiles')
        .update({'username': newName}).eq('id', supabase.auth.currentUser!.id);
  }

  void updateWeight(double newWeight) async {
    await supabase
        .from('profiles')
        .update({'weight': newWeight}).eq('id', supabase.auth.currentUser!.id);
  }

  void updateProteinRatio(double newRatio) async {
    await supabase.from('profiles').update({'protein_ratio': newRatio}).eq(
        'id', supabase.auth.currentUser!.id);
  }

  void updateGoalIntake(int newGoalIntake) async {
    await supabase.from('profiles').update({'goal_intake': newGoalIntake}).eq(
        'id', supabase.auth.currentUser!.id);
  }

  late final userName = supabase
      .from('profiles')
      .select('username')
      .eq('id', supabase.auth.currentUser!.id);
  late final weight = supabase
      .from('profiles')
      .select('weight')
      .eq('id', supabase.auth.currentUser!.id);
  late final proteinRatio = supabase
      .from('profiles')
      .select('protein_ratio')
      .eq('id', supabase.auth.currentUser!.id);
  late final goalIntake = supabase
      .from('profiles')
      .select('goal_intake')
      .eq('id', supabase.auth.currentUser!.id);

  UserData();
}

class MealData extends ChangeNotifier {
  final userId = supabase.auth.currentUser!.id;

  Future<int> sumProteins() async {
    final sum = await Future.wait([
      _sumFromTable('breakfast', userId),
      _sumFromTable('lunch', userId),
      _sumFromTable('dinner', userId),
      _sumFromTable('snacks', userId),
    ]).then((values) => values.reduce((a, b) => a + b));

    return sum;
  }

  Future<int> _sumFromTable(String tableName, String userId) async {
    final supabase = Supabase.instance.client;
    final query =
        supabase.from(tableName).select('proteins').eq('user_id', userId);

    try {
      final result = await query;
      List items = [for (var i in result) i['proteins']];
      return items.reduce((a, b) => a + b);
    } catch (error) {
      return 0;
    }
  }

  void cloneAdd(
      String mealType, String name, num proteinDensity, num weight) async {
    await supabase.from(mealType).insert({
      'user_id': supabase.auth.currentUser!.id,
      'name': name,
      'proteinDensity': proteinDensity,
      'quantity': 1,
      'weight': weight,
      'proteins': proteinDensity * weight,
    });
  }

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

class MealDataOptions extends ChangeNotifier {
  final userId = supabase.auth.currentUser!.id;

  late final breakfastData =
      supabase.from('breakfast_list').select('*').eq('user_id', userId);
  late final lunchData =
      supabase.from('lunch_list').select('*').eq('user_id', userId);
  late final dinnerData =
      supabase.from('dinner_list').select('*').eq('user_id', userId);
  late final snacksData =
      supabase.from('snacks_list').select('*').eq('user_id', userId);
  MealDataOptions();
}
