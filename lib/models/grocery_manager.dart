import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grocery_store/models/grocery_item.dart';

class GroceryManager extends ChangeNotifier {
  List<GroceryItem> _groceryItems = [
    // GroceryItem(
    //   color: Colors.amber,
    //   date: DateTime.now(),
    //   id: '1',
    //   importance: Importance.high,
    //   name: 'name',
    //   quantity: 2,
    // )
  ];

  List<GroceryItem> get groceryItems => List.unmodifiable(_groceryItems);

  void deleteItem(int index) {
    _groceryItems.removeAt(index);
    notifyListeners();
  }

  void addItem(GroceryItem item) {
    _groceryItems.add(item);
    notifyListeners();
  }

  void updateItem(GroceryItem item, int index) {
    _groceryItems[index] = item;
    notifyListeners();
  }

  void completeItem(int index, bool change) {
    final GroceryItem item = _groceryItems[index];
    _groceryItems[index] = item.copyWith(isComplete: change);
    notifyListeners();
  }
}
