import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orient_text_field/src/full_screen_field_config.dart';
import 'package:orient_text_field/src/orient_input.dart';

/// An orientation-aware text field widget.
///
/// [OrientTextField] is a drop-in replacement for Flutter's standard [TextField]
/// that automatically provides full-screen editing capabilities in landscape
/// orientation. It accepts all the same parameters as [TextField] with the
/// addition of [fullScreenFieldConfig] for customizing the full-screen experience.
///
/// **Key Features:**
/// - Automatic full-screen editing in landscape orientation
/// - Seamless orientation handling without losing focus or text
/// - Customizable full-screen appearance and behavior
/// - Drop-in replacement - no code changes required beyond the class name
///
/// **Setup Requirements:**
/// Your app must be wrapped with [KeyboardStatusProvider] for this widget
/// to function correctly:
///
/// ```dart
/// void main() {
///   runApp(const MyApp());
/// }
///
/// class MyApp extends StatelessWidget {
///   const MyApp({super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     return KeyboardStatusProvider(  // <-- Required
///       child: MaterialApp(
///         home: Scaffold(
///           body: OrientTextField(
///             decoration: InputDecoration(labelText: 'Enter text'),
///           ),
///         ),
///       ),
///     );
///   }
/// }
/// ```
///
/// **Migration from TextField:**
/// Simply replace `TextField` with `OrientTextField` in your existing code.
/// All parameters work identically:
///
/// ```dart
/// // Before
/// TextField(
///   controller: myController,
///   decoration: InputDecoration(labelText: 'Name'),
///   maxLines: 3,
/// )
///
/// // After - Just change the class name
/// OrientTextField(
///   controller: myController,
///   decoration: InputDecoration(labelText: 'Name'),
///   maxLines: 3,
/// )
/// ```
///
/// **Note:** The `onTap` parameter is reserved for internal functionality
/// and cannot be customized.
///
/// See also:
/// - [TextField], the standard Flutter text field widget
/// - [OrientTextFormField], the form field version of this widget
/// - [FullScreenFieldConfig], for customizing full-screen behavior
class OrientTextField extends StatelessWidget {
  /// Creates an orientation-aware text field.
  ///
  /// All parameters are identical to [TextField] except for [fullScreenFieldConfig].
  /// For documentation on standard parameters, see [TextField.new].
  ///
  /// The [fullScreenFieldConfig] parameter allows customization of the
  /// full-screen editing experience that activates in landscape orientation.
  const OrientTextField({
    super.key,
    this.groupId = EditableText,
    this.controller,
    this.focusNode,
    this.decoration = const InputDecoration(),
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.style,
    this.strutStyle,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.autofocus = false,
    this.readOnly = false,
    this.toolbarOptions,
    this.showCursor,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.maxLengthEnforcement,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.onChanged,
    this.onTapOutside,
    this.onTapUpOutside,
    this.onEditingComplete,
    this.onSubmitted,
    this.validator,
    this.inputFormatters,
    this.enabled,
    this.ignorePointers,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.cursorErrorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection,
    this.selectAllOnFocus,
    this.selectionControls,
    this.buildCounter,
    this.scrollPhysics,
    this.autofillHints,
    this.scrollController,
    this.restorationId,
    this.enableIMEPersonalizedLearning = true,
    this.mouseCursor,
    this.contextMenuBuilder = _defaultContextMenuBuilder,
    this.spellCheckConfiguration,
    this.magnifierConfiguration,
    this.undoController,
    this.onAppPrivateCommand,
    this.cursorOpacityAnimates,
    this.selectionHeightStyle,
    this.selectionWidthStyle,
    this.dragStartBehavior = DragStartBehavior.start,
    this.contentInsertionConfiguration,
    this.statesController,
    this.clipBehavior = Clip.hardEdge,
    this.scribbleEnabled = true,
    this.stylusHandwritingEnabled =
        EditableText.defaultStylusHandwritingEnabled,
    this.canRequestFocus = true,
    this.hintLocales,
    this.fullScreenFieldConfig = const FullScreenFieldConfig(),
  });

