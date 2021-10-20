import 'package:flutter/material.dart';
import 'package:grocery_store/models/grocery_manager.dart';
import 'package:grocery_store/models/tab_manager.dart';
import 'package:grocery_store/screens/empty_grocery_screen.dart';
import 'package:grocery_store/screens/grocery_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> pages = [
    Container(
      color: Colors.indigo.shade400,
    ),
    Container(
      color: Colors.tealAccent.shade400,
    ),
    const GroceryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print('home_screen build method');
    // Provider.of<TabManager>(context, listen: false).goToRecipes();
    return Consumer<TabManager>(
      builder: (BuildContext context, tabManager, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Grocery Store'),
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.lightBlue,
            onTap: (index) {
              tabManager.goToTab(index);
            },
            currentIndex: tabManager.selectedTab,
            items: const [
              BottomNavigationBarItem(
                  label: 'Explore',
                  icon: Icon(
                    Icons.explore,
                  )),
              BottomNavigationBarItem(
                  label: 'Receipt',
                  icon: Icon(
                    Icons.receipt,
                  )),
              BottomNavigationBarItem(
                  label: 'Lists',
                  icon: Icon(
                    Icons.list_alt,
                  )),
            ],
          ),
          body: IndexedStack(
            index: tabManager.selectedTab,
            children: pages,
          ),
        );
      },
    );
  }
}
