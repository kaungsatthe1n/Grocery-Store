import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_store/models/grocery_manager.dart';
import 'package:grocery_store/models/tab_manager.dart';
import 'package:grocery_store/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => TabManager(),
          ),
          ChangeNotifierProvider(
            create: (_) => GroceryManager(),
          ),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        )),
  );
}
