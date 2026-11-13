import 'package:flutter/material.dart';

import  '../constants/app_constants.dart';
import '../models/supply.dart';
import 'color_swatch_box.dart';

class SupplyTile extends StatelessWidget {
  final Supply supply;
  const SupplyTile({super.key, required this.supply});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ColorSwatchBox(color: supply.parameter.color),
      title: Text(supply.name),
      subtitle: Text(
        '${supply.parameter.name} • ${supply.quantity} x \$${supply.unitPrice.toStringAsFixed(2)}',
      ),  
      trailing: Text(
        '\$${supply.total.toStringAsFixed(2)}',
        style: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
