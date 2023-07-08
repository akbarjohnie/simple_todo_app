import 'package:base_app_july/models/todo_models.dart';
import 'package:base_app_july/pages/todo_list_screen/todo_list_page.dart';
import 'package:flutter/material.dart';

class SelectedToDo extends StatefulWidget {
  final int index;
  final String text;
  final DateTime? deadLine;
  final bool? check;

  const SelectedToDo({
    super.key,
    required this.index,
    required this.text,
    this.deadLine,
    this.check,
  });

  @override
  State<SelectedToDo> createState() => _SelectedToDoState();
}

class _SelectedToDoState extends State<SelectedToDo> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                todos.add(ToDoModel(text: _textController.text));
                Navigator.of(context).pop();
              });
            },
            child: const Text(
              'Сохранить',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 189,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              controller: _textController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Дедлайн',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.black),
                ),
                Checkbox(
                  value: widget.check ?? false,
                  onChanged: (value) {
                    final check = value ?? false;
                    setState(() {
                      todos[widget.index] = todos[widget.index].copyWith(
                        widget.text,
                        widget.deadLine,
                        check,
                      );
                    });
                  },
                )
              ],
            ),
          ),
          MaterialButton(
            onPressed: () {
              setState(() {
                Navigator.of(context).pop(todos.removeAt(widget.index));
              });
            },
            child: Row(
              children: [
                const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
                const SizedBox(
                  width: 7,
                ),
                Text(
                  'Удалить',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
