class Character {

  final String name;
  final int height;
  final String gender;

  Character({this.name, this.height, this.gender});

  factory Character.fromJSON(Map<String, dynamic> json) {
    return Character(
      name: json['name'],
      height: int.parse(json['height']),
      gender: json['gender']
    );
  }
}