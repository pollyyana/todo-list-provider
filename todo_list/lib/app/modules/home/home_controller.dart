
import 'package:todo_list/app/core/notifier/defaul_change_notifier.dart';
import 'package:todo_list/app/models/task_filter_enum.dart';

class HomeController extends DefaulChangeNotifier {

  var filterSelected =  TaskFilterEnum.today;
  
}