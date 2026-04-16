import 'package:flutter/material.dart';

/// Configuration for full-screen text field editing mode.
///
/// This class provides customization options for the full-screen editing
/// experience that activates in landscape orientation or when explicitly
/// triggered by the user.
///
/// The full-screen mode provides an expanded editing interface ideal for
/// landscape viewing, with customizable decorations, keyboard appearance,
/// and validation behavior.
///
/// Example:
/// ```dart
/// FullScreenFieldConfig(
///   decoration: InputDecoration(
///     labelText: 'Enter your password',
///     hintText: 'Password',
///   ),
///   doneText: 'Confirm',
///   obscureText: true,
///   withObscureToggle: true,
///   enableFormValidation: true,
/// )
/// ```
class FullScreenFieldConfig {
  /// Custom decoration for the text field in full-screen mode.
  ///
  /// If null, the decoration from the parent [OrientTextField] or
  /// [OrientTextFormField] will be used. This allows you to override
  /// the appearance specifically for full-screen mode.
  final InputDecoration? decoration;

  /// The appearance mode for the keyboard in full-screen mode.
  ///
  /// Determines whether the keyboard appears in light or dark mode.
  /// If null, the keyboard appearance follows the system settings.
  /// Platform-specific and respects [MediaQuery.platformBrightness].
  final Brightness? keyboardAppearance;

  /// Text label for the done button in full-screen mode.
  ///
  /// Displayed as the action button to dismiss the full-screen editor.
  /// Defaults to "Done".
  final String doneText;

  /// Whether to obscure the text input in full-screen mode.
  ///
  /// If null, the [obscureText] setting from the parent field is used.
  /// When true, hides the input characters behind obscuring characters
  /// (default: '•'). Useful for password fields.
  final bool? obscureText;

  /// Whether to show a visibility toggle button in full-screen mode.
  ///
  /// When true, displays a button to toggle text obscuring on and off.
  /// Only effective when [obscureText] is true.
  /// Defaults to false.
  final bool withObscureToggle;

  /// Icon displayed when text is visible (not obscured).
  ///
  /// Shown in the visibility toggle button. Defaults to [Icons.visibility].
  /// Only used when [withObscureToggle] is true.
  final Widget obscureEnabedIcon;

  /// Icon displayed when text is obscured (hidden).
  ///
  /// Shown in the visibility toggle button. Defaults to [Icons.password].
  /// Only used when [withObscureToggle] is true.
  final Widget obscureDisabledIcon;

  /// Whether to enable form validation in full-screen mode.
  ///
  /// This option only applies when using [OrientTextFormField].
  /// When true, form validators will run in full-screen mode.
  /// When false or null, validation is disabled in full-screen mode.
  /// Ignored when used with [OrientTextField].
  final bool? enableFormValidation;

  /// Whether the full-screen editor should invoke [onFieldSubmitted]
  /// when the user taps the done button.
  ///
  /// This only affects full-screen editing mode. If false, the dialog
  /// closes without submitting via [onFieldSubmitted].
  /// Defaults to true.
  final bool submitOnDone;

  /// Creates a configuration for full-screen field editing.
  ///
  /// All parameters are optional and default to sensible values.
  ///
  /// Parameters:
  ///   - [decoration]: Custom field decoration for full-screen mode
  ///   - [keyboardAppearance]: Keyboard appearance (light/dark)
  ///   - [doneText]: Label for the done button (default: "Done")
  ///   - [obscureText]: Whether to obscure text in full-screen mode
  ///   - [withObscureToggle]: Show visibility toggle (default: false)
  ///   - [obscureEnabedIcon]: Icon when text is visible (default: Icons.visibility)
  ///   - [obscureDisabledIcon]: Icon when text is hidden (default: Icons.password)
  ///   - [enableFormValidation]: Enable validation in full-screen mode
  ///     (only for OrientTextFormField)
  ///   - [submitOnDone]: Submit via [onFieldSubmitted] when the done
  ///     button in the full-screen editor is pressed.
  const FullScreenFieldConfig({
    this.decoration,
    this.keyboardAppearance,
    this.doneText = "Done",
    this.obscureText,
    this.withObscureToggle = false,
    this.obscureEnabedIcon = const Icon(Icons.visibility),
    this.obscureDisabledIcon = const Icon(Icons.password),
    this.enableFormValidation,
    this.submitOnDone = true,
  });
}
