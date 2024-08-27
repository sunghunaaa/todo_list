import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/data/color_source.dart';
import 'package:todo_list/views/todo_list/widgets/todo_list_get.dart';
import 'package:todo_list/views/todo_list/widgets/todos_input_textfield.dart';

import '../../controllers/todos_controllers.dart';

class TodoList extends StatelessWidget {
  TodoList({super.key});

  final TodosController todosController = Get.put(TodosController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(whiteColor),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 400,
            decoration: const BoxDecoration(
              color: Color(bgColor),
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
            ),
            margin: const EdgeInsets.only(top: 20.0),
            padding: const EdgeInsets.only(left: 20.0,right: 20.0,top:10.0,bottom: 40.0),
            child: todosInputTextField(),
          ),
          Expanded(
            child: Row(
              children: [
                TodoListGet(
                  type: 0,
                ),
                TodoListGet(
                  type: 1,
                ),
                TodoListGet(
                  type: 2,
                ),
                TodoListGet(
                  type: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
