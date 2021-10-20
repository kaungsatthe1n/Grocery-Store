import 'package:flutter/material.dart';
import 'package:grocery_store/models/grocery_manager.dart';
import 'package:grocery_store/screens/empty_grocery_screen.dart';
import 'package:grocery_store/screens/grocery_item_screen.dart';
import 'package:grocery_store/screens/grocery_list_screen.dart';
import 'package:provider/provider.dart';

Widget buildGroceryScreen() {
  return Consumer<GroceryManager>(
    builder: (context, manager, child) {
      if (manager.groceryItems.isNotEmpty) {
        return GroceryListScreen(
          groceryManager: manager,
        );
      } else {
        return const EmptyGroceryScreen();
      }
    },
  );
}

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('grocery screen');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final manager = Provider.of<GroceryManager>(context, listen: false);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => GroceryItemScreen(
                    onCreate: (item) {
                      manager.addItem(item);
                      Navigator.of(context).pop();
                    },
                    onUpdate: (item) {},
                  )));
        },
        child: const Icon(Icons.add),
      ),
      body: buildGroceryScreen(),
    );
  }
}
