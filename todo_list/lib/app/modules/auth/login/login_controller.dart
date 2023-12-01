import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list/app/core/notifier/defaul_change_notifier.dart';
import 'package:todo_list/app/exceptions/auth_exception.dart';
import 'package:todo_list/app/services/user/user_service.dart';

class LoginController extends DefaulChangeNotifier {
  final UserService _userService;
  String? infoMessage;

  LoginController({required UserService userService})
      : _userService = userService;

  bool get hasInfo => infoMessage != null;

  //criar metodo de login com o google

  Future<void> googleLogin() async {
    try {
  showLoadingAndResetState();
  infoMessage = null;
  notifyListeners();
  
  final user = await _userService.googleLogin();
  if (user != null) {
    success();
  }
} on AuthException catch (e) {
  setError(e.message);
  //e.message da mensagem que sera recebida
}finally{
  hideLoading();
  notifyListeners();
}
  }

  Future<void> login(String email, String password) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      final user = await _userService.login(email, password);

      if (user != null) {
        success();
      } else {
        _userService.logout();
        setError('usuario ou senha inválidos');
      }
    } on AuthException catch (e) {
      _userService.logout();
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<User?> forgotPassword(String email) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      await _userService.forgotPassword(email);
      infoMessage = 'Reset de senha enviado para o seu email';
    } on AuthException catch (e) {
      setError(e.message);
    } catch (e) {
      setError('Erro ao resetar senha');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
