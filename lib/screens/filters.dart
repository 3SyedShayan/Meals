import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  FiltersScreen({super.key, required this.currentFilters});

  @override
  ConsumerState<FiltersScreen> createState() => _FiltersScreenState();
  Map<Filter, bool> currentFilters;
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  bool _glutenFilter = false;
  bool _vegetarianFilter = false;
  bool _lactoseFilter = false;
  bool _veganFilter = false;
  @override
  void initState() {
    super.initState();
    final activeFilters = ref.read(filterProvider);
    _glutenFilter = activeFilters[Filter.Gluten]!;
    _lactoseFilter = activeFilters[Filter.Lactose]!;
    _veganFilter = activeFilters[Filter.Vegan]!;
    _vegetarianFilter = activeFilters[Filter.Vegetarian]!;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filters"),
      ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, did) async {
          ref.read(filterProvider.notifier).setFilters({
            Filter.Gluten: _glutenFilter,
            Filter.Lactose: _lactoseFilter,
            Filter.Vegan: _veganFilter,
            Filter.Vegetarian: _vegetarianFilter
          });
          Navigator.pop(context);
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
