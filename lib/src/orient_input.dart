import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orient_text_field/src/full_screen_field_config.dart';

import 'dialog_full_text.dart';
import 'keyboard_status_provider.dart';

class OrientInput extends StatefulWidget {
  const OrientInput({
    super.key,
    required this.isFormField,
    this.groupId = EditableText,
    this.controller,
    this.initialValue,
    this.forceErrorText,
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
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.errorBuilder,
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
    this.autovalidateMode,
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

  final bool isFormField;
  final Object groupId;
  final TextEditingController? controller;
  final String? initialValue;
  final FocusNode? focusNode;
  final String? forceErrorText;
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
  @Deprecated(
    'Use `contextMenuBuilder` instead. '
    'This feature was deprecated after v3.3.0-0.5.pre.',
  )
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
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final FormFieldErrorBuilder? errorBuilder;
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
  final AutovalidateMode? autovalidateMode;
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
  @Deprecated(
    'Use WidgetStatesController instead. '
    'Moved to the Widgets layer to make code available outside of Material. '
    'This feature was deprecated after v3.19.0-0.3.pre.',
  )
  final MaterialStatesController? statesController;
  final bool scribbleEnabled;
  final Clip clipBehavior;
  @Deprecated(
    'Use `stylusHandwritingEnabled` instead. '
    'This feature was deprecated after v3.27.0-0.2.pre.',
  )
  final bool stylusHandwritingEnabled;
  final bool canRequestFocus;
  final List<Locale>? hintLocales;
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
  State<OrientInput> createState() => _OrientInputState();
}

class _OrientInputState extends State<OrientInput> {
  late final FocusNode _focusNode;
  late final bool _ownFocusNode;
  late final TextEditingController _controller;
  late final bool _ownController;
  bool _processing = false;
  bool _readOnly = true;
  bool? _showCursor = true;

  StreamSubscription? _subOrientation;
  Orientation? _lastOrientation;

  @override
  void initState() {
    super.initState();
    _focusNode =
        widget.focusNode ?? FocusNode(canRequestFocus: widget.canRequestFocus);
    _ownFocusNode = widget.focusNode == null;
    _controller = widget.controller ?? TextEditingController();
    _ownController = widget.controller == null;
    _subOrientation = OrientEvent.orientationEvent.stream.listen((value) {
      setState(() {
        _lastOrientation = value;
      });
    });
  }

  @override
  void dispose() {
    // _focusNode.removeListener(showLanscapeField);
    if (_ownFocusNode) _focusNode.dispose();
    if (_ownController) _controller.dispose();
    _subOrientation?.cancel();
    super.dispose();
  }

  Future<void> showLanscapeField() async {
    if (_processing ||
        MediaQuery.orientationOf(context) == Orientation.portrait) {
      return;
    }
    _processing = true;
    var openDialog = false;
    var i = 0;
    while (i < 20) {
      if (await OrientEvent.isKeyboardOpen && _focusNode.hasFocus) {
        openDialog = true;
        break;
      }
      i++;
      await Future.delayed(Duration(milliseconds: 50));
    }

    if (openDialog && mounted) {
      var res = await Navigator.push<bool>(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              DialogFullText(
                controller: _controller,
                multiLine: widget.maxLines != null && widget.maxLines! > 1,
                obscureText: widget.obscureText,
                keyboardType: widget.keyboardType,
                config: widget.fullScreenFieldConfig,
                autovalidateMode: widget.autovalidateMode,
                validator: widget.validator,
                textDirection: widget.textDirection,
              ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0); // Start at the bottom
            const end = Offset.zero; // End at its natural position
            const curve = Curves.ease; // Smooth easing

            var tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      );

      if (res == true && widget.fullScreenFieldConfig.submitOnDone) {
        widget.onFieldSubmitted?.call(_controller.text);
      }

      if (mounted &&
          MediaQuery.orientationOf(context) == Orientation.portrait) {
        _focusNode.requestFocus();
      }

      if (mounted) {
        if (MediaQuery.orientationOf(context) == Orientation.landscape) {
          _focusNode.unfocus();
          Future.microtask(() {
            setState(() {
              _readOnly = true;
            });
          });
        } else {
          _focusNode.requestFocus();
        }
      }
    }

    _processing = false;
  }

  void onTextfieldTap() {
    if (MediaQuery.orientationOf(context) != Orientation.landscape) return;
    if (widget.readOnly == true) return;
    setState(() {
      _readOnly = false;
    });
    // Ensure it requests focus so the keyboard pops up now
    _focusNode.requestFocus();
    showLanscapeField();
  }

  @override
  Widget build(BuildContext context) {
    // return OrientationBuilder(
    //   builder: (context, orientationz) {
    _lastOrientation ??= MediaQuery.orientationOf(context);
    bool isLandscape = _lastOrientation == Orientation.landscape;
    _showCursor = widget.showCursor;
    _readOnly = widget.readOnly;
    if (isLandscape && !widget.readOnly) {
      Future.microtask(() async {
        if (await OrientEvent.isKeyboardOpen && _focusNode.hasFocus) {
          showLanscapeField();
        } else {
          setState(() {
            _showCursor = true;
            _readOnly = true;
          });
        }
      });
    }

    if (widget.isFormField) {
      return TextFormField(
        groupId: widget.groupId,
        controller: _controller,
        initialValue: widget.initialValue,
        focusNode: _focusNode,
        forceErrorText: widget.forceErrorText,
        decoration: widget.decoration,
        keyboardType: widget.keyboardType,
        textCapitalization: widget.textCapitalization,
        textInputAction: widget.textInputAction,
        style: widget.style,
        strutStyle: widget.strutStyle,
        textDirection: widget.textDirection,
        textAlign: widget.textAlign,
        textAlignVertical: widget.textAlignVertical,
        autofocus: !isLandscape ? widget.autofocus : false,
        readOnly: _readOnly,
        toolbarOptions: widget.toolbarOptions,
        showCursor: _showCursor,
        obscuringCharacter: widget.obscuringCharacter,
        obscureText: widget.obscureText,
        autocorrect: widget.autocorrect,
        smartDashesType: widget.smartDashesType,
        smartQuotesType: widget.smartQuotesType,
        enableSuggestions: widget.enableSuggestions,
        maxLengthEnforcement: widget.maxLengthEnforcement,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        expands: widget.expands,
        maxLength: widget.maxLength,
        onChanged: widget.onChanged,
        onTap: onTextfieldTap, //widget.onTap,
        onTapAlwaysCalled: false, // widget.onTapAlwaysCalled,
        onTapOutside: widget.onTapOutside,
        onTapUpOutside: widget.onTapUpOutside,
        onEditingComplete: widget.onEditingComplete,
        onFieldSubmitted: widget.onFieldSubmitted,
        onSaved: widget.onSaved,
        validator: widget.validator,
        errorBuilder: widget.errorBuilder,
        inputFormatters: widget.inputFormatters,
        enabled: widget.enabled,
        ignorePointers: widget.ignorePointers,
        cursorWidth: widget.cursorWidth,
        cursorHeight: widget.cursorHeight,
        cursorRadius: widget.cursorRadius,
        cursorColor: widget.cursorColor,
        cursorErrorColor: widget.cursorErrorColor,
        keyboardAppearance: widget.keyboardAppearance,
        scrollPadding: widget.scrollPadding,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        selectAllOnFocus: widget.selectAllOnFocus,
        selectionControls: widget.selectionControls,
        buildCounter: widget.buildCounter,
        scrollPhysics: widget.scrollPhysics,
        autofillHints: widget.autofillHints,
        autovalidateMode: widget.autovalidateMode,
        scrollController: widget.scrollController,
        restorationId: widget.restorationId,
        enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
        mouseCursor: widget.mouseCursor,
        contextMenuBuilder: widget.contextMenuBuilder,
        spellCheckConfiguration: widget.spellCheckConfiguration,
        magnifierConfiguration: widget.magnifierConfiguration,
        undoController: widget.undoController,
        onAppPrivateCommand: widget.onAppPrivateCommand,
        cursorOpacityAnimates: widget.cursorOpacityAnimates,
        selectionHeightStyle: widget.selectionHeightStyle,
        selectionWidthStyle: widget.selectionWidthStyle,
        dragStartBehavior: widget.dragStartBehavior,
        contentInsertionConfiguration: widget.contentInsertionConfiguration,
        statesController: widget.statesController,
        clipBehavior: widget.clipBehavior,
        scribbleEnabled: widget.scribbleEnabled,
        stylusHandwritingEnabled: widget.stylusHandwritingEnabled,
        canRequestFocus: widget.canRequestFocus,
        hintLocales: widget.hintLocales,
      );
    } else {
      return TextField(
        groupId: widget.groupId,
        controller: _controller,
        focusNode: _focusNode,
        decoration: widget.decoration,
        keyboardType: widget.keyboardType,
        textCapitalization: widget.textCapitalization,
        textInputAction: widget.textInputAction,
        style: widget.style,
        strutStyle: widget.strutStyle,
        textDirection: widget.textDirection,
        textAlign: widget.textAlign,
        textAlignVertical: widget.textAlignVertical,
        autofocus: !isLandscape ? widget.autofocus : false,
        readOnly: _readOnly,
        toolbarOptions: widget.toolbarOptions,
        showCursor: _showCursor,
        obscuringCharacter: widget.obscuringCharacter,
        obscureText: widget.obscureText,
        autocorrect: widget.autocorrect,
        smartDashesType: widget.smartDashesType,
        smartQuotesType: widget.smartQuotesType,
        enableSuggestions: widget.enableSuggestions,
        maxLengthEnforcement: widget.maxLengthEnforcement,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        expands: widget.expands,
        maxLength: widget.maxLength,
        onChanged: widget.onChanged,
        onTap: onTextfieldTap, //widget.onTap,
        onTapAlwaysCalled: false, // widget.onTapAlwaysCalled,
        onTapOutside: widget.onTapOutside,
        onTapUpOutside: widget.onTapUpOutside,
        onEditingComplete: widget.onEditingComplete,
        onSubmitted: widget.onFieldSubmitted,
        inputFormatters: widget.inputFormatters,
        enabled: widget.enabled,
        ignorePointers: widget.ignorePointers,
        cursorWidth: widget.cursorWidth,
        cursorHeight: widget.cursorHeight,
        cursorRadius: widget.cursorRadius,
        cursorColor: widget.cursorColor,
        cursorErrorColor: widget.cursorErrorColor,
        keyboardAppearance: widget.keyboardAppearance,
        scrollPadding: widget.scrollPadding,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        selectAllOnFocus: widget.selectAllOnFocus,
        selectionControls: widget.selectionControls,
        buildCounter: widget.buildCounter,
        scrollPhysics: widget.scrollPhysics,
        autofillHints: widget.autofillHints,
        scrollController: widget.scrollController,
        restorationId: widget.restorationId,
        enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
        mouseCursor: widget.mouseCursor,
        contextMenuBuilder: widget.contextMenuBuilder,
        spellCheckConfiguration: widget.spellCheckConfiguration,
        magnifierConfiguration: widget.magnifierConfiguration,
        undoController: widget.undoController,
        onAppPrivateCommand: widget.onAppPrivateCommand,
        cursorOpacityAnimates: widget.cursorOpacityAnimates,
        selectionHeightStyle: widget.selectionHeightStyle,
        selectionWidthStyle: widget.selectionWidthStyle,
        dragStartBehavior: widget.dragStartBehavior,
        contentInsertionConfiguration: widget.contentInsertionConfiguration,
        statesController: widget.statesController,
        clipBehavior: widget.clipBehavior,
        scribbleEnabled: widget.scribbleEnabled,
        stylusHandwritingEnabled: widget.stylusHandwritingEnabled,
        canRequestFocus: widget.canRequestFocus,
        hintLocales: widget.hintLocales,
      );
    }
    //   },
    // );
  }
}
