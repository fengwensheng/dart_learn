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

class LinkedList<E> {
  Node<E>? head;
  Node<E>? tail;
  bool get isEmpty => head == null;
  //insert front
  void push(E value) {
    this.head = Node(value: value, next: this.head);
    tail ??= head;
  }

  //insert end
  void append(E value) {
    if (isEmpty) {
      push(value);
      return;
    }
    this.tail!.next = Node<E>(value: value);
    this.tail = this.tail!.next;
  }

  //insert middle1: find node
  Node<E>? nodeAt(int index) {
    Node<E>? node = head;
    for (int i = 0; i < index; i++) {
      node = node?.next;
    }
    return node;
  }

  //insert middle2: insert after
  Node<E> insertAfter(Node<E> curNode, E value) {
    if (tail == curNode) {
      append(value);
      return tail!;
    }
    curNode.next = Node(value: value, next: curNode.next);
    return curNode.next!;
  }

  @override
  String toString() {
    if (isEmpty) return 'Empty list';
    return head.toString();
  }
}

//eg
void linkedListByHand() {
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
  final list = LinkedList();
  list
    ..append(1)
    ..append(2)
    ..append(3); //1 -> 2 -> 3
  list.insertAfter(list.nodeAt(1)!, 4); //1 -> 2 -> 4 -> 3
  print(list);
}
