abstract class Queue<T> {
  ///insert new element at back of queue
  bool enquue(T e);

  ///remove the element front of queue
  T? dequeue();

  ///check if empty
  bool isEmpty();

  ///retrieve the front
  T? get peek;
}
