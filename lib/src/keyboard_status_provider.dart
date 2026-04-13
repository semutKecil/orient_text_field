import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:orient_text_field/src/stream_manager.dart';

class KeyboardStatusProvider extends StatefulWidget {
  final Widget child;
  const KeyboardStatusProvider({super.key, required this.child});

  static final _keyboardStatus = StreamManager<bool?>(null);
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