  final Object groupId;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final bool autofocus;
  final bool readOnly;
  // @Deprecated(
  //   'Use `contextMenuBuilder` instead. '
  //   'This feature was deprecated after v3.3.0-0.5.pre.',
  // )
  final ToolbarOptions? toolbarOptions;
  final bool? showCursor;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool enableSuggestions;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final TapRegionCallback? onTapOutside;
  final TapRegionUpCallback? onTapUpOutside;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final bool? ignorePointers;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final Color? cursorErrorColor;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool? enableInteractiveSelection;
  final bool? selectAllOnFocus;
  final TextSelectionControls? selectionControls;
  final InputCounterWidgetBuilder? buildCounter;
  final ScrollPhysics? scrollPhysics;
  final Iterable<String>? autofillHints;
  final ScrollController? scrollController;
  final String? restorationId;
  final bool enableIMEPersonalizedLearning;
  final MouseCursor? mouseCursor;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final SpellCheckConfiguration? spellCheckConfiguration;
  final TextMagnifierConfiguration? magnifierConfiguration;
  final UndoHistoryController? undoController;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final bool? cursorOpacityAnimates;
  final ui.BoxHeightStyle? selectionHeightStyle;
  final ui.BoxWidthStyle? selectionWidthStyle;
  final DragStartBehavior dragStartBehavior;
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  final MaterialStatesController? statesController;
  final Clip clipBehavior;
  // @Deprecated(
  //   'Use `stylusHandwritingEnabled` instead. '
  //   'This feature was deprecated after v3.27.0-0.2.pre.',
  // )
  final bool scribbleEnabled;
  final bool stylusHandwritingEnabled;
  final bool canRequestFocus;
  final List<Locale>? hintLocales;

  /// Configuration for full-screen editing mode.
  ///
  /// This parameter is specific to [OrientTextField] and controls the behavior
  /// and appearance of the text field when it switches to full-screen mode
  /// in landscape orientation.
  ///
  /// The full-screen mode provides:
  /// - Expanded editing interface optimized for landscape viewing
  /// - Customizable decorations, keyboard appearance, and validation
  /// - Automatic activation based on device orientation
  ///
  /// Example:
  /// ```dart
  /// OrientTextField(
  ///   decoration: InputDecoration(labelText: 'Password'),
  ///   obscureText: true,
  ///   fullScreenFieldConfig: FullScreenFieldConfig(
  ///     doneText: 'Save',
  ///     withObscureToggle: true,
  ///     keyboardAppearance: Brightness.dark,
  ///   ),
  /// )
  /// ```
  ///
  /// Defaults to [FullScreenFieldConfig] with default values.
  final FullScreenFieldConfig fullScreenFieldConfig;

  static Widget _defaultContextMenuBuilder(
    BuildContext context,
    EditableTextState editableTextState,
  ) {
    if (SystemContextMenu.isSupportedByField(editableTextState)) {
      return SystemContextMenu.editableText(
        editableTextState: editableTextState,
      );
    }
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }

  @override
  Widget build(BuildContext context) {
    return OrientInput(
      isFormField: false,
      controller: controller,
      focusNode: focusNode,
      groupId: groupId,
      decoration: decoration,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      style: style,
      strutStyle: strutStyle,
      textDirection: textDirection,
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      autofocus: autofocus,
      readOnly: readOnly,
      toolbarOptions: toolbarOptions,
      showCursor: showCursor,
      obscuringCharacter: obscuringCharacter,
      obscureText: obscureText,
      autocorrect: autocorrect,
      smartDashesType: smartDashesType,
      smartQuotesType: smartQuotesType,
      enableSuggestions: enableSuggestions,
      maxLengthEnforcement: maxLengthEnforcement,
      maxLines: maxLines,
      minLines: minLines,
      expands: expands,
      maxLength: maxLength,
      onChanged: onChanged,
      onTapOutside: onTapOutside,
      onTapUpOutside: onTapUpOutside,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onSubmitted,
      inputFormatters: inputFormatters,
      enabled: enabled,
      ignorePointers: ignorePointers,
      cursorWidth: cursorWidth,
      cursorHeight: cursorHeight,
      cursorRadius: cursorRadius,
      cursorColor: cursorColor,
      cursorErrorColor: cursorErrorColor,
      keyboardAppearance: keyboardAppearance,
      scrollPadding: scrollPadding,
      enableInteractiveSelection: enableInteractiveSelection,
      selectAllOnFocus: selectAllOnFocus,
      selectionControls: selectionControls,
      buildCounter: buildCounter,
      scrollPhysics: scrollPhysics,
      autofillHints: autofillHints,
      scrollController: scrollController,
      restorationId: restorationId,
      enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
      mouseCursor: mouseCursor,
      contextMenuBuilder: contextMenuBuilder,
      spellCheckConfiguration: spellCheckConfiguration,
      magnifierConfiguration: magnifierConfiguration,
      undoController: undoController,
      onAppPrivateCommand: onAppPrivateCommand,
      cursorOpacityAnimates: cursorOpacityAnimates,
      selectionHeightStyle: selectionHeightStyle,
      selectionWidthStyle: selectionWidthStyle,
      dragStartBehavior: dragStartBehavior,
      contentInsertionConfiguration: contentInsertionConfiguration,
      statesController: statesController,
      clipBehavior: clipBehavior,
      scribbleEnabled: scribbleEnabled,
      stylusHandwritingEnabled: stylusHandwritingEnabled,
      canRequestFocus: canRequestFocus,
      hintLocales: hintLocales,
      fullScreenFieldConfig: fullScreenFieldConfig,
    );
  }
}
