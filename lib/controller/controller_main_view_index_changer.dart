import 'package:flutter/cupertino.dart';

class MainViewIndexChanger extends ChangeNotifier
{
  int index = 0;
  int getIndex()
  {
    return index;
  }

  update(int newVal)
  {
    index = newVal;
    notifyListeners();
  }
}