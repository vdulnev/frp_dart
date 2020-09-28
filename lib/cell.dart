
import 'stream.dart';

class Cell<A> {
  A _value;
  final Stream<A> _stream;

  Cell(this._stream, this._value){
    _stream.listen((t, a) { _value = a; });
  }

  A sample() => _value;

  void loop(Stream<A> stream) {
    stream.listen((t, a) {_stream.fire(a);});
  }

}