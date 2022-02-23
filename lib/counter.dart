import 'package:flutter/foundation.dart';

class Counter with ChangeNotifier {
  int counter = 0;

  get value => counter;

  void increment() {
    counter++;
    print("counter is now ${counter}");
    notifyListeners();
  }
}
