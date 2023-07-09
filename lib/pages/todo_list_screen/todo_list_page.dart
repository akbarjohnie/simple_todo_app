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
                key: UniqueKey(),
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
                  if (direction == DismissDirection.startToEnd) {
                    setState(() {
                      todos[index] = todos[index].copyWith(
                        todos[index].text,
                        todos[index].deadLine,
                        true,
                      );
                    });
                  }
                },
                child: SizedBox(
                  height: 43,
                  child: ListTile(
                    titleTextStyle: themeData.textTheme.bodyLarge!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    leading: Checkbox(
                      value: todos[index].done,
                      onChanged: (value) {
                        final cheched = value ?? false;
                        setState(
                          () {
                            todos[index] = todos[index].copyWith(
                              todos[index].text,
                              todos[index].deadLine,
                              cheched,
                            );
                          },
                        );
                      },
                      activeColor: const Color(0xFF45B443),
                    ),
                    title: Text(
                      todos[index].text,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    // subtitle: Visibility(
                    //   // Хотел сделать вкл/выкл отображение
                    //   // дедлайна в зависимости от того пустой он
                    //   // или же нет.
                    //   // Оно работает не так как я хотел
                    //   visible: (todos[index].deadLine != null),
                    //   replacement: const SizedBox.shrink(),
                    //   child: (todos[index].deadLine == null)
                    //       ? Container()
                    //       : Text('${todos[index].deadLine}'),
                    // ),
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
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: const AddNoteButton(),
    );
  }
}

class AddNoteButton extends StatelessWidget {
  const AddNoteButton({
    super.key,
  });

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
