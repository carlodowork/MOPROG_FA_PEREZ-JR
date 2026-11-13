import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../constants/app_constants.dart';
import '../models/parameter.dart';
import '../models/supply.dart';
import '../state/inventory_store.dart';
import '../widgets/app_text_field.dart';
import '../widgets/color_swatch_box.dart';
import '../widgets/quantity_stepper.dart';

class AddSupplyScreen extends StatefulWidget {
  const AddSupplyScreen({super.key});

  @override
  State<AddSupplyScreen> createState() => _AddSupplyScreenState();
}

class _AddSupplyScreenState extends State<AddSupplyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController(text: AppLimits.defaultPrice);
  int _quantity = AppLimits.defaultQuantity;
  Parameter? _selected;
  String? _parameterError;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _submit() {
    final formOk = _formKey.currentState!.validate();
    setState(() => _parameterError =
        _selected == null ? AppStrings.errParameterRequired : null);
    if (!formOk || _selected == null) return;

    context.read<InventoryStore>().addSupply(Supply(
          name: _nameController.text.trim(),
          quantity: _quantity,
          unitPrice: double.parse(_priceController.text),
          parameter: _selected!,
        ));
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text(AppStrings.supplyAdded)));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final parameters = context.watch<InventoryStore>().parameters;
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.addSupplyTitle)),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.formSidePadding,
            vertical: AppSpacing.xl,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AppTextField(
                  controller: _nameController,
                  label: AppStrings.itemName,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? AppStrings.errItemRequired
                      : null,
                ),
                const SizedBox(height: AppSpacing.fieldGap),
                QuantityStepper(
                  label: AppStrings.itemQuantity,
                  value: _quantity,
                  onChanged: (v) => setState(() => _quantity = v),
                ),
                const SizedBox(height: AppSpacing.fieldGap),
                AppTextField(
                  controller: _priceController,
                  label: AppStrings.unitPrice,
                  prefixText: '\$ ',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                  ],
                  validator: (v) {
                    final price = double.tryParse(v ?? '');
                    return (price == null || price <= 0)
                        ? AppStrings.errPriceInvalid
                        : null;
                  },
                ),
                const SizedBox(height: AppSpacing.fieldGap),
                DropdownMenu<Parameter>(
                  width: constraints.maxWidth - AppSpacing.formSidePadding * 2,
                  label: const Text(AppStrings.parameterPicker),
                  errorText: _parameterError,
                  onSelected: (p) => setState(() {
                    _selected = p;
                    _parameterError = null;
                  }),
                  dropdownMenuEntries: [
                    for (final p in parameters)
                      DropdownMenuEntry<Parameter>(
                        value: p,
                        label: p.name,
                        leadingIcon: ColorSwatchBox(color: p.color),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton(
                    onPressed: _submit,
                    child: const Text(AppStrings.addSupply),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
