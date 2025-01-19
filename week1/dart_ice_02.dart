void main() {
  // NOTE: when you say # item, im assuming the nth occurance instead of nth index

  var myList1 = [0, 0, 0, 0, 0];
  myList1[1] = 1;
  print('$myList1');

  var myList2 = [];
  myList2.addAll(['a', 1, 1.1, true]);
  print('$myList2');

  myList2.insert(1, 'IGME');
  print('$myList2');

  var myList3 = ['item1', 'item2', 'item3'];
  myList2.addAll(myList3);
  print('$myList2');

  var myList4 = [123.4, 'item 6', false];
  myList2.insertAll(0, myList4);
  print('$myList2');

  var myList5 = <String>[];
  myList5.addAll(['Hello', 'World', 'Dart', 'is', 'fun']);
  print('$myList5');

  myList5.removeAt(2);
  print('$myList5');

  myList5.removeLast();
  print('$myList5');

  myList2.removeRange(2, 6);
  print('$myList2');
}
