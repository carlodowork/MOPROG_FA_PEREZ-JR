import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_constants.dart';
import '../models/parameter.dart';
import '../state/inventory_store.dart';
import '../widgets/app_text_field.dart';
import '../widgets/color_swatch_box.dart';
import '../widgets/color_wheel.dart';

class AddParameterScreen extends StatefulWidget {
  const AddParameterScreen({super.key});

  @override
  State<AddParameterScreen> createState() => _AddParameterScreenState();
}

class _AddParameterScreenState extends State<AddParameterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _classController = TextEditingController();
  Color _color = AppColors.defaultParameterColor;

  @override
  void dispose() {
    _nameController.dispose();
    _classController.dispose();
    super.dispose();
  }

  String get _hex =>
      _color.toARGB32().toRadixString(16).toUpperCase().padLeft(8, '0');

  void _reset() {
    _formKey.currentState?.reset();
    setState(() {
      _nameController.clear();
      _classController.clear();
      _color = AppColors.defaultParameterColor;
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<InventoryStore>().addParameter(Parameter(
          name: _nameController.text.trim(),
          className: _classController.text.trim(),
          color: _color,
        ));
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text(AppStrings.parameterAdded)));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final store = context.read<InventoryStore>();
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.addParameterTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                controller: _nameController,
                label: AppStrings.parameterName,
                maxLength: AppLimits.maxTextLength,
                underline: true,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return AppStrings.errNameRequired;
                  }
                  if (store.parameterNameExists(v)) {
                    return AppStrings.errNameExists;
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.sm),
              Align(
                alignment: Alignment.centerRight,
                child: ColorWheel(
                  color: _color,
                  onChanged: (c) => setState(() => _color = c),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: AppTextField(
                      controller: _classController,
                      label: AppStrings.parameterClass,
                      maxLength: AppLimits.maxTextLength,
                      underline: true,
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? AppStrings.errClassRequired
                          : null,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.lg),
                      child: Row(
                        children: [
                          ColorSwatchBox(color: _color),
                          const SizedBox(width: AppSpacing.xs),
                          Flexible(child: Text(_hex)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _reset,
                    child: const Text(AppStrings.reset),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  FilledButton(
                    onPressed: _submit,
                    child: const Text(AppStrings.addParameter),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
