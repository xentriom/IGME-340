void main() {
  addThree(first: 1, second: 10, third: 2);

  var ss1 = joinStrings(s1: "aoef", s2: "oauehf");
  var ss2 = joinStrings(s1: "aoef", s2: "oauehf", s3: "aeifu", s4: "20837r");
  print(ss1);
  print(ss2);

  Map mm1 = hiLow(num1: 12.34, num2: 45.67, num3: 89.01);
  print(mm1);

  Map mm2 = makeCharacter(
    name: 'Aragorn',
    playerClass: 'Ranger',
    hp: null,
  );
  print(mm2);
}

// named function for add 3
void addThree({required int first, required int second, required int third}) {
  print("$first + $second + $third = ${first + second + third}");
}

// named function for joining string, 2 is required
String joinStrings(
    {required String s1,
    required String s2,
    String? s3 = "hey",
    String? s4 = "bob"}) {
  return "$s1 $s2 $s3 $s4";
}

// function to return high, low, sum of 3 numbers
Map hiLow({required double num1, required double num2, required double num3}) {
  var sum = num1 + num2 + num3;

  return {
    "sum": sum,
    "high": sum.ceil(),
    "low": sum.floor(),
  };
}

// named function that return character with default value
Map makeCharacter({
  required String name,
  required String playerClass,
  int? mp = 50,
  int? hp = 100,
}) {
  return {
    'name': name,
    'playerClass': playerClass,
    'mp': mp,
    'hp': hp,
    'xp': 0,
    'level': 1,
  };
}
