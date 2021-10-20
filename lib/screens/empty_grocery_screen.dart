import 'package:flutter/material.dart';
import 'package:grocery_store/models/tab_manager.dart';
import 'package:provider/provider.dart';


class EmptyGroceryScreen extends StatelessWidget {
  const EmptyGroceryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Empty Screen build method');
    return Center(
      child: Column(
        children: [
          Flexible(
              child: AspectRatio(
            aspectRatio: 1.1,
            child: ClipRRect(
              child: Image.network(
                'https://st2.depositphotos.com/1005049/50725/v/1600/depositphotos_507255450-stock-illustration-data-result-data-found-concept.jpg',
                fit: BoxFit.cover,
              ),
            ),
          )),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'No Groceries',
            style: TextStyle(fontSize: 22.0),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Shopping for ingredients?\n'
            'Tap the + button to write them down!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
            textColor: Colors.white,
            child: const Text('Browse Recipes'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            color: Colors.green,
            onPressed: () {},
          ),
          
        ],
      ),
    );
  }
}
