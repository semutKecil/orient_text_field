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

  /// {@macro flutter.widgets.editableText.groupId}
  final Object groupId;

  /// {@macro flutter.widgets.editableText.controller}
  final TextEditingController? controller;

  /// {@macro flutter.widgets.editableText.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.editableText.decoration}
  final InputDecoration? decoration;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType? keyboardType;

  /// {@macro flutter.widgets.editableText.textCapitalization}
  final TextCapitalization textCapitalization;

  /// {@macro flutter.widgets.editableText.textInputAction}
  final TextInputAction? textInputAction;

  /// {@macro flutter.widgets.editableText.style}
  final TextStyle? style;

  /// {@macro flutter.widgets.editableText.strutStyle}
  final StrutStyle? strutStyle;

  /// {@macro flutter.widgets.editableText.textDirection}
  final TextDirection? textDirection;

  /// {@macro flutter.widgets.editableText.textAlign}
  final TextAlign textAlign;

  /// {@macro flutter.widgets.editableText.textAlignVertical}
  final TextAlignVertical? textAlignVertical;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;
  // @Deprecated(
  //   'Use `contextMenuBuilder` instead. '
  //   'This feature was deprecated after v3.3.0-0.5.pre.',
  // )
  /// {@macro flutter.widgets.editableText.toolbarOptions}
  final ToolbarOptions? toolbarOptions;

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool? showCursor;

  /// {@macro flutter.widgets.editableText.obscuringCharacter}
  final String obscuringCharacter;

  /// {@macro flutter.widgets.editableText.obscureText}
  final bool obscureText;

  /// {@macro flutter.widgets.editableText.autocorrect}
  final bool autocorrect;

  /// {@macro flutter.widgets.editableText.smartDashesType}
  final SmartDashesType? smartDashesType;

  /// {@macro flutter.widgets.editableText.smartQuotesType}
  final SmartQuotesType? smartQuotesType;

  /// {@macro flutter.widgets.editableText.enableSuggestions}
  final bool enableSuggestions;

  /// {@macro flutter.widgets.editableText.maxLengthEnforcement}
  final MaxLengthEnforcement? maxLengthEnforcement;

  /// {@macro flutter.widgets.editableText.maxLines}
  final int? maxLines;

  /// {@macro flutter.widgets.editableText.minLines}
  final int? minLines;

  /// {@macro flutter.widgets.editableText.expands}
  final bool expands;

  /// {@macro flutter.widgets.editableText.maxLength}
  final int? maxLength;

  /// {@macro flutter.widgets.editableText.onChanged}
  final ValueChanged<String>? onChanged;

  /// {@macro flutter.widgets.editableText.onTapOutside}
  final TapRegionCallback? onTapOutside;

  /// {@macro flutter.widgets.editableText.onTapUpOutside}
  final TapRegionUpCallback? onTapUpOutside;

  /// {@macro flutter.widgets.editableText.onEditingComplete}
  final VoidCallback? onEditingComplete;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  /// {@macro flutter.widgets.editableText.enabled}
  final bool? enabled;

  /// {@macro flutter.widgets.editableText.ignorePointers}
  final bool? ignorePointers;

  /// {@macro flutter.widgets.editableText.cursorWidth}
  final double cursorWidth;

  /// {@macro flutter.widgets.editableText.cursorHeight}
  final double? cursorHeight;

  /// {@macro flutter.widgets.editableText.cursorRadius}
  final Radius? cursorRadius;

  /// {@macro flutter.widgets.editableText.cursorColor}
  final Color? cursorColor;

  /// {@macro flutter.widgets.editableText.cursorErrorColor}
  final Color? cursorErrorColor;

  /// {@macro flutter.widgets.editableText.keyboardAppearance}
  final Brightness? keyboardAppearance;

  /// {@macro flutter.widgets.editableText.scrollPadding}
  final EdgeInsets scrollPadding;

  /// {@macro flutter.widgets.editableText.enableInteractiveSelection}
  final bool? enableInteractiveSelection;

  /// {@macro flutter.widgets.editableText.selectAllOnFocus}
  final bool? selectAllOnFocus;

  /// {@macro flutter.widgets.editableText.selectionControls}
  final TextSelectionControls? selectionControls;

  /// {@macro flutter.widgets.editableText.buildCounter}
  final InputCounterWidgetBuilder? buildCounter;

  /// {@macro flutter.widgets.editableText.scrollPhysics}
  final ScrollPhysics? scrollPhysics;

  /// {@macro flutter.widgets.editableText.autofillHints}
  final Iterable<String>? autofillHints;

  /// {@macro flutter.widgets.editableText.scrollController}
  final ScrollController? scrollController;

  /// {@macro flutter.widgets.editableText.restorationId}
  final String? restorationId;

  /// {@macro flutter.widgets.editableText.enableIMEPersonalizedLearning}
  final bool enableIMEPersonalizedLearning;

  /// {@macro flutter.widgets.editableText.mouseCursor}
  final MouseCursor? mouseCursor;

  /// {@macro flutter.widgets.editableText.contextMenuBuilder}
  final EditableTextContextMenuBuilder? contextMenuBuilder;

  /// {@macro flutter.widgets.editableText.spellCheckConfiguration}
  final SpellCheckConfiguration? spellCheckConfiguration;

  /// {@macro flutter.widgets.editableText.magnifierConfiguration}
  final TextMagnifierConfiguration? magnifierConfiguration;

  /// {@macro flutter.widgets.editableText.undoController}
  final UndoHistoryController? undoController;

  /// {@macro flutter.widgets.editableText.onAppPrivateCommand}
  final AppPrivateCommandCallback? onAppPrivateCommand;

  /// {@macro flutter.widgets.editableText.cursorOpacityAnimates}
  final bool? cursorOpacityAnimates;

  /// {@macro flutter.widgets.editableText.selectionHeightStyle}
  final ui.BoxHeightStyle? selectionHeightStyle;

  /// {@macro flutter.widgets.editableText.selectionWidthStyle}
  final ui.BoxWidthStyle? selectionWidthStyle;

  /// {@macro flutter.widgets.editableText.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// {@macro flutter.widgets.editableText.contentInsertionConfiguration}
  final ContentInsertionConfiguration? contentInsertionConfiguration;

  /// {@macro flutter.widgets.editableText.statesController}
  final MaterialStatesController? statesController;

  /// {@macro flutter.widgets.editableText.clipBehavior}
  final Clip clipBehavior;
  // @Deprecated(
  //   'Use `stylusHandwritingEnabled` instead. '
  //   'This feature was deprecated after v3.27.0-0.2.pre.',
  // )
  /// {@macro flutter.widgets.editableText.scribbleEnabled}
  final bool scribbleEnabled;

  /// {@macro flutter.widgets.editableText.stylusHandwritingEnabled}
  final bool stylusHandwritingEnabled;

  /// {@macro flutter.widgets.editableText.canRequestFocus}
  final bool canRequestFocus;

  /// {@macro flutter.widgets.editableText.hintLocales}
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
