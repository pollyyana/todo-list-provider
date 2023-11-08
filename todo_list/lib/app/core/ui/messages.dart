
import 'package:flutter/material.dart';
import 'package:todo_list/app/core/ui/theme_extension.dart';

class Messages {
  final BuildContext context;
  Messages._(this.context);
  
  factory Messages.of(BuildContext context){
    return Messages._(context);
  }

  void showError(String message) => _showMessages(message, Colors.red);
  void showInfo(String message) => _showMessages(message,context.primaryColor);

  void _showMessages(String message, Color color){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ));
  }
}