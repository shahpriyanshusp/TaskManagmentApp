import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/TaskController/TaskController.dart';
import 'AddTaskScreen.dart';

class TaskListScreen extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

   TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List with Priority'),
      ),
      body: Column(
        children: <Widget>[
          TaskListView(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const AddTaskForm());
        },
        backgroundColor: Colors.deepPurple,
        child: const Center(child: Icon(Icons.add,color: Colors.white,),),
      ),
    );
  }
}



class TaskListView extends StatelessWidget {
  final TaskController taskController = Get.find();

  TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() =>taskController.tasks.isEmpty? ListView.builder(
        itemCount: taskController.tasks.length,
        itemBuilder: (context, index) {
          final task = taskController.tasks[index];
          return ListTile(
            title: Text(task.name),
            subtitle: Text('Priority: ${task.priority}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
             task.prioritylevel!=3?   GestureDetector(
                    onTap: (){
                      task.prioritylevel=3;
                      task.isCompleted=true;
                      taskController.toggleTaskCompletion(task);
                    },
                    child: const Icon(Icons.task)):
             const Icon(Icons.task,color: Colors.green,),
                const SizedBox(width: 5,),
                GestureDetector(
                    onTap: (){
                      taskController.removeTask(task);
                    },
                    child: const Icon(Icons.delete))
              ],
            ),
          );
        },
      ):const Center(child: Text('No Data Found'),)),
    );
  }
}