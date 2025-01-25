List<dynamic> monsters = [];

class Monster {
  String name;
  int hp;
  int speed;
  int score;
  String type;

  Monster(
      {this.name = "",
      this.hp = 0,
      this.speed = 0,
      this.score = 0,
      this.type = "Monster"});

  void status() {
    print("name: $name, hp: $hp, speed: $speed, score: $score, type: $type");
  }
}

class Goomba extends Monster {
  String color;
  int dmg;

  Goomba(
      {super.name,
      super.hp,
      super.speed,
      super.score,
      this.color = "brown",
      this.dmg = 20})
      : super(type: "Goomba");

  @override
  void status() {
    print("name: $name, hp: $hp, speed: $speed, score: $score, type: $type, color: $color, dmg: $dmg");
  }
}

class Boo extends Monster {
  int mp;

  Boo({super.name, super.hp, super.speed, super.score, this.mp = 50})
      : super(type: "Boo");

  void castSpell(int cost) {
    if (mp >= cost) {
      mp -= cost;
      print("$name casts a spell, $mp left.");
    } else {
      print("$name does not have enough mp.");
    }
  }

  @override
  void status() {
    print("name: $name, hp: $hp, speed: $speed, score: $score, type: $type, mp: $mp");
  }
}

void makeSomeMonsters() {
  monsters.add(Goomba(name: "Goomba1", hp: 12, speed: 1, score: 38));
  monsters.add(Goomba(name: "Goomba2", hp: 54, speed: 1, score: 10));
  monsters.add(Boo(name: "Boo1", hp: 93, speed: 1, score: 87, mp: 348));
  monsters.add(Boo(name: "Boo2", hp: 10, speed: 1, score: 98, mp: 874));
}

void showMonsters(String type) {
  for (Monster monster in monsters) {
    if (monster.type == type) {
      monster.status();
    }
  }
}

void main() {
  makeSomeMonsters();
  print("Goombas:");
  showMonsters("Goomba");
  print("");
  print("Boos:");
  showMonsters("Boo");
}
