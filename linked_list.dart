import 'stack.dart';

class Node<T> {
  T value;
  Node<T>? next; //null stand-for End
  Node({
    required this.value,
    this.next,
  });

  @override
  String toString() {
    if (next == null) return '$value';
    return '$value -> ${next.toString()}';
  }
}

class LinkedList<E> extends Iterable<E> {
  Node<E>? head;
  Node<E>? tail;
  // bool get isEmpty => head == null;
  ///insert front
  ///O(1)
  void push(E value) {
    this.head = Node(value: value, next: this.head);
    tail ??= head;
  }

  ///insert end
  ///O(1)
  void append(E value) {
    if (isEmpty) {
      push(value);
      return;
    }
    this.tail!.next = Node<E>(value: value);
    this.tail = this.tail!.next;
  }

  //insert middle1: find node
  //O(i)
  Node<E>? nodeAt(int index) {
    Node<E>? node = head;
    for (int i = 0; i < index; i++) {
      node = node?.next;
    }
    return node;
  }

  //insert middle2: insert after
  //O(1)
  Node<E> insertAfter(Node<E> curNode, E value) {
    if (tail == curNode) {
      append(value);
      return tail!;
    }
    curNode.next = Node(value: value, next: curNode.next);
    return curNode.next!;
  }

  //******************
  //******REMOVE******
  //******************

  ///pop, remove first, O(1)
  E? pop() {
    if (isEmpty) return null;
    Node<E> head = this.head!;
    this.head = head.next;
    return head.value;
  }

  ///removeLast, remove the tail element, O(n) to locate to second-to-last
  E? removeLast() {
    //length=0
    // if (isEmpty) return null;
    //length=1 (or length=0 in pop())
    if (tail == head) return pop();
    //length>1
    var node = head;
    while ((node!.next) != tail) node = node.next;
    node.next = null;
    tail = node;
    return node.value;
  }

  ///remove middle, O(1)
  // E? removeAt(Node<E> targetNode) {
  //   if (head == tail) return pop();
  //   var preNode = head;
  //   while (preNode!.next != targetNode) preNode = preNode.next;
  //   preNode.next = targetNode.next;
  //   return targetNode.value;
  // }
  E? removeAfter(Node<E> preNode) {
    //target is tail 只有两个节点的情况 only two elements
    // preNode.next = null;
    if (preNode.next == tail) tail = preNode;
    var targetNode = preNode.next!;
    preNode.next = preNode.next!.next;
    return targetNode.value;
  }

  @override
  String toString() {
    if (isEmpty) return 'Empty list';
    return head.toString();
  }

  //******************
  //*****ITERABLE*****
  //******************

  @override
  Iterator<E> get iterator => _LinkedListIterator<E>(this);

  @override
  bool get isEmpty => head == null;
}

class _LinkedListIterator<E> implements Iterator<E> {
  final LinkedList<E> _linkedList;
  Node<E>? _currentNode;
  bool _firstPass = true;

  _LinkedListIterator(this._linkedList);

  @override
  E get current => _currentNode!.value;

  @override
  bool moveNext() {
    if (_linkedList.isEmpty) return false;
    //first using the iterator
    if (_firstPass) {
      _currentNode = _linkedList.head;
      _firstPass = false;
    } else {
      _currentNode = _currentNode?.next;
    }
    return _currentNode != null;
  }
}

//eg
void doLinkedListByHand() {
  final node1 = Node<int>(value: 1);
  final node2 = Node(value: 2); //dart type infer
  final node3 = Node(value: 3);
  //relationship define by hand
  node1.next = node2;
  node2.next = node3;
  print(node1);
}

void doPush() {
  final list = LinkedList();
  list
    ..push(1)
    ..push(2)
    ..push(3)
    ..append(4);
  print(list); //3 -> 2 -> 1
}

void doAppend() {
  final list = LinkedList();
  list
    ..append(1)
    ..append(2)
    ..append(3);
  print(list); //1 -> 2 -> 3
}

void doInsertAfter() {
  final list = getTestLinkedList([1, 2, 3]); //1 -> 2 -> 3
  list.insertAfter(list.nodeAt(1)!, 4); //1 -> 2 -> 4 -> 3
  print(list);
}

void doPop() {
  final list = LinkedList<int>();
  // list
  //   ..append(1)
  //   ..append(2)
  //   ..append(3); //1 -> 2 -> 3
  print('${list..pop()}'); //2 -> 3
}

void doRemoveLast() {
  final list = getTestLinkedList([1, 2, 3]); //1 -> 2 -> 3
  print('${list.removeLast()}');
}

void doRemoveAfter() {
  final list = getTestLinkedList([1, 2, 3]); //1 -> 2 -> 3
  print(list..removeAfter(list.nodeAt(0)!));
}

void doIterate() {
  final list = getTestLinkedList([1, 2, 3]); //1 -> 2 -> 3
  for (var e in list) print(e);
}

//ex1
void doPrintInReverse() {
  final linkedList = getTestLinkedList([1, 2, 3]); //1 -> 2 -> 3
  Stack stack = Stack.of(linkedList);
  while (stack.isNotEmpty) print(stack.pop());
}

//ex2
// 1 -> 2 -> 3 -> 4 -> null
// middle is 3
// 1 -> 2 -> 3 -> null
// middle is 2
void doFindMiddle() {
  final linkedList = getTestLinkedList([1, 2, 3, 4]); //1 -> 2 -> 3 -> 4
  int? node;
  while (linkedList.isNotEmpty) {
    node = linkedList.pop();
    if (linkedList.isEmpty) {
      print(node);
      return;
    }
    node = linkedList.removeLast();
    if (linkedList.isEmpty) {
      print(node);
      return;
    }
  }
}

//ex3
// before
// 1 -> 2 -> 3 -> null
// after
// 3 -> 2 -> 1 -> null
void doLLReverse() {
  final linkedList = getTestLinkedList([1, 2, 3]); //1 -> 2 -> 3
  final reversedList = LinkedList<int>();
  while (linkedList.isNotEmpty) reversedList.push(linkedList.pop()!);
  print(reversedList);
}

//ex4
// original list
// 1 -> 3 -> 3 -> 3 -> 4
// list after removing all occurrences of 3
// 1 -> 4
void doRemoveAllOccur() {
  final linkedList = getTestLinkedList([1, 3, 3, 3, 4]); //1 -> 3 -> 3 -> 3 -> 4
  final targetNode = linkedList.nodeAt(1);
}

LinkedList<int> getTestLinkedList(List<int> list) {
  LinkedList<int> linkedList = LinkedList<int>();
  list.forEach(linkedList.append);
  return linkedList;
}
