/// Model danych przyjaciela/użytkownika.
class DevFriendModel {
  final int id;
  final String name;
  final int age;
  final String imageUrl;
  // Można dodać inne pola, np. opis, dystans, wspólni znajomi itd.

  DevFriendModel({
    required this.id,
    required this.name,
    required this.age,
    required this.imageUrl,
  });

  // Przykładowy konstruktor z map (jeśli dane z JSON z API):
  factory DevFriendModel.fromJson(Map<String, dynamic> json) {
    return DevFriendModel(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      imageUrl: json['imageUrl'],
    );
  }

  // (Opcjonalnie) metoda toJson() jeśli potrzebne.
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'age': age,
    'imageUrl': imageUrl,
  };
}
