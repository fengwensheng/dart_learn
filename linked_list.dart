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

void linkedListByHand() {
  final node1 = Node<int>(value: 1);
  final node2 = Node(value: 2); //dart type infer
  final node3 = Node(value: 3);
  //relationship define by hand
  node1.next = node2;
  node2.next = node3;
  print(node1);
}
