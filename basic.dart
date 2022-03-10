int testIntBinaryOp() {
  return (255 * 2) | 3;
  // return (5 | 3) << 1;
}

///cache 空间局部性原理
void testCache() {
  //init
  final list = List<List<int>>.filled(10000, List.filled(10000, 1));
  int sum = 0;
  //ordered 顺序
  int start = DateTime.now().millisecondsSinceEpoch;
  for (int i = 0; i < 10000; i++) {
    for (int j = 0; j < 10000; j++) {
      sum += list[i][j];
    }
  }
  int end = DateTime.now().millisecondsSinceEpoch;
  print('ordered: sum=$sum, cost=${end - start}');

  //un-ordered 无序
  sum = 0;
  start = DateTime.now().millisecondsSinceEpoch;
  for (int i = 0; i < 10000; i++) {
    for (int j = 0; j < 10000; j++) {
      sum += list[j][i];
    }
  }
  end = DateTime.now().millisecondsSinceEpoch;
  print('un-ordered: sum=$sum, cost=${end - start}');
}

void main() {
  testCache();
}
