import 'cell.dart';
import 'transaction.dart';

typedef TransactionHandler<A> = void Function(Transaction t, A a);

class Stream<A> {
  final _listeners = List<TransactionHandler<A>>();

  void fire(A a) {
    for (final listener in _listeners) {
      listener.call(Transaction(), a);
    }
  }

  void listen(TransactionHandler<A> listener) {
    _listeners.add(listener);
  }

  Stream<B> map<B>(B Function(A a) func) {
    final sOut = Stream<B>();
    _listeners.add((t, a) { sOut.fire(func.call(a)); });
    return sOut;
  }

  Cell<A> hold(A initialValue) {
    return Cell(this, initialValue);
  }

  Stream<C> snapshot<B,C>(Cell<B> cell, C Function(A, B) merge) {
    final sOut = Stream<C>();
    _listeners.add((t, a) {sOut.fire(merge(a, cell.sample()));});
    return sOut;
  }
}