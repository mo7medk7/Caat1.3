class Task {
  static const String collectionName = 'tasks';

  String? id;
  String? title;
  String? description;
  DateTime? dateTime;
  bool? isDone;
  String? employeeEmail;

  Task(
      {this.id = '',
      required this.dateTime,
      required this.title,
      required this.description,
      this.isDone = false,required this.employeeEmail,

      });

  //map => object
  Task.fromFireStore(Map<String, dynamic> data)
      : this(
            id: data['id'] as String?,
            title: data['title'] as String?,
            description: data['description'] as String?,
            employeeEmail: data['employeeEmail'] as String?,
            dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
            isDone: data['isDone']);

  // object => map (jason)
  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'employeeEmail': employeeEmail,
      'dateTime': dateTime?.millisecondsSinceEpoch,
      'isDone': isDone
    };
  }
}
