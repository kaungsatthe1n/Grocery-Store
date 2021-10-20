import 'package:flutter/material.dart';
import 'package:grocery_store/components/grocery_tile.dart';
import 'package:grocery_store/models/grocery_manager.dart';
import 'package:grocery_store/screens/grocery_item_screen.dart';

class GroceryListScreen extends StatelessWidget {
  const GroceryListScreen({Key? key, required this.groceryManager})
      : super(key: key);
  final GroceryManager groceryManager;

  @override
  Widget build(BuildContext context) {
    print('grocery list screen');
    final groceryItems = groceryManager.groceryItems;
// 2
    return Padding(
      padding: const EdgeInsets.all(16.0),
// 3
      child: ListView.separated(
        itemCount: groceryItems.length,
        itemBuilder: (context, index) {
          final item = groceryItems[index];

          return Dismissible(
            key: Key(item.id),
            onDismissed: (direction) {
              groceryManager.deleteItem(index);
              var recycleItem = groceryItems[index];
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('${item.name} dismissed '),
                action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      groceryManager.addItem(recycleItem);
                    }),
              ));
            },
            background: Container(
              color: Colors.red,
              child: const Icon(
                Icons.delete_forever,
                color: Colors.white,
              ),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroceryItemScreen(
                      originalItem: item,
                      // 3
                      onUpdate: (item) {
                        // 4
                        groceryManager.updateItem(item, index);
                        // 5
                        Navigator.pop(context);
                      },
                      // 6
                      onCreate: (item) {},
                    ),
                  ),
                );
              },
              child: GroceryTile(
                key: Key(item.id),
                item: item,
                // 6
                onComplete: (change) {
                  // 7
                  if (change != null) {
                    groceryManager.completeItem(index, change);
                  }
                },
              ),
            ),
          );
        },
// 8
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16.0);
        },
      ),
    );
  }
}
