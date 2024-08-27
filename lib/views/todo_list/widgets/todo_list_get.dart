import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/controllers/todos_controllers.dart';
import 'package:todo_list/data/color_source.dart';
import 'package:todo_list/data/data_source.dart';
import 'package:todo_list/views/todo_list/widgets/todo_card.dart';

class TodoListGet extends StatelessWidget {
  TodoListGet({super.key, required this.type});

  final TodosController todosController = Get.put(TodosController());
  final int type;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DragTarget<RxMap<String, dynamic>>(
        onAcceptWithDetails: (details) {
          final receivedTodo = details.data;
          todosController.moveTodoToDifferentList(receivedTodo, type);
        },
        builder: (context, candidateData, rejectedData) {
          return Container(
            decoration: const BoxDecoration(
              color: Color(0xFFEFEFEF),
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
            ),
            margin: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0),
            padding: const EdgeInsets.only(
                left: 20.0, right: 20.0, top: 20.0, bottom: 40.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(state[type]),
                Expanded(
                  child: todoCard(type: type),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
