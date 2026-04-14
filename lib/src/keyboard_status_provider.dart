import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:orient_text_field/src/stream_manager.dart';

/// A widget that provides keyboard visibility status throughout the app.
///
/// This provider must be wrapped around your app's root widget to enable
/// keyboard status detection for OrientTextField widgets. It monitors the
/// keyboard visibility using MediaQuery.viewInsetsOf and provides a static
/// interface to check if the keyboard is currently open.
///
/// **Required Setup:** Wrap your MaterialApp or CupertinoApp with this provider:
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
///         home: MyHomePage(),
///       ),
///     );
///   }
/// }
/// ```
///
/// Without this provider, OrientTextField widgets will not function correctly
/// in landscape orientation or full-screen editing mode.
class KeyboardStatusProvider extends StatefulWidget {
  /// The child widget to be wrapped by this provider.
  ///
  /// Typically this is your MaterialApp or CupertinoApp.
  final Widget child;

  /// Creates a KeyboardStatusProvider.
  ///
  /// The [child] parameter must not be null and should be your app's root widget.
  const KeyboardStatusProvider({super.key, required this.child});

  static final _keyboardStatus = StreamManager<bool?>(null);

  /// Returns whether the keyboard is currently visible.
  ///
  /// This is a static method that can be called from anywhere in the app
  /// to check if the soft keyboard is currently open.
  ///
  /// Returns a Future that completes with `true` if the keyboard is open,
  /// `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// bool keyboardVisible = await KeyboardStatusProvider.isKeyboardOpen;
  /// if (keyboardVisible) {
  ///   // Keyboard is open, adjust UI accordingly
  /// }
  /// ```
  static Future<bool> get isKeyboardOpen async {
    Completer<bool> status = Completer<bool>();
    var sub = KeyboardStatusProvider._keyboardStatus.stream.listen((value) {
      if (value != null) {
        status.complete(value);
      }
    });
    KeyboardStatusProvider._keyboardStatus.emit(null);
    bool res = await status.future;
    sub.cancel();
    return res;
  }

  @override
  State<KeyboardStatusProvider> createState() => _KeyboardStatusProviderState();
}

/// The state for KeyboardStatusProvider.
///
/// This class manages the keyboard visibility detection by listening to
/// MediaQuery.viewInsetsOf changes and updating the keyboard status stream.
class _KeyboardStatusProviderState extends State<KeyboardStatusProvider> {
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _sub = KeyboardStatusProvider._keyboardStatus.stream.listen((value) {
        if (value == null && mounted) {
          KeyboardStatusProvider._keyboardStatus.emit(
            MediaQuery.viewInsetsOf(context).bottom > 0,
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
