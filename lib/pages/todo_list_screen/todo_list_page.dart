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
  late final int todosIndex;

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
      body: SafeArea(
        top: false,
        child: Container(
          margin: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: themeData.colorScheme.surface,
          ),
          child: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: ValueKey<int>(int.parse(todos[index].toString())),
                secondaryBackground: Container(
                  color: Colors.red,
                  child: const Icon(
                    Icons.delete_outline,
                  ),
                ),
                background: Container(
                  color: Colors.green,
                  child: const Icon(
                    Icons.done,
                  ),
                ),
                onDismissed: (DismissDirection direction) {
                  if (direction == DismissDirection.endToStart) {
                    setState(() {
                      todos.removeAt(index);
                    });
                  }
                },
                child: ListTile(
                  titleTextStyle: themeData.textTheme.labelLarge!.copyWith(
                    color: Colors.black,
                  ),
                  leading: Checkbox(
                    value: todos[index].done,
                    onChanged: (value) {
                      final cheched = value ?? false;
                      setState(() {
                        todos[index] = todos[index].copyWith(
                          todos[index].text,
                          todos[index].deadLine,
                          cheched,
                        );
                      });
                    },
                  ),
                  title: Text(todos[index].text),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectedToDo(
                          index: index,
                          text: todos[index].text,
                          deadLine: todos[index].deadLine,
                          check: todos[index].done,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: const AddNoteWidget(),
    );
  }
}

class AddNoteWidget extends StatelessWidget {
  const AddNoteWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
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
      child: const Icon(Icons.add),
    );
  }
}
