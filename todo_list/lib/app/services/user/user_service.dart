import 'package:firebase_auth/firebase_auth.dart';

abstract class UserService {
  Future<User?> register(String email, String passsword);
  Future<User?> login(String email, String passsword);
  Future<User?> forgotPassword(String email);
  Future<User?> googleLogin();
    Future<void> logout();



}
//implementa as coisas do repository no service pra ter acesso a controller