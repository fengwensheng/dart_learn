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

/**
 * DoublyLinkedList-Based Implementation
 */
class Node<T> {
  T data;
  Node<T>? next;
  Node<T>? prev;
  Node({required this.data, this.next, this.prev});
}

abstract class LinkedList<E> {
  Node<E>? head;
  Node<E>? tail;
  bool get isEmpty;

  ///
  ///insert
  ///

  ///insert start
  void push(E data);

  ///insert end
  void append(E data);

  ///
  ///remove
  ///

  ///remove start
  E? pop();

  ///remove end
  E? removeLast();
}

class DoublyLinkedList<E> extends Iterable<E> implements LinkedList<E> {
  @override
  Node<E>? head;

  @override
  Node<E>? tail;

  ///O(1)
  @override
  void append(E data) {
    final newEndNode = Node<E>(
      data: data,
      prev: tail,
      next: null,
    );
    if (isEmpty) {
      head = newEndNode;
    } else {
      tail!.next = newEndNode;
      tail!.prev ??= tail;
    }
    tail = newEndNode;
  }

  @override
  bool get isEmpty => head == null;

  @override
  E? pop() {
    if (isEmpty) return null;

    ///one node
    if (head?.next == null) {
      head = tail = null;
      return null;
    }
    final data = head?.data;
    head = head?.next;
    head?.prev = null;
    return data;
  }

  @override
  void push(E data) {
    Node<E> newStartNode = Node(
      data: data,
      next: head,
    );
    if (isEmpty) {
      tail = newStartNode;
    } else {
      head!.prev = newStartNode;
      //one node case, for tail's prev pointer
      tail!.prev ??= newStartNode;
    }

    head = newStartNode;
  }

  @override
  E? removeLast() {
    //0 or 1 element
    if (head?.next == null) return pop();
    final data = tail?.data;
    tail = tail?.prev;
    tail?.next = null;
    return data;
  }

  //join() need Iterable, so...
  @override
  String toString() => '[${this.join(', ')}]';

  @override
  Iterator<E> get iterator => _DoublyLinkedListIterator(this);
}

class _DoublyLinkedListIterator<E> extends Iterator<E> {
  final DoublyLinkedList<E> _doublyLinkedList;

  _DoublyLinkedListIterator(this._doublyLinkedList);
  Node<E>? _currentNode;
  @override
  E get current => _currentNode!.data;

  bool _firstPass = true;
  @override
  bool moveNext() {
    if (_doublyLinkedList.isEmpty) return false;
    if (_firstPass) {
      _currentNode = _doublyLinkedList.head;
      _firstPass = false;
    } else {
      _currentNode = _currentNode?.next;
    }
    return _currentNode != null;
  }
}

class QueueDoublyLinkedList<E> implements Queue<E> {
  final DoublyLinkedList<E> _doublyLinkedList;
  QueueDoublyLinkedList() : _doublyLinkedList = DoublyLinkedList();

  @override
  E? dequeue() {
    return _doublyLinkedList.pop();
  }

  @override
  bool enqueue(E e) {
    _doublyLinkedList.append(e);
    return true;
  }

  @override
  bool get isEmpty => _doublyLinkedList.isEmpty;

  @override
  E? get peek => _doublyLinkedList.head?.data;

  @override
  String toString() => '[${_doublyLinkedList.join(', ')}]';
}

/**
 * RingBuffer-Based Implementation
 */
class RingBuffer<T> {
  final List<T?> _list;
  int _readIndex = 0;
  int _writeIndex = 0;
  int _size = 0; //indicates empty and full state

  RingBuffer(int length) : this._list = List<T?>.filled(length, null);

  bool get isEmpty => _size == 0;
  bool get isFull => _size == _list.length;

  void write(T element) {
    if (isFull) throw Exception('Buffer is full!');
    _list[_writeIndex] = element;
    _size++;
    _writeIndex = _advance(_writeIndex);
  }

  T? read() {
    if (isEmpty) return null;
    final ele = _list[_readIndex];
    _size--;
    _readIndex = _advance(_readIndex);
    return ele;
  }

  ///get next step value for readIndex and writeIndex
  int _advance(int value) => _size == _list.length ? 0 : value + 1;

  T? get peek => isEmpty ? null : _list[_readIndex];

  @override
  String toString() =>
      '\{\nread:${_readIndex},\nwrite:${_writeIndex},\n${_list}\n}\n';
}

class QueueRingBuffer<E> implements Queue<E> {
  final RingBuffer<E> _ringBuffer;

  QueueRingBuffer(int length) : this._ringBuffer = RingBuffer(length);

  ///O(1)
  @override
  E? dequeue() => _ringBuffer.read();

