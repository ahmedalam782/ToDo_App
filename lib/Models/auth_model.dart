class AuthModel {
  String id;
  String name;
  String email;

  AuthModel({
    this.id = '',
    required this.name,
    required this.email,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        'name': name,
        "email": email,
      };
}
