var player01 = {
  'name': 'Leeroy Jenkins',
  'sex': 'M',
  'class': 'Knight',
  'hp': 1000
};

Map player02 = {
  'name': 'Jarod Lee Nandin',
  'sex': 'M',
  'class': 'Overlord',
  'hp': 9000
};

Map<String, dynamic> player03 = {
  'name': 'Samantha Evelyn Cook',
  'sex': 'F',
  'class': 'Gunter',
  'hp': 5000
};

void main() {
  print(player01);
  print("${player01.runtimeType}");
  print(player02);
  print("${player02.runtimeType}");
  print(player03);
  print("${player03.runtimeType}");

  var player04 = Map();
  player04['name'] = 'Gordon Freeman';
  player04['sex'] = 'M';
  player04['class'] = 'Scientist';
  player04['hp'] = 6000;

  print("player04: $player04");
  print("player04: ${player04.runtimeType}");

  var player05 = {
    'name': 'Jane Doe', 
    'sex': 'F', 
    'class': 'Human', 
    'hp': 999
  };
  print('player05: $player05');

  player05['armor'] = 'None';
  player05.remove('hp');
  print('player05: $player05');

  var moreStuff = {
    'mp': 1, 
    'money': 2, 
    'xp': 3, 
    'level': 4
  };

  player01.addAll(moreStuff);
  player02.addAll(moreStuff);
  player03.addAll(moreStuff);
  player04.addAll(moreStuff);
  player05.addAll(moreStuff);

  print('keys in player05: ${player05.keys}');
  print('values in player05: ${player05.values}');

  List<Map> playerList = [player01, player02, player03, player04, player05];

  print('$playerList');

  print('second player name: ${playerList[1]['name']}');

  for (var player in playerList) {
    print("name: ${player['name']}, class: ${player['class']}");
  }

  // assuming you meant .clear not remove
  player01.clear();
  print('$playerList');
}
