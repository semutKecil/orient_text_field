import 'dart:async';

class StreamManager<T> {
  T _currentValue;
  final StreamController<T> _controller = StreamController<T>.broadcast();
  StreamManager(this._currentValue);
  T get value => _currentValue;
  Stream<T> get stream => _controller.stream;

  void emit(T newData) {
    if (!_controller.isClosed) {
      _currentValue = newData; // Update state internal
      _controller.sink.add(newData); // Kirim ke semua listener
    }
  }

  void dispose() {
    _controller.close();
  }
}
