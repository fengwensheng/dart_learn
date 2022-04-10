import 'queue.dart';
import 'stack.dart';

class TreeNode<T> {
  T value;
  List<TreeNode<T>> children = [];
  TreeNode(this.value);

  ///
  ///add a child to current node
  ///
  void add(TreeNode<T> child) => children.add(child);

  @override
  String toString() => value.toString();

  ///
  ///1.depth-first traversal
  ///anonymous function for pass some logic in, e.g. Search
  ///
  void depthFirst(void Function(TreeNode<T> node) doAction) {
    doAction(this);
    for (final child in this.children) child.depthFirst(doAction);
  }

  ///
  ///recursive is basd on stack
  ///using stack directly.
  ///
  void depthFirstStack(void Function(TreeNode<T> node) doAction) {
    final stack = Stack<TreeNode<T>>()..push(this);
    while (!stack.isEmpty) {
      final child = stack.pop();
      doAction(child);
      child.children.reversed.forEach(stack.push);
    }
  }

  ///
  ///2.level-order traversal
  ///
  void levelOrder(void Function(TreeNode<T> node) doAction) {
    final queue = QueueDoubleStack<TreeNode<T>>()..enqueue(this);
    while (!queue.isEmpty) {
      final node = queue.dequeue();
      doAction(node!);
      node.children.forEach((e) => queue.enqueue(e));
    }
  }

  ///
  ///search
  ///
  TreeNode<T>? searchLevelOrder(T value) {
    TreeNode<T>? node;
    final searchFilter = (TreeNode<T> n) {
      if (n.value == value) {
        node = n;
      }
    };
    levelOrder(searchFilter);
    return node;
  }
}

///
///challenge mini version of Futter Widget Tree.
///Tree nodes as widgets
///
class Widget {
  Widget();
}

class Column extends Widget {
  final List<Widget> children;
  Column({
    this.children = const <Widget>[],
  });
}

class Padding extends Widget {
  final Widget? child;
  Padding({
    this.child,
  });
}

class Text extends Widget {
  final String text;
  Text(this.text);
}

void main() {
  final beverages = TreeNode<String>('beverages');

  final hot = TreeNode<String>('hot');
  final cold = TreeNode<String>('cold');

  final tea = TreeNode('tea');
  final redTea = TreeNode('redTea');
  final greenTea = TreeNode('greenTea');

  final cola = TreeNode<String>('cola');
  beverages
    ..add(hot)
    ..add(cold);
  hot.add(tea);

  tea
    ..add(redTea)
    ..add(greenTea);

  cold..add(cola);
  // beverages.depthFirst(print);
  // beverages.depthFirstStack(print);
  // beverages.levelOrder(print);
  // print(beverages.searchLevelOrder('redTea'));

  // ignore: unused_local_variable
  Widget widgets = Column(
    children: [
      Text('text1'),
      Padding(
        child: Padding(
          child: Text('text2'),
        ),
      ),
    ],
  );
}
