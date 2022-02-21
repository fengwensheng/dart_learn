import 'dart:core';

void testSet() {
  //define, iterial
  Set set0 = {"foo", "bar"};
  set0.add("foo"); //x
  set0.add("foo1");
  print(set0); //{foo, bar, foo1}
  //un-unduplicate
  List list1 = [1, 2, 2, 3];
  print(list1); //[1, 2, 2, 3]
  Set set1 = Set.from(list1);
  print(set1); //{1, 2, 3}
  List undupList = List.from(set1);
  List.from(Set.from(list1));
  print(undupList); //[1, 2, 3]
  //get dunplicate
  List<int> list2 = [1, 2, 2, 3];
  Set<int> set2 = {};
  //lazy
  // final list3 = list2.map((e) => findDup(e, set2));
  // print(set2);
  // print(list3);
  for (var l in list2) {
    if (set2.contains(l)) {
      print('duplication item:$l');
    }
    set2.add(l);
  }
  print(set2);
}

//lazy
bool findDup(int e, Set<int> set) {
  bool notDup = true;
  if (set.contains(e)) {
    notDup = false;
    print('duplication item:$e');
  }
  set.add(e);
  print(set);
  return notDup;
}
