
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_list/app/exceptions/auth_exception.dart';

import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);

      if (e.code == 'email-already-in-user') {
        final loginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);
        if (loginTypes.contains('password')) {
          throw AuthException(
              message: 'E-mail já utilizado , por favor escolha outro e-mail');
        } else {
          throw AuthException(
              message:
                  'VOce se cadastrou no TodoList pelo Google, por favor utilize ele para entrar');
        }
      } else {
        throw AuthException(message: e.message ?? 'Erro ao registrar usuario');
      }
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
      throw AuthException(message: e.message ?? 'Erro ao realizar login');
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      // if (e.code == 'INVALID_LOGIN_CREDENTIALS' || e.code == 'user-not-found') {
      if (e.code == 'wrong-password') {
        throw AuthException(message: 'login ou senha invalidos');
      }
      throw AuthException(message: e.message ?? 'Erro ao realizar login');
    }
  }

  @override
  Future<User?> forgotPassword(String email) async {
    try {
      final loginMethods =
          await _firebaseAuth.fetchSignInMethodsForEmail(email);

      if (loginMethods.contains('password')) {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      } else if (loginMethods.contains('google')) {
        throw AuthException(
            message:
                'Cadastro Realizado com o Google, nao pode ser resetada a senha');
      } else {
        throw AuthException(message: 'Email nao cadastrado');
      }
    } on PlatformException catch (e, s) {
      print(e);
      print(s);

      throw AuthException(message: 'Erro ao resetar senha');
    }
  }

  @override
  Future<User?> googleLogin() async {
    List<String>? loginMethods;
    try {
      final googleSignIn = GoogleSignIn();
      final googleleUser = await googleSignIn.signIn();
      if (googleleUser != null) {
       loginMethods =
            await _firebaseAuth.fetchSignInMethodsForEmail(googleleUser.email);
        if (loginMethods.contains('password')) {
          throw AuthException(
              message:
                  'Voce utilizou o e-mail para cadastro no Todo List, caso tenha esquecido sua senha, por favor clique no link esqueci minha senha ');
        } else {
          final googleAuth = await googleleUser.authentication;
          final firebaseCredential = GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
          var userCredential =
              await _firebaseAuth.signInWithCredential(firebaseCredential);
          //credencial do google
          return userCredential.user;
        }
      }
    } on FirebaseAuthException catch (e, s) {
      print(e);
      print(s);
      if (e.code ==  'accout-exists-with-different-credential') {
        throw AuthException(message:'Login invalido voce se registrou no Todo list  com os seguintes provedores : ${loginMethods?.join(',')}');
      }else{
        throw AuthException(message: 'Erro ao realizar login');
      }
    }
  }
  
  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    _firebaseAuth.signOut();
  }
}
