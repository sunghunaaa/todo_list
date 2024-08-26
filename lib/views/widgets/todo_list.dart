import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/views/widgets/todo_card.dart';
import 'package:todo_list/views/widgets/todos_add_iconbutton.dart';
import 'package:todo_list/views/widgets/todos_input_textfield.dart';

import '../../controllers/todos_controllers.dart';

class TodoList extends StatelessWidget {
  TodoList({super.key, required this.type});

  final int type;

  final TodosController todosController = Get.put(TodosController());

  @override
  Widget build(BuildContext context) {
    return Expanded(  // Expanded를 Column 전체를 감싸도록 추가
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text('dsa'),
          Expanded(
            child: todoCard(type: type),
          ),
        ],
      ),
    );
  }
}
