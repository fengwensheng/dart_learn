class MyType {
  String id;
  int num;
  MyType(this.id, this.num);
}

void testMap() {
  Map<String, int> scores = {
    'Eric': 9,
    'Mark': 12,
  };
  print(scores);
  //actually, default Map is LinkedHashMap, order-able
  //insert time, O(1)
  scores['End'] = 100;
  print(scores); //{Eric: 9, Mark: 12, End: 100}

  //custom type as key
  MyType key1 = MyType('001', 80);
  MyType key2 = MyType('002', 90);
  Map<MyType, String> myTypes = {
    key1: 'Vincent',
    key2: 'Alice',
  };
  print(myTypes[key1]); //Vincent
}
