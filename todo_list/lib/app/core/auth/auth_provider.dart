//provedor de autentificacao

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/app/core/navigator/todo_list_navigator.dart';
import 'package:todo_list/app/services/user/user_service.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth;
  final UserService _userService;

  AuthProvider({
    required FirebaseAuth firebaseAuth,
    required UserService userService,
  })  : _firebaseAuth = firebaseAuth,
        _userService = userService;

  //atalho para o logout
   Future<void> logout() => _userService.logout();

  //pegar os dados do usuario (opcional pois pode nao estar logado)
  User? get user => _firebaseAuth.currentUser;

  //metodo que faz listeners(responsavel por escultar firebase) Ele pode fazer alterações
  void loadListener(){
    //userchanges = qualquer alteraçao no dados do usuario ele vai acessar a stream, qlq alteração ele notifica a streame
    _firebaseAuth.userChanges().listen((_) => notifyListeners());
    //alteração de login
    _firebaseAuth.authStateChanges().listen((user) { 
      if (user != null) {
         TodoListNavigator.to.pushNamedAndRemoveUntil('/home', (route) => false);
      }else{
        TodoListNavigator.to.pushNamedAndRemoveUntil('/login', (route) => false);
      }
    });
  }

}
