import 'package:flutter/material.dart';

class TrophyProvider with ChangeNotifier {
  int _completedTasks = 0;

  int get completedTasks => _completedTasks;

  void taskCompleted() {
    _completedTasks++;
    if (_completedTasks % 10 == 0) {
      // Udělte trofej za každých 10 splněných úkolů
      // Implementujte příslušnou logiku pro udělení trofeje
    }
    notifyListeners();
  }
}
