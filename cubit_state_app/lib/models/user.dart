class User {
  
  User({
    required this.name,
    required this.age,
    required this.professions,
  });
  
  String name;
  int age;
  List<String> professions;

  copyWith({
    String? name,
    int? age,
    List<String>? professions
  }) => User(
    name: name ?? this.name,
    age: age ?? this.age,
    professions: professions ?? this.professions
  );
}