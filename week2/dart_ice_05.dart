class Player {
  String name;
  int lives;
  int score;
  int xp;
  int speed;

  Player(
      {this.name = "Unknown",
      this.lives = 0,
      this.score = 0,
      this.xp = 0,
      this.speed = 0});

  void status() {
    print("player: $name, lives: $lives, score: $score, xp: $xp, speed: $speed");
  }

  void levelUp() {
    xp += 100;
    speed += 10;
    score += 500;
    status();
  }
}

class Treasure {
  String name = "Unknown";
  int value = 0;
  String rarity = "Common";
  String type = "Relic";

  Treasure(this.name, this.value, this.rarity, this.type);

  void status() {
    print("treasure: $name, value: $value, rarity: $rarity, type: $type");
  }
}

void main() {
  print("============================");
  print("Player");
  print("============================");
  // create a player, call status, and level her 10x
  Player hanabi = Player(name: "Hanabi", lives: 1, score: 0, xp: 0, speed: 5);
  hanabi.status();
  for (int i = 0; i < 10; i++) {
    hanabi.levelUp();
  }
  print("");

  print("============================");
  print("Treasures");
  print("============================");
  // create a list of 5 treasures, call status on them
  List<Treasure> treasures = [
    Treasure("Special Pass", 160, "Legendary", "Warp Item"),
    Treasure("Tracks of Destiny", 60, "Legendary", "Trace Material"),
    Treasure("Condensed Aether", 5, "Rare", "EXP Material"),
    Treasure("Starfire Essence", 18, "Rare", "Ascension Material"),
    Treasure("Meteoric Bullet", 12, "Uncommon", "Ascension Material")
  ];
  for (Treasure treasure in treasures) {
    treasure.status();
  }
  print("");

  print("============================");
  print("Cascading/Chaining stuff");
  print("============================");
  // use chaining to create player and add to treasure list
  Player()
    ..name = "Cocolia"
    ..lives = 2
    ..score = 0
    ..xp = 0
    ..speed = 158
    ..status();
  treasures
    ..add(Treasure("Destined Expiration", 18, "Rare", "Ascension Material")
      ..status());
  print("");

  print("============================");
  print("Final list");
  print("============================");
  // output entire list after add
  for (Treasure treasure in treasures) {
    treasure.status();
  }
}
