class ToDoModel {
  final String text;
  final DateTime? deadLine;
  final bool done;

  ToDoModel({
    required this.text,
    this.deadLine,
    this.done = false,
  });

  ToDoModel copyWith(
    String? text,
    DateTime? deadLine,
    bool? done,
  ) {
    return ToDoModel(
      text: text ?? this.text,
      deadLine: deadLine ?? this.deadLine,
      done: done ?? this.done,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToDoModel &&
          runtimeType == other.runtimeType &&
          text == other.text &&
          deadLine == other.deadLine &&
          done == other.done;

  @override
  int get hashCode => text.hashCode ^ deadLine.hashCode ^ done.hashCode;
}
