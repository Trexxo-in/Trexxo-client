import 'package:trexxo_mobility/models/user_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {
  final UserModel user;

  Authenticated(this.user);
}

class Unauthenticated extends AuthState {}
