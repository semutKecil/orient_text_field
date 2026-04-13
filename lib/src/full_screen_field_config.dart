import 'package:flutter/material.dart';

class FullScreenFieldConfig {
  final InputDecoration? decoration;
  final Brightness? keyboardAppearance;
  final String doneText;
  final bool? obscureText;
  final bool withObscureToggle;
  final Widget obscureEnabedIcon;
  final Widget obscureDisabledIcon;
  final bool? enableFormValidation;

  const FullScreenFieldConfig({
    this.decoration,
    this.keyboardAppearance,
    this.doneText = "Done",
    this.obscureText,
    this.withObscureToggle = false,
    this.obscureEnabedIcon = const Icon(Icons.visibility),
    this.obscureDisabledIcon = const Icon(Icons.password),
    this.enableFormValidation,
  });
}
