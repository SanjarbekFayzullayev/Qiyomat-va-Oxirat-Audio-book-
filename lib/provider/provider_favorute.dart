import 'package:qiyomat_va_oxirat/constants/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavProvider extends ChangeNotifier{

   bool _isItemSelected = false;
  int _selectedItemIndex = 0;

  void setItemIndex(value) {
    _selectedItemIndex = value;
  }



  int getItemIndex() {
    return _selectedItemIndex;
  }

  bool getItemSelected() {
    return _isItemSelected;
  }

  void langChanged() {
    notifyListeners();
  }

  //sav List
   setFavourite(int index) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setInt(Constants().cey, index);
   }
   Future<int?> getFavourite() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     if (prefs.containsKey(Constants().cey)) {
       return prefs.getInt(Constants().cey);
     }
     return null;
   }


  savFavList(List<int> indexes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      Constants().cey,
      indexes.map((e) => e.toString()).toList(),
    );
    notifyListeners();
  }

  Future<List<int>> getFavList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? res = prefs.getStringList(Constants().cey);
    if (res != null) {
      return res.map((e) => int.parse(e)).toList();
    }
    return List.empty();
  }

}