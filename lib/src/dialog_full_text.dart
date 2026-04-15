import 'dart:async';

import 'package:flutter/material.dart';
import 'package:orient_text_field/src/full_screen_field_config.dart';

class DialogFullText extends StatefulWidget {
  final TextEditingController controller;
  final bool multiLine;
  final TextInputType? keyboardType;
  final bool obscureText;
  final FullScreenFieldConfig config;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  final TextDirection? textDirection;
  const DialogFullText({
    super.key,
    required this.controller,
    required this.multiLine,
    required this.config,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.autovalidateMode,
    this.textDirection,
  });

  @override
  State<DialogFullText> createState() => _DialogFullTextState();
}

class _DialogFullTextState extends State<DialogFullText> {
  double? _maxHeight;
  bool _closing = false;
  final FocusNode _focusNode = FocusNode();
  final Debouncer _debounce = Debouncer(delay: Duration(milliseconds: 300));

  bool _obscureMode = false;

  bool _obscureText = false;

  String? _errorText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    if (widget.config.obscureText != null) {
      _obscureMode = widget.config.obscureText!;
    } else {
      _obscureMode = widget.obscureText;
    }
    if (widget.config.enableFormValidation != false &&
        widget.validator != null &&
        !(widget.autovalidateMode == AutovalidateMode.disabled ||
            widget.autovalidateMode == AutovalidateMode.onUnfocus)) {
      widget.controller.addListener(validate);
    }
  }

  @override
  void dispose() {
    if (widget.config.enableFormValidation != false &&
        widget.validator != null &&
        !(widget.autovalidateMode == AutovalidateMode.disabled ||
            widget.autovalidateMode == AutovalidateMode.onUnfocus)) {
      widget.controller.removeListener(validate);
    }
    _focusNode.dispose();
    _debounce.cancel();
    super.dispose();
  }

  void validate() {
    _debounce.run(() {
      setState(() {
        _errorText = widget.validator!(widget.controller.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var decoration = widget.config.decoration ?? const InputDecoration();
    if (_errorText != null) {
      decoration = decoration.copyWith(errorText: _errorText);
    }
    var textField = Theme(
      data: ThemeData(colorScheme: Theme.of(context).colorScheme),
      child: TextField(
        controller: widget.controller,
        autofocus: true,
        focusNode: _focusNode,
        maxLines: _obscureMode ? 1 : null,
        minLines: null,
        expands: !_obscureMode,
        textAlignVertical: TextAlignVertical.top,
        keyboardType:
            widget.keyboardType ??
            (widget.multiLine ? TextInputType.multiline : TextInputType.text),
        obscureText: _obscureText,
        keyboardAppearance: widget.config.keyboardAppearance,
        decoration: decoration,
        textDirection: widget.textDirection,
      ),
    );
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        _focusNode.unfocus();
      },
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (!_closing &&
                constraints.maxHeight > (_maxHeight ?? constraints.maxHeight)) {
              _closing = true;
              Future.microtask(() {
                if (context.mounted) {
                  Navigator.pop(context);
                }
              });
            }
            _maxHeight = constraints.maxHeight;
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: _obscureMode
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [textField],
                            )
                          : textField,
                    ),
                    SizedBox(width: 5),
                    _obscureMode == true && widget.config.withObscureToggle
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            icon: _obscureText
                                ? widget.config.obscureEnabedIcon
                                : widget.config.obscureDisabledIcon,
                            // icon: Icon(
                            //   _obscureText ? widget.config.obscureEnabedIcon : Icons.password,
                            // ),
                          )
                        : SizedBox.shrink(),
                    _obscureMode == true && widget.config.withObscureToggle
                        ? SizedBox(width: 5)
                        : SizedBox.shrink(),
                    FilledButton(
                      onPressed: () {
                        _focusNode.unfocus();
                      },
                      child: Text(widget.config.doneText),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// A generic debouncer that delays and deduplicates rapid successive calls.
///
/// [Debouncer] is useful for deferring expensive operations (like API calls, searches,
/// or validations) until the user stops triggering them. For example, in a search field,
/// instead of making an API call on every keystroke, the debouncer waits for the user
/// to stop typing before executing the search.
///
/// How it works:
/// 1. When [run()] is called, any previously scheduled action is cancelled
/// 2. A new timer starts for the specified [delay]
/// 3. If [run()] is called again before the timer completes, the timer is reset
/// 4. When the timer finally completes, the action is executed
/// 5. The returned Future completes with the action's result
///
/// Example - debounced search:
/// ```dart
/// final debouncer = Debouncer<List<String>>(delay: Duration(milliseconds: 500));
///
/// searchField.onChanged = (value) {
///   debouncer.run(() async {
///     final results = await searchApi.search(value);
///     return results;
///   }).then((results) {
///     setState(() => searchResults = results);
///   });
/// };
/// ```
class Debouncer<T> {
  /// The delay duration to wait before executing the action.
  ///
  /// After calling [run()], the action will be executed after this delay
  /// unless [run()] is called again (which resets the timer).
  final Duration delay;

  /// The timer that schedules the delayed action execution.
  ///
  /// Kept as a class field so it can be cancelled when a new call to [run()] arrives.
  Timer? _timer;

  /// The completer that resolves the future returned by [run()].
  ///
  /// Reused across multiple calls to [run()] if the previous call's action
  /// hasn't completed yet. A new completer is created when the previous one completes.
  Completer<T>? _completer;

  /// Creates a new [Debouncer] with the specified delay.
  ///
  /// The [delay] parameter is required and determines how long to wait
  /// after the last [run()] call before executing the action.
  ///
  /// Example: `Debouncer<String>(delay: Duration(milliseconds: 300))`
  Debouncer({required this.delay});

  /// Schedules an action to run after the delay, cancelling any previously scheduled action.
  ///
  /// Each call to [run()] cancels the previous timer, effectively resetting the delay.
  /// This ensures that rapid successive calls will only execute the action once,
  /// after the delay period has passed since the last call.
  ///
  /// The action can be synchronous or asynchronous (returns FutureOr&lt;T&gt;).
  /// The returned Future completes when the action finishes executing.
  ///
  /// Returns a [Future] that completes with the action's result (of type T),
  /// or completes with an error if the action throws or is cancelled.
  ///
  /// Parameters:
  ///   - [action]: A function that performs the debounced work. Can be async or sync.
  ///
  /// Example:
  /// ```dart
  /// final future = debouncer.run(() async {
  ///   return await expensiveOperation();
  /// });
  ///
  /// future.then((result) {
  ///   print('Result: $result');
  /// }).catchError((error) {
  ///   print('Error: $error');
  /// });
  /// ```
  Future<T> run(FutureOr<T> Function() action) {
    _timer?.cancel();

    if (_completer == null || _completer?.isCompleted == true) {
      _completer = Completer<T>();
    }

    _timer = Timer(delay, () async {
      try {
        final result = await action();
        _completer?.complete(result);
      } catch (e) {
        _completer?.completeError(e);
      }
    });

    return _completer!.future;
  }

  /// Cancels the pending debounced action and completes the future with an error.
  ///
  /// If an action is currently scheduled via [run()], this method:
  /// 1. Cancels the pending timer
  /// 2. Completes the returned future with a 'Debounce cancelled' error
  ///
  /// This is useful when cleaning up (e.g., when a widget is disposed) to ensure
  /// pending operations don't complete after the widget is destroyed, which could
  /// cause "mounted check failed" errors.
  ///
  /// Calling [cancel()] when no action is scheduled is safe (no-op).
  ///
  /// Example - cancelling in dispose:
  /// ```dart
  /// @override
  /// void dispose() {
  ///   debouncer.cancel(); // Cancel any pending search
  ///   super.dispose();
  /// }
  /// ```
  void cancel() {
    _timer?.cancel();
    if (!(_completer?.isCompleted == true)) {
      _completer?.completeError('Debounce cancelled');
    }
  }
}
