class User {
  int? id;
  String username;
  String email;
  String password;

  User({required this.email, required this.username, this.id, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'], username: json['username'], email: json['email'], password: json['password']);
  }
}

class CompoundOwner extends User {
  String firstName;
  String lastName;
  String phoneNo;

  CompoundOwner(
      {int? id,
      required String username,
      required String email,
      required String password,
      required this.firstName,
      required this.lastName,
      required this.phoneNo})
      : super(id: id, username: username, email: email, password: password);

  factory CompoundOwner.fromJson(Map<String, dynamic> json) {
    return CompoundOwner(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        password: json['password'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        phoneNo: json['phoneNo']);
  }
}

class SpotReservingUser extends User {
  String firstName;
  String lastName;
  String phoneNo;

  SpotReservingUser(
      {required int id,
      required String username,
      required String email,
      required String password,
      required this.firstName,
      required this.lastName,
      required this.phoneNo})
      : super(id: id, username: username, email: email, password: password);

  factory SpotReservingUser.fromJson(Map<String, dynamic> json) {
    return SpotReservingUser(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        password: json['password'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        phoneNo: json['phoneNo']);
  }
}
