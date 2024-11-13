import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? label;
  final String? hintText;
  final bool filled;
  final Color? filledColor;
  final String? errorText;
  final bool? obscurteText;

  const CustomTextFormField(
      {super.key,
      this.onChanged,
      this.validator,
      this.label,
      this.hintText,
      required this.filled,
      this.filledColor,
      this.errorText,
      this.obscurteText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        label: label != null ? Text(label!) : null,
        labelStyle: const TextStyle(color: Colors.black),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.withOpacity(0.8)),
        filled: filled,
        fillColor: filledColor ?? Colors.grey.withOpacity(0.15),
        errorText: errorText,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0 * 1.5, vertical: 16.0),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.greenAccent, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      obscureText: obscurteText ?? false,
      keyboardType: TextInputType.visiblePassword,
      onChanged: onChanged,
      validator: validator,
      onSaved: (phone) {
        // Save it
      },
    );
  }
}
