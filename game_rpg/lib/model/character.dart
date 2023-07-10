class Character {
  late final int id;
  late final String name;
  late final int hp;
  late final int atk;
  late final int def;
  late final int spd;
  late final int acc;
  late final int crit;
  late final String skillName;
  late final String skillDesc;
  late final String imageUnlocked;    
  late final String imageLocked;
  late final String imageFull;
  late final String attackEffect;

  Character.empty();

  Character({
    required this.id,
    required this.name,
    required this.hp,
    required this.atk,
    required this.def,
    required this.spd,
    required this.acc,
    required this.crit,
    required this.skillName,
    required this.skillDesc,
    required this.imageUnlocked,
    required this.imageLocked,
    required this.imageFull,
    required this.attackEffect,
  });

  factory Character.fromMap(Map<String, dynamic> json){
    return Character(
      id: json['id'],
      name: json['name'],
      hp: json['hp'],
      atk: json['atk'],
      def: json['def'],
      spd: json['speed'],
      acc: json['acc'],
      crit: json['crit_rate'],
      skillName: json['skill_name'],
      skillDesc: json['skill_desc'],
      imageUnlocked: json['image_unlocked'],
      imageLocked: json['image_locked'],
      imageFull: json['image_full'],
      attackEffect: json['attack_effect']
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'hp': hp,
    'att': atk,
    'def': def,
    'speed': spd,
    'acc': acc,
    'crit_rate': crit,
    'skill_name': skillName,
    'skill_desc': skillDesc,
    'image_unlocked': imageUnlocked,
    'image_locked': imageLocked,
    'image_full': imageFull,
    'attack_effect': attackEffect
  };
}