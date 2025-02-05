import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer({
    super.key,
    required this.onDrawerSelection,
  });

  void Function(String identifier) onDrawerSelection;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.fastfood,
                  size: 45,
                ),
                SizedBox(width: 15),
                Text(
                  "Cooking Up!",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              onDrawerSelection('meals');
            },
            leading: Icon(Icons.restaurant),
            title: Text("Meals"),
          ),
          ListTile(
            onTap: () {
              onDrawerSelection('filters');
            },
            leading: Icon(Icons.settings),
            title: Text("Filters"),
          ),
        ],
      ),
    );
  }
}
