import 'package:base_app_july/models/todo_models.dart';
import 'package:base_app_july/pages/selected_todo_page/selected_todo_page.dart';
import 'package:base_app_july/pages/todo_element_screen/add_todo_page.dart';
import 'package:flutter/material.dart';

final List<ToDoModel> todos = [];

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({super.key});

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: themeData.colorScheme.background,
        title: Text(
          'Мои дела',
          style: themeData.textTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: const ToDoListWidget(),
      floatingActionButton: const _AddNoteButton(),
    );
  }
}

class ToDoListWidget extends StatefulWidget {
  const ToDoListWidget({super.key});

  @override
  State<ToDoListWidget> createState() => _ToDoListWidgetState();
}

class _ToDoListWidgetState extends State<ToDoListWidget> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SafeArea(
      top: false,
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 5.0,
        ),
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            background: markAsDoneGesture(themeData),
            secondaryBackground: deleteGesture(themeData),
            onDismissed: (DismissDirection direction) {
              deleteNoteFunc(direction, index);

              markAsDoneFunc(direction, index);
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: _borderRadius(index),
                color: themeData.colorScheme.surface,
              ),
              child: ToDoElementWidget(index: index),
            ),
          );
        },
      ),
    );
  }

  BorderRadius _borderRadius(int index) {
    const radius = Radius.circular(20);

    if (index == 0) {
      return const BorderRadius.only(
        topLeft: radius,
        topRight: radius,
      );
    }

    if (index == todos.length - 1) {
      return const BorderRadius.only(
        bottomLeft: radius,
        bottomRight: radius,
      );
    }

    return const BorderRadius.all(Radius.zero);
  }

  void markAsDoneFunc(DismissDirection direction, int index) {
    if (direction == DismissDirection.startToEnd) {
      setState(() {
        todos[index] = todos[index].copyWith(
          todos[index].text,
          todos[index].deadLine,
          true,
        );
      });
    }
  }

  void deleteNoteFunc(DismissDirection direction, int index) {
    if (direction == DismissDirection.endToStart) {
      setState(() {
        todos.removeAt(index);
      });
    }
  }

  Container deleteGesture(ThemeData themeData) {
    return Container(
      alignment: Alignment.centerRight,
      color: themeData.colorScheme.error,
      child: Container(
        padding: const EdgeInsets.only(right: 20),
        child: Icon(
          Icons.delete_outline,
          color: themeData.colorScheme.surface,
        ),
      ),
    );
  }

  Container markAsDoneGesture(ThemeData themeData) {
    return Container(
      alignment: Alignment.centerLeft,
      color: themeData.colorScheme.secondary,
      child: Container(
        padding: const EdgeInsets.only(left: 20),
        child: Icon(
          Icons.done,
          color: themeData.colorScheme.surface,
        ),
      ),
    );
  }
}

class ToDoElementWidget extends StatefulWidget {
  final int index;

  const ToDoElementWidget({
    super.key,
    required this.index,
  });

  @override
  State<ToDoElementWidget> createState() => _ToDoElementWidgetState();
}

class _ToDoElementWidgetState extends State<ToDoElementWidget> {
  DateTime? date;
  //сделать корректное отображение даты, пока что можно без форматирования даты
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return ListTile(
      titleTextStyle: themeData.textTheme.bodyLarge?.copyWith(
        color: const Color(0xFF000000),
        fontWeight: FontWeight.w400,
      ),
      leading: Checkbox(
        value: todos[widget.index].done,
        onChanged: (value) {
          final cheched = value ?? false;
          setState(
            () {
              todos[widget.index] = todos[widget.index].copyWith(
                todos[widget.index].text,
                todos[widget.index].deadLine,
                cheched,
              );
            },
          );
        },
        activeColor: const Color(0xFF45B443),
      ),
      title:
          // Добавил зачёркивание заметки,
          // если у неё в модельке done = true
          Text(
        todos[widget.index].text,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: themeData.textTheme.bodyLarge?.copyWith(
          decoration: todos[widget.index].done
              ? TextDecoration.lineThrough
              : TextDecoration.none,
          color: const Color(0xFF000000),
          fontWeight: FontWeight.w400,
        ),
      ),

      subtitle: todos[widget.index].deadLine == null
          ? null
          : Text('${todos[widget.index].deadLine}'),
      // Visibility(
      //   // Хотел сделать вкл/выкл отображение
      //   // дедлайна в зависимости от того пустой он
      //   // или же нет.
      //   // Оно работает не так как я хотел
      //   visible: (todos[widget.index].deadLine != null),
      //   replacement: const SizedBox.shrink(),
      //   child: (todos[widget.index].deadLine == null)
      //       ? Container()
      //       : Text('${todos[widget.index].deadLine}'),
      // ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SelectedToDo(
              index: widget.index,
              text: todos[widget.index].text,
              deadLine: todos[widget.index].deadLine,
              check: todos[widget.index].done,
            ),
          ),
        );
      },
    );
  }
}

class _AddNoteButton extends StatelessWidget {
  const _AddNoteButton();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color(0xFFFF9900),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddToDo(
              index: todos.length,
            ),
          ),
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: const Icon(
        Icons.add,
        color: Color(0xFFFFFFFF),
      ),
    );
  }
}
