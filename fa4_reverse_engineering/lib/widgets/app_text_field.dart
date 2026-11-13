import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final int? maxLength;
  final bool underline;
  final String? prefixText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  const AppTextField({
    super.key, 
    required this.controller,
    required this.label,
    this.maxLength,
    this.underline =  false,
    this.prefixText,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.onChanged,   
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,   
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        prefixText: prefixText,
        border: underline ? const UnderlineInputBorder() : null,
        enabledBorder: underline ? const UnderlineInputBorder() : null,
        focusedBorder: underline ? const UnderlineInputBorder() : null,
        floatingLabelBehavior:
            underline ? FloatingLabelBehavior.always : FloatingLabelBehavior.auto,
      ),
    );   
  }
}
