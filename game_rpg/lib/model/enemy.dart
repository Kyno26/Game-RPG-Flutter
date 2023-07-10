class Enemy {
  late final int id;
  late final String name;
  late final int hp;
  late final int atk;
  late final int def;
  late final int spd;
  late final int acc;
  late final int crit;
  late final String image;
  late final String defAction;
  late final String actionList;
  late final String? passiveList;
  late final String animated;
  late final String healthy;
  late final String low;
  late final int lowHealth;
  // late final String skillName;
  // late final String skillDesc;

  Enemy.empty();

  Enemy({
    required this.id,
    required this.name,
    required this.hp,
    required this.atk,
    required this.def,
    required this.spd,
    required this.acc,
    required this.crit,
    required this.image,
    required this.defAction,
    required this.actionList,
    required this.passiveList,
    required this.animated,
    required this.healthy,
    required this.low,
    required this.lowHealth,
    // required this.skillName,
    // required this.skillDesc,
  });

  factory Enemy.fromMap(Map<String, dynamic> json){
    return Enemy(
      id: json['id'],
      name: json['name'],
      hp: json['hp'],
      atk: json['atk'],
      def: json['def'],
      spd: json['speed'],
      acc: json['acc'],
      crit: json['crit_rate'],
      image: json['image'],
      defAction: json['def_act'],
      actionList: json['action_list'],
      passiveList: json['size'],
      animated: json['animated'],
      healthy: json['healthy'],
      low: json['low'],
      lowHealth: json['low_health'],
      // skillName: json['skill_name'],
      // skillDesc: json['skill_desc'],
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
    'image': image,
    'def_action': defAction,
    'action_list': actionList,
    'size': passiveList,
    'animated': animated,
    'healthy': healthy,
    'low': low,
    'low_health': lowHealth,
    // 'skill_name': skillName,
    // 'skill_desc': skillDesc,
  };
}