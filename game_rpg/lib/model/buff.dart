class Buff{
  late final int id;
  late final String buffName;
  late final String buffType;
  late final int buffEffect;
  late final int buffDuration;
  late int currentDuration;

  Buff.empty();

  Buff({
    required this.id,
    required this.buffName,
    required this.buffType,
    required this.buffEffect, 
    required this.buffDuration,
    required this.currentDuration,
  });

  factory Buff.fromMap(Map<String, dynamic> json) {
    return Buff(
      id: json['id'], 
      buffName: json['buff_name'], 
      buffType: json['buff_type'], 
      buffEffect: json['buff_effect'],
      buffDuration: json['buff_duration'],
      currentDuration: json['current_duration'],
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'buff_name': buffName,
    'buff_type': buffType,
    'buff_effect': buffEffect,
    'buff_duration': buffDuration,
    'current_duration': currentDuration,
  };
}