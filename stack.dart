class Stack<E> {
  final List<E> _storge;
  Stack() : this._storge = <E>[]; //Initialize list vs. Contructor argument
  void push(E e) => _storge.add(e);
  E pop() => _storge.removeLast();
  //nice-to-have, non-essential
  E get peek => _storge.last;
  bool get isEmpty => _storge.isEmpty;
  bool get isNotEmpty => _storge.isNotEmpty;
  //from iterale
  Stack.of(Iterable<E> es) : _storge = List.of(es);
  @override
  String toString() => '---Top---\n${_storge.reversed.join('\n')}\n---------';
}

//****************

void testStack() {
  final stack = Stack<int>();
  stack.push(1);
  stack.push(2);
  stack.push(3);
  stack.push(4);
  print(stack);
  final ele = stack.pop();
  print('Popped: $ele');

  final stack1 = Stack.of([1, 3, 5]);
  print(stack1);
  stack1.pop();
}

//challenge1
void reverseList<T>(List<T> list) {
  //generic method, T
  final stack = Stack<T>();
  for (var e in list) stack.push(e);
  while (stack.isNotEmpty) print(stack.pop());
}

//challenge2
bool balanceParentheses(String str) {
  final stack = Stack();
  final open = '('.codeUnitAt(0);
  final close = ')'.codeUnitAt(0);
  for (var codeUnit in str.codeUnits) {
    if (codeUnit == open) stack.push(open);
    if (codeUnit == close) {
      if (stack.isEmpty) {
        return false;
      } else {
        stack.pop();
      }
    }
  }
  return stack.isEmpty;
}
