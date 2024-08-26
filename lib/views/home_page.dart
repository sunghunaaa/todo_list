import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/views/widgets/todos_add_iconbutton.dart';
import 'package:todo_list/views/widgets/todos_input_textfield.dart';
import 'package:todo_list/views/widgets/todo_list.dart';

import '../controllers/todos_controllers.dart';

class HomePage extends StatelessWidget {
  final TodosController todosController = Get.put(TodosController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          TodoList(type: 0,),
          TodoList(type: 1,),
          TodoList(type: 2,),
          TodoList(type: 3,),
        ],
      ),
    );
  }
}
