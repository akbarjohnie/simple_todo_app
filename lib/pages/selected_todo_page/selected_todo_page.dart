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
        // Отменить добавление (нажали крестик)
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          // Сохраняем изменения в списке дел
          TextButton(
            onPressed: () {
              setState(() {
                todos[widget.index] = todos[widget.index].copyWith(
                  _textController.text,
                  widget.deadLine,
                  widget.check,
                );
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ToDoListPage(),
                    ),
                    (route) => false);
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
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              controller: _textController,
              maxLines: 100,
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
                  onPressed: () {},
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.all(0),
                    ),
                  ),
                  child: Text(
                    'Дедлайн',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
                Checkbox(
                  value: widget.check,
                  onChanged: (value) {
                    final check = value ?? false;
                    setState(
                      () {
                        todos[widget.index] = todos[widget.index].copyWith(
                          widget.text,
                          widget.deadLine,
                          check,
                        );
                      },
                    );
                  },
                  activeColor: const Color(0xFF45B443),
                )
              ],
            ),
          ),
          const Divider(
            indent: 16,
            endIndent: 16,
            height: 1,
            color: Color(0xFFD9D9D9),
          ),
          MaterialButton(
            // Кнопка удаления заметки
            onPressed: () {
              setState(
                () {
                  todos.removeAt(widget.index);
                },
              );
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const ToDoListPage(),
                ),
                (route) => false,
              );
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
