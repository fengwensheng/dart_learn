abstract class Queue<E> {
  ///insert new element at back of queue
  bool enqueue(E e);

  ///remove the element front of queue
  E? dequeue();

  ///check if empty
  bool get isEmpty;

  ///retrieve the front
  E? get peek;
}

/**
 * List-Based Implementation
 */
class QueueList<E> implements Queue<E> {
  //0 element for initial state
  final _list = <E>[];

  ///O(n), linear-time for shift-left
  @override
  E? dequeue() => isEmpty ? null : _list.removeAt(0);

  ///O(1), but if full, need O(n) for alloc and copy, not ofter
  @override
  bool enqueue(E e) {
    _list.add(e);
    return true;
  }

  ///O(1)
  @override
  bool get isEmpty => _list.isEmpty;

  ///O(1)
  @override
  E? get peek => isEmpty ? null : _list.first;

  ///for test
  @override
  String toString() => _list.toString();
}

void main() {
  final Queue<int> queue = QueueList();
  queue
    ..enqueue(1)
    ..enqueue(2)
    ..enqueue(3) //[1, 2, 3]
    ..dequeue(); //[2, 3]
  print(queue);
  print(queue.peek); //2
}
