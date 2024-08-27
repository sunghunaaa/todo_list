import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/controllers/todos_controllers.dart';
import 'package:todo_list/data/color_source.dart';

Obx todoCard({required int type}) {
  final TodosController todosController = Get.find();

  return Obx(() {
    //type으로 item filter
    final filteredTodos =
        todosController.todos.where((todo) => todo['type'] == type).toList();

    return ListView.builder(
      itemCount: filteredTodos.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: const Color(mainColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    filteredTodos[index]['title'],
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_forever, color: Color(blackColor)),
                  onPressed: () => todosController.removeTodo(filteredTodos[index]['index']),
                ),
              ],
            ),
          ),
        );
      },
    );
  });
}
