import 'package:firebase_auth/firebase_auth.dart';

abstract class UserService {
  Future<User?> register(String email, String passsword);
  Future<User?> login(String email, String passsword);
  Future<User?> forgotPassword(String email);
}
