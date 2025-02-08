import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String? name;
  final String? email;
  final String? password;

  const User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password});

  @override
  List<Object?> get props => [id, name, email, password];

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
      };

  factory User.fromMap(Map<String, dynamic> map) => User(
        id: map['id'],
        name: map['name'],
        email: map['email'],
        password: map['password'],
      );
}
