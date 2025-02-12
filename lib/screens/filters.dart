import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  FiltersScreen({super.key, required this.currentFilters});

  Map<Filter, bool> currentFilters;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readValues = ref.watch(filterProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Filters"),
      ),
      body: Column(
        children: [
          SwitchListTile(
            value: readValues[Filter.Gluten]!,
            onChanged: (onChanged) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filter.Gluten, onChanged);
              print("onChanged: $onChanged");
            },
            title: Text("Gluten-Free"),
            subtitle: Text(
              "Only include gluten-free meals.",
            ),
          ),
          SwitchListTile(
            value: readValues[Filter.Vegetarian]!,
            onChanged: (onChanged) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filter.Vegetarian, onChanged);
            },
            title: Text("Vegetarian-Free"),
            subtitle: Text(
              "Only include Vegetarian-free meals.",
            ),
          ),
          SwitchListTile(
            value: readValues[Filter.Lactose]!,
            onChanged: (onChanged) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filter.Lactose, onChanged);
            },
            title: Text("Lactose-Free"),
            subtitle: Text(
              "Only include Lactose-free meals.",
            ),
          ),
          SwitchListTile(
            value: readValues[Filter.Vegan]!,
            onChanged: (onChanged) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filter.Vegan, onChanged);
            },
            title: Text("Vegan-Free"),
            subtitle: Text(
              "Only include Vegan-free meals.",
            ),
          ),
        ],
      ),
    );
  }
}
