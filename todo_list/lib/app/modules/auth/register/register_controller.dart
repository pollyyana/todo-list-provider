import 'package:todo_list/app/core/notifier/defaul_change_notifier.dart';
import 'package:todo_list/app/exceptions/auth_exception.dart';
import 'package:todo_list/app/services/user/user_service.dart';

class RegisterController extends DefaulChangeNotifier {
  final UserService _userService;
  // String? error;
  // bool sucess = false;

  RegisterController({required UserService userService})
      : _userService = userService;
  Future<void> RegisterUser(String email, String password) async {
    try {
      // error = null;
      // sucess = false;
      showLoadingAndResetState();
      notifyListeners();
      final user = await _userService.register(email, password);
      if (user != null) {
        //sucess
        // sucess = true;
        success();
      } else {
        //erro
        // error = 'Erro ao registrar usuario';
        setError('Erro ao registrar usuario');
      }
    } on AuthException catch (e) {
      // error = e.message;
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
