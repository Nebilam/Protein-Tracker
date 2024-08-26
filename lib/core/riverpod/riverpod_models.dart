import 'package:flutter/widgets.dart';

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
