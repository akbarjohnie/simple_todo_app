import 'package:base_app_july/models/todo_models.dart';
import 'package:base_app_july/pages/todo_list_screen/todo_list_page.dart';
import 'package:base_app_july/pages/widgets/todo_field_widget.dart';
import 'package:flutter/material.dart';

class AddToDo extends StatefulWidget {
  final int index;

  const AddToDo({
    super.key,
    required this.index,
  });

  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  final TextEditingController _textController = TextEditingController();

  DateTime? date;

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
          TextButton(
            // Добавляем новую заметку "Сохранить"
            onPressed: () {
              if (_textController.text != '' &&
                  _textController.text.split(' ').join() != '') {
                setState(() {
                  todos.add(
                    ToDoModel(
                      text: _textController.text,
                      deadLine: date,
                    ),
                  );
                  debugPrint("$date");
                  debugPrint('${DeadLineWidget()}');
                });
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ToDoListPage(),
                  ),
                  (route) => false,
                );
              }
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
          ToDoFieldWidget(
            themeData: themeData,
            textController: _textController,
          ),
          const DeadLineWidget(),
        ],
      ),
    );
  }
}

class DeadLineWidget extends StatefulWidget {
  final DateTime? date;

  const DeadLineWidget({
    super.key,
    this.date,
  });

  @override
  State<DeadLineWidget> createState() => _DeadLineWidgetState();
}

class _DeadLineWidgetState extends State<DeadLineWidget> {
  DateTime? date;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Padding(
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
                    date = chosenDate;
                  });
                },
                child: Text(
                  'Дедлайн',
                  style: themeData.textTheme.bodyLarge?.copyWith(
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Checkbox(
                activeColor: const Color(0xFF45B443),
                value: (date != null),
                onChanged: (_) {},
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Visibility(
              // Отображаем/не отображаем дедлайн
              // в зависимости от содержимого 'date'
              visible: (date != null),
              child: Text(
                'Дата: ${date?.day}.${date?.month}.${date?.year}',
                style: themeData.textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFF000000),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
