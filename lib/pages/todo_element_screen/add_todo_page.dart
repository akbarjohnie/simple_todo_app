import 'package:base_app_july/models/todo_models.dart';
import 'package:base_app_july/pages/todo_list_screen/todo_list_page.dart';
import 'package:flutter/material.dart';

class AddToDo extends StatefulWidget {
  final int index;
  final DateTime? date;

  const AddToDo({super.key, required this.index, this.date});

  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var date = widget.date;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        // Отменить добавление (нажали крестик)
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            // Добавляем новую заметку
            onPressed: () {
              setState(() {
                todos.add(
                  ToDoModel(
                    text: _textController.text,
                    deadLine: date,
                    done: (date != null),
                  ),
                );
              });
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ToDoListPage(),
                  ),
                  (route) => false);
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
            padding: const EdgeInsets.only(
              left: 18,
              top: 8,
              right: 18,
              bottom: 4,
            ),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              maxLines: 100,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
              decoration: const InputDecoration(
                hintText: 'Здесь будут мои заметки',
                border: InputBorder.none,
              ),
              controller: _textController,
              strutStyle: const StrutStyle(height: 1.3),
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
                TextButton(
                  onPressed: () async {
                    final choseDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(
                        const Duration(days: 30),
                      ),
                    );

                    todos[widget.index] = todos[widget.index].copyWith(
                      _textController.text,
                      choseDate,
                      true,
                    );
                    date = todos[widget.index].deadLine;
                  },
                  child: Text(
                    'Дедлайн',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
                Checkbox(
                  activeColor: const Color(0xFF45B443),
                  value: (date != null),
                  onChanged: (value) {
                    if (date != null) {}
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