  ///O(1)
  @override
  bool enqueue(E e) {
    if (_ringBuffer.isFull) {
      return false;
    } else {
      _ringBuffer.write(e);
      return true;
    }
  }

  ///O(1)
  @override
  bool get isEmpty => _ringBuffer.isEmpty;

  ///O(1)
  @override
  E? get peek => _ringBuffer.peek;

  @override
  String toString() => _ringBuffer.toString();
}

/**
 * 4.Double-Stack Implementation
 */
class QueueDoubleStack<E> implements Queue<E> {
  final _leftStack = <E>[];
  final _rightStack = <E>[];
  @override
  E? dequeue() {
    if (_leftStack.isEmpty) {
      //move right to left
      _leftStack.addAll(_rightStack.reversed);
      _rightStack.clear();
    }
    if (_leftStack.isEmpty) return null;
    return _leftStack.removeLast();
  }

  ///O(1), O(n)
  @override
  bool enqueue(E e) {
    _rightStack.add(e);
    return true;
  }

  ///O(1)
  @override
  bool get isEmpty => _leftStack.isEmpty && _rightStack.isEmpty;

  ///O(1)
  @override
  E? get peek => _leftStack.isNotEmpty ? _leftStack.last : _rightStack.first;

  @override
  String toString() => '${[..._leftStack.reversed, ..._rightStack]}';
}

/**
 * challenge Double-End-Queue deque
 * combine stack and queue
 */
enum Direction { front, back }

abstract class Deque<E> {
  bool get isEmpty;
  E? peek(Direction from);
  bool enqueue(E element, Direction to);
  E? dequeue(Direction from);
}

///c1 List-Based Deque
class DequeList<E> implements Deque<E> {
  final List<E> _list = <E>[];

  bool _isFrontOp(Direction op) => op == Direction.front;

  ///O(n)
  @override
  E? dequeue(Direction from) => isEmpty
      ? null
      : (_isFrontOp(from) ? _list.removeAt(0) : _list.removeLast());

  ///O(n)
  @override
  bool enqueue(E element, Direction to) {
    if (_isFrontOp(to)) {
      final newList = _list.reversed.toList();
      newList.add(element);
      _list
        ..clear()
        ..addAll(newList.reversed);
    } else {
      _list.add(element);
    }
    return true;
  }

  ///O(1)
  @override
  bool get isEmpty => _list.length == 0;

  ///O(1)
  @override
  E? peek(Direction from) =>
      isEmpty ? null : (_isFrontOp(from) ? _list.first : _list.last);

  @override
  String toString() => _list.toString();
}

///c2 Doubly-Linked-List-Based Deque
///double vs single LL: removeLast
class DequeDoublyLinkedList<E> implements Deque<E> {
  @override
  E? dequeue(Direction from) {
    // TODO: implement dequeue
    throw UnimplementedError();
  }

  @override
  bool enqueue(E element, Direction to) {
    // TODO: implement enqueue
    throw UnimplementedError();
  }

  @override
  // TODO: implement isEmpty
  bool get isEmpty => throw UnimplementedError();

  @override
  E? peek(Direction from) {
    // TODO: implement peek
    throw UnimplementedError();
  }
}

void main() {
  //1
  // final Queue<int> queue = QueueList();
  // queue
  //   ..enqueue(1)
  //   ..enqueue(2)
  //   ..enqueue(3) //[1, 2, 3]
  //   ..dequeue(); //[2, 3]
  // print(queue);
  // print(queue.peek); //2

  //2
  // final queueDoublyLinkedList = QueueDoublyLinkedList<int>();
  // queueDoublyLinkedList
  //   ..enqueue(1)
  //   ..enqueue(3)
  //   ..enqueue(5)
  //   ..dequeue(); //[1, 3, 5]
  // print(queueDoublyLinkedList.toString()); //[3, 5]
  // print(queueDoublyLinkedList.peek); //3

  //3
  // final _queueRingBuffer = QueueRingBuffer<int>(10);
  // _queueRingBuffer
  //   ..enqueue(1)
  //   ..enqueue(2)
  //   ..enqueue(3);
  // print(_queueRingBuffer);
  // print(_queueRingBuffer.dequeue());

  //4
  // Queue _queueDouleStack = QueueDoubleStack<int>();
  // _queueDouleStack
  //   ..enqueue(1)
  //   ..enqueue(2)
  //   ..enqueue(3)
  //   ..dequeue();
  // print(_queueDouleStack);
  // print(_queueDouleStack.peek);

  //ch1
  Deque deque = DequeList<int>();
  deque
    ..enqueue(1, Direction.back)
    ..enqueue(2, Direction.back)
    ..enqueue(3, Direction.front) //312
    ..dequeue(Direction.back)
    ..enqueue(5, Direction.front); //531

  print(deque);
}
