class Task {
  int? id;
  String name;
  String priority;
  int? prioritylevel;
  bool isCompleted;

  Task({this.id, required this.name, required this.priority, this.isCompleted = false,this.prioritylevel});


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'priority': priority,
      'prioritylevel': prioritylevel,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      name: map['name'],
      priority: map['priority'],
      prioritylevel: map['prioritylevel'],
      isCompleted: map['isCompleted'] == 1,
    );
  }

}