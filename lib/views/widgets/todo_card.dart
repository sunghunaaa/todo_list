import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/todos_controllers.dart';

Obx todoCard({required int type}) {
  final TodosController todosController = Get.find();

  return Obx(() {
    //type으로 item filter
    final filteredTodos = todosController.todos.where((todo) => todo['type'] == type).toList();

    return ListView.builder(

      itemCount: filteredTodos.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            leading: IconButton(
              icon: Obx(() {
                return Icon(
                  Icons.check_circle,
                  color: filteredTodos[index]['type'] == type
                      ? Colors.green
                      : Colors.grey,
                );
              }),
              onPressed: () => todosController.changeStatusTodo(index),
            ),
            title: Text(filteredTodos[index]['title']),
            trailing: IconButton(
              icon: Icon(Icons.delete_forever, color: Colors.red),
              onPressed: () => todosController.removeTodo(index),
            ),
          ),
        );
      },
    );
  });
}
