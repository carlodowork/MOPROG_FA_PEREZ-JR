import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class QuantityStepper extends StatelessWidget {
  final String label;
  final int value;
  final int min;
  final ValueChanged<int> onChanged;

  const QuantityStepper({
    super.key,  
    required this.label,
    required this.value,
    required this.onChanged,
    this.min = AppLimits.minQuantity,   
  });

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: value > min  ? () => onChanged(value - 1) : null,
          ),
          Expanded(
            child: Text(
              '$value',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => onChanged(value + 1),  
          ),
        ],
      ),
    );
  }
}