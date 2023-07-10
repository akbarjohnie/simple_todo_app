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

  DateTime? _date;

  @override
  void initState() {
    super.initState();
    _textController.text = widget.text;
    _date = widget.deadLine;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: themeData.colorScheme.background,
        // Отменить добавление (нажали крестик)
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
        actions: [
          // Сохраняем изменения в списке дел
          TextButton(
            onPressed: () {
              setState(() {
                todos[widget.index] = todos[widget.index].copyWith(
                  _textController.text,
                  _date,
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
              color: themeData.colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              style: themeData.textTheme.bodyMedium,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () async {
                        final chosenDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 30),
                          ),
                        );
                        setState(() {
                          _date = chosenDate;
                        });
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.all(0),
                        ),
                      ),
                      child: Text(
                        'Дедлайн',
                        style: themeData.textTheme.bodyLarge?.copyWith(
                          color: const Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Checkbox(
                      value: (_date != null),
                      onChanged: (_) {
                        // final check = value ?? false;
                        // setState(
                        //   () {
                        //     todos[widget.index] = todos[widget.index].copyWith(
                        //       widget.text,
                        //       _date,
                        //       check,
                        //     );
                        //   },
                        // );
                      },
                      activeColor: const Color(0xFF45B443),
                    )
                  ],
                ),
                Visibility(
                  visible: (_date != null),
                  child: Text(
                    'Дата: ${_date?.day}.${_date?.month}.${_date?.year}',
                    style: themeData.textTheme.bodyLarge?.copyWith(
                      color: const Color(0xFF000000),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
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
                  color: Color(0xFFF44336),
                ),
                const SizedBox(
                  width: 7,
                ),
                Text(
                  'Удалить',
                  style: themeData.textTheme.bodyLarge,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
