import 'package:flutter/material.dart';

class ToDoFieldWidget extends StatelessWidget {
  const ToDoFieldWidget({
    super.key,
    required this.themeData,
    required TextEditingController textController,
  }) : _textController = textController;

  final ThemeData themeData;
  final TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        maxLines: 100,
        style: themeData.textTheme.bodyMedium!.copyWith(),
        decoration: const InputDecoration(
          hintText: 'Здесь будут мои заметки',
          border: InputBorder.none,
        ),
        controller: _textController,
        strutStyle: const StrutStyle(height: 1.3),
      ),
    );
  }
}
