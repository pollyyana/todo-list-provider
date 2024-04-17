// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

import 'package:todo_list/app/core/notifier/defaul_change_notifier.dart';
import 'package:todo_list/app/core/ui/messages.dart';

class DefaulListenerNotifier {
  final DefaulChangeNotifier changeNotifier;

  DefaulListenerNotifier({
    required this.changeNotifier,
  });

  void listener({
    required BuildContext context,
    required SuccessVoidCallback successCallback,
    EverVoidCallback? everCallback,
    ErrorVoidCallback? errorCallback,
  }) {
    changeNotifier.addListener(() {
      if (everCallback != null) {
        everCallback(changeNotifier, this);
      }
      if (changeNotifier.loading) {
        Loader.show(context);
      } else {
        Loader.hide();
      }

      //verifica se tem algum erro
      if (changeNotifier.hasError) {
        if (errorCallback != null) {
          errorCallback(changeNotifier, this);
        }
        Messages.of(context).showError(changeNotifier.error ?? 'Erro interno');
      } else if (changeNotifier.isSuccess) {
        if (successCallback != null) {
          successCallback(changeNotifier, this);
        }
      }
    });
  }

  void dispose() {
    changeNotifier.removeListener(() {});
  }
}

typedef SuccessVoidCallback = void Function(
    DefaulChangeNotifier notifier, DefaulListenerNotifier listenerInstance);

typedef ErrorVoidCallback = void Function(
    DefaulChangeNotifier notifier, DefaulListenerNotifier listenerInstance);

typedef EverVoidCallback = void Function(
    DefaulChangeNotifier notifier, DefaulListenerNotifier listenerInstance);
