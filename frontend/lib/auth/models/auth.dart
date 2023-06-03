class User {
  int? id;
  String? username;
  String email;
  String password;
  String? role;

  User(
      {required this.email,
      this.username,
      this.id,
      required this.password,
      this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        password: json['password'],
        role: json['role']);
  }
}

class CompoundOwner extends User {
  String firstName;
  String lastName;

  CompoundOwner({
    int? id,
    required String username,
    required String email,
    required String password,
    required this.firstName,
    required this.lastName,
  }) : super(id: id, username: username, email: email, password: password);

  factory CompoundOwner.fromJson(Map<String, dynamic> json) {
    return CompoundOwner(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}

class SpotReservingUser extends User {
  String firstName;
  String lastName;

  SpotReservingUser({
    int? id,
    required String username,
    required String email,
    required String password,
    required this.firstName,
    required this.lastName,
  }) : super(id: id, username: username, email: email, password: password);

  factory SpotReservingUser.fromJson(Map<String, dynamic> json) {
    return SpotReservingUser(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}
