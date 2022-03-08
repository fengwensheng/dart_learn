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

void main() {
  // final Queue<int> queue = QueueList();
  // queue
  //   ..enqueue(1)
  //   ..enqueue(2)
  //   ..enqueue(3) //[1, 2, 3]
  //   ..dequeue(); //[2, 3]
  // print(queue);
  // print(queue.peek); //2

  final queueDoublyLinkedList = QueueDoublyLinkedList<int>();
  queueDoublyLinkedList
    ..enqueue(1)
    ..enqueue(3)
    ..enqueue(5)
    ..dequeue(); //[1, 3, 5]
  print(queueDoublyLinkedList.toString()); //[1, 3]
  print(queueDoublyLinkedList.peek); //3
}
