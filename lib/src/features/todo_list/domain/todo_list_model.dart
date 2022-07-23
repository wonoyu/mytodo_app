class ReqRes {
  ReqRes({required this.status, required this.message, required this.data});

  final String status;
  final String message;
  final DataRes data;

  factory ReqRes.fromJson(Map<String, dynamic> json) {
    return ReqRes(
      status: json['status'] as String,
      message: json['message'] ?? "",
      data: DataRes.fromJson(json['data']),
    );
  }
}

class DataRes {
  DataRes({required this.todo});

  final List<Todo> todo;

  factory DataRes.fromJson(Map<String, dynamic> json) => DataRes(
        todo: List<Todo>.from(json["todo"].map((data) => Todo.fromJson(data))),
      );
}

class Todo {
  Todo(
      {required this.id,
      required this.status,
      required this.todoText,
      required this.belongTo});

  final int id;
  final String status;
  final String todoText;
  final String belongTo;

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as int,
      status: json['status'] as String,
      todoText: json['todo_text'] as String,
      belongTo: json['belong_to'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'todo_text': todoText,
      'belong_to': belongTo,
    };
  }
}
