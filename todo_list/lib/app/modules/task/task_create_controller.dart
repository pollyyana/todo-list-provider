import 'package:todo_list/app/core/notifier/defaul_change_notifier.dart';
import 'package:todo_list/app/services/tasks/tasks_service.dart';

//estrutura basica da tela
class TaskCreateController extends DefaulChangeNotifier {
  final TasksService _tasksService;
  DateTime? _selectedDate;

  //encapsular
  TaskCreateController({required TasksService tasksService})
      : _tasksService = tasksService;

  set selectedDate(DateTime? selectedDate) {
    resetState();
    _selectedDate = selectedDate;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;

  Future<void> save(String description) async {
    try {
      showLoadingAndResetState();
      notifyListeners();

      if (_selectedDate != null) {
        await _tasksService.save(_selectedDate!, description);
        success();
      } else {
        setError('Data da task nao selecionada');
      }
    } catch (e, s) {
      print(e);
      print(s);
      setError('Erro ao cadastrar task');
    }finally{
      hideLoading();
      notifyListeners();
    }
  }
}
