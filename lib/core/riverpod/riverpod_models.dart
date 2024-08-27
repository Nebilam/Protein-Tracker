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
  String name;
  double weight;

  UserData({required this.name, required this.weight});
}

class MealData extends ChangeNotifier {
  final userId = supabase.auth.currentUser!.id;
  late List<dynamic> breakfastData = [];

  Future<List<dynamic>> getBreakfastData() async {
    final response =
        await supabase.from('breakfast').select('*').eq('user_id', userId);
    return response as List<dynamic>;
  }

  late List<dynamic> lunchData = [];

  Future<List<dynamic>> getLunchData() async {
    final response =
        await supabase.from('lunch').select('*').eq('user_id', userId);
    return response as List<dynamic>;
  }

  MealData() {
    getBreakfastData().then((data) {
      breakfastData = data;
      notifyListeners();
    });
    getLunchData().then((data) {
      lunchData = data;
      notifyListeners();
    });
  }
}
