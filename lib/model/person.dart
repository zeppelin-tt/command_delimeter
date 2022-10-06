class Person {
  String name;
  bool captain;

  Person(this.name, {this.captain = false});

  @override
  String toString() => 'Person{name: $name, captain: $captain}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Person && runtimeType == other.runtimeType && name == other.name && captain == other.captain;

  @override
  int get hashCode => name.hashCode ^ captain.hashCode;

  Person copyWith({String? name, bool? captain}) => Person(name ?? this.name, captain: captain ?? this.captain);

  Map<String, dynamic> toMap() => {
        'name': this.name,
        'captain': this.captain,
      };

  factory Person.fromMap(Map<String, dynamic> map) => Person(map['name'] as String, captain: map['captain'] as bool);
}
