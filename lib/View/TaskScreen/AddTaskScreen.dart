import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/TaskController/TaskController.dart';
import '../../Model/Task/TaskModel.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({super.key});

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final TaskController taskController = Get.find();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController priorityController = TextEditingController();

  @override
  void initState(){
    taskController.selectedPrioritylevel.value=0;
    taskController.selectedPriority.value='High';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List with Priority'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Task Name'),
            ),
           const SizedBox(height: 20),
           const Text('Priority:'),
           Obx(() => taskController.selectedPrioritylevel.value !=3?  const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                PriorityButton(priority: 'High',prioritylevel: 0),
                PriorityButton(priority: 'Medium',prioritylevel: 1),
                PriorityButton(priority: 'Low',prioritylevel: 2),
              ],
            ): Container()),
          const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final selectedPriority = taskController.selectedPriority.value;
                if (nameController.text.isNotEmpty && selectedPriority.isNotEmpty) {
                  final task = Task(name: nameController.text, priority: selectedPriority , prioritylevel:  taskController.selectedPrioritylevel.value);
                  taskController.addTask(task);
                  Get.back();
                } else {
                  Get.snackbar(
                    'Error',
                    'Please enter a task name and select a priority.',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              child: const Text('Add Task'),
            ),
          ],
        ),

      ),
    );
  }
}

class PriorityButton extends StatefulWidget {
  final String priority;
  final int prioritylevel;

  const PriorityButton({super.key, required this.priority ,required this.prioritylevel});

  @override
  State<PriorityButton> createState() => _PriorityButtonState();
}

class _PriorityButtonState extends State<PriorityButton> {
  final TaskController taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    bool isSelected = taskController.selectedPriority.value == widget.priority;
    return  ElevatedButton(
      onPressed: () {
        taskController.selectedPriority.value = widget.priority;
        taskController.selectedPrioritylevel.value = widget.prioritylevel;
        setState(() { });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : null,
      ),
      child: Text(widget.priority),
    );
  }
}