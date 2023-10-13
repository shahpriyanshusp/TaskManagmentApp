import 'package:get/get.dart';

import '../../Model/Task/TaskModel.dart';
import '../../Service/DatabaseHelper.dart';

class TaskController extends GetxController {
  final RxList<Task> tasks = <Task>[].obs;
  final RxString selectedPriority = 'High'.obs;
  final RxInt selectedPrioritylevel = 0.obs;

  final _database= DatabaseHelper.instance;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    final tasksMapList = await _database.retrieveTasks();
    tasks.assignAll(tasksMapList.map((taskMap) => Task.fromMap(taskMap)));
    sortTasksByPriority();
  }

  Future<void> addTask(Task task) async {
    final id = await _database.insertTask(task.toMap());
    task.id = id;
    tasks.add(task);
    sortTasksByPriority();
  }

  void toggleTaskCompletion(Task task) {
    _updateTask(task);
    sortTasksByPriority();
  }

  Future<void> _updateTask(Task task) async {
    await _database.updateTask(task.toMap());
  }

  Future<void> removeTask(Task task) async {
    await _database.deleteTask(task.id ?? 0);
    tasks.remove(task);
    sortTasksByPriority();
  }

  void sortTasksByPriority() {
    tasks.sort((a, b) => a.prioritylevel!.compareTo(b.prioritylevel!));
  }
}

