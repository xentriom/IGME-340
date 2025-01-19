void main() {
  int myNumber = 1234;
  double myFloat = 1234.6234;
  String myString = "Hello World";
  bool myBoolean = false;
  const myConst = "I don't change";
  final iAmFinal;
  dynamic iAmDynamic;
  var iAmVar;

  // add your new code here.
  print('myString is $myString, myFloat is $myFloat');
  print('myString uppercased is ${myString.toUpperCase()}');
  print('myFloat rounded up is ${myFloat.ceil()}, myFloat rounded down is ${myFloat.floor()}');

  // print seconds since epoch
  var now = DateTime.now();
  var secondsFromEpoch = now.millisecondsSinceEpoch / 1000;
  print('$secondsFromEpoch seconds since 1970');

  // print abs of -999
  print('absolute value of -999 is ${(-999).abs()}');

  // dynamic variable manipulation
  dynamic variable = 1234;
  print('$variable');
  variable = 'Hello there!';
  print('$variable');

  // forloop, break at 10
  for (var i = 0; i <= 20; i++) {
    if (i == 10) break;
    print('$i');
  }

  // while loop, break at 10
  var intCounter = 0;
  while (intCounter <= 20) {
    if (intCounter == 10) break;
    print('$intCounter');
    intCounter++;
  }
}
