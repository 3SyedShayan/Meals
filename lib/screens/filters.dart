import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  FiltersScreen({super.key, required this.currentFilters});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
  Map<Filter, bool> currentFilters;
}

enum Filter { Gluten, Vegetarian, Lactose, Vegan }

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFilter = false;
  bool _vegetarianFilter = false;
  bool _lactoseFilter = false;
  bool _veganFilter = false;
  @override
  @override
  void initState() {
    super.initState();
    _glutenFilter = widget.currentFilters[Filter.Gluten]!;
    _lactoseFilter = widget.currentFilters[Filter.Lactose]!;
    _veganFilter = widget.currentFilters[Filter.Vegan]!;
    _vegetarianFilter = widget.currentFilters[Filter.Vegetarian]!;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filters"),
      ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          print(didPop);
          if (didPop) return;
          Navigator.of(context).pop({
            Filter.Gluten: _glutenFilter,
            Filter.Lactose: _lactoseFilter,
            Filter.Vegan: _veganFilter,
            Filter.Vegetarian: _vegetarianFilter
          });
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _glutenFilter,
              onChanged: (onChanged) {
                setState(() {
                  _glutenFilter = onChanged;
                });
              },
              title: Text("Gluten-Free"),
              subtitle: Text(
                "Only include gluten-free meals.",
              ),
            ),
            SwitchListTile(
              value: _vegetarianFilter,
              onChanged: (onChanged) {
                setState(() {
                  _vegetarianFilter = onChanged;
                });
              },
              title: Text("Vegetarian-Free"),
              subtitle: Text(
                "Only include Vegetarian-free meals.",
              ),
            ),
            SwitchListTile(
              value: _lactoseFilter,
              onChanged: (onChanged) {
                setState(() {
                  _lactoseFilter = onChanged;
                });
              },
              title: Text("Lactose-Free"),
              subtitle: Text(
                "Only include Lactose-free meals.",
              ),
            ),
            SwitchListTile(
              value: _veganFilter,
              onChanged: (onChanged) {
                setState(() {
                  _veganFilter = onChanged;
                });
              },
              title: Text("Vegan-Free"),
              subtitle: Text(
                "Only include Vegan-free meals.",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
