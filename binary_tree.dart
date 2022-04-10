class BinaryTree<T> {
  T value;
  BinaryTree<T>? left;
  BinaryTree<T>? right;
  BinaryTree(this.value);

  ///
  ///build a left-to-right-growth visual print
  ///based on depth-first using the Recursive
  ///print the right-depth one firstly, and then the left-depth
  ///
  ///0
  ///1 2
  ///3 4 5 6
  ///
  ///=>
  ///
  ///[ ][ ][6]
  ///[ ][2][ ]
  ///[ ][ ][5]
  ///[0][ ][ ]
  ///[ ][ ][4]
  ///[ ][1][ ]
  ///[ ][ ][3]

  String visualPrint(BinaryTree<T> node) {
    if (node.left == null && node.right == null) {
      return '${node.value}\n';
    }
    if (node.left != null) {
      return '${node.value}${visualPrint(node.left!)}';
    }
    if (node.right != null) {
      return '${node.value}${visualPrint(node.right!)}';
    }
    return '';
  }
}

///
///0
///1 2
///3 4 5 6
///
BinaryTree<int> createByHand() {
  //0
  final zero = BinaryTree<int>(0);
  //1 2
  final one = BinaryTree<int>(1);
  final two = BinaryTree<int>(2);
  zero
    ..left = one
    ..right = two;
  //3 4 5 6
  final three = BinaryTree<int>(3);
  final four = BinaryTree<int>(4);
  one
    ..left = three
    ..right = four;
  final five = BinaryTree<int>(5);
  final six = BinaryTree<int>(6);
  two
    ..left = five
    ..right = six;
  return zero;
}

void main() {
  final bt = createByHand();
  print(bt.visualPrint(bt));
}
