import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_constants.dart';
import '../state/inventory_store.dart';
import '../widgets/supply_tile.dart';
import 'add_parameter_screen.dart';
import 'add_supply_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _open(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_)  => screen));
  }

  @override
  Widget build(BuildContext context) {
    final supplies = context.watch<InventoryStore>().supplies;  
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.homeTitle)),
      body: supplies.isEmpty
          ? const Center(
              child: Text(AppStrings.emptySupplies, textAlign: TextAlign.center),
            )
          : ListView.builder(
              itemCount:  supplies.length,
              itemBuilder: (_, i) => SupplyTile(supply: supplies[i]),
            ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: ()  => _open(context, const AddParameterScreen()),
                child: const Text(AppStrings.addParameter),
              ),
              const SizedBox(width: AppSpacing.sm),
              FilledButton(
                onPressed: () => _open(context, const AddSupplyScreen()),   
                child: const Text(AppStrings.addSupply),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
