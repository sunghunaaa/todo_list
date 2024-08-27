import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/controllers/todos_controllers.dart';
import 'package:todo_list/data/color_source.dart';

Obx todoCard({required int type}) {
  final TodosController todosController = Get.find();

  return Obx(() {
    // type으로 item filter
    final filteredTodos =
    todosController.todos.where((todo) => todo['type'] == type).toList();

    return ListView.builder(
      itemCount: filteredTodos.length,
      itemBuilder: (BuildContext context, int index) {
        return Draggable<RxMap<String, dynamic>>(
          data: filteredTodos[index],
          child: Card(
            color: const Color(0xFF42A5F5),
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
                    icon: const Icon(Icons.delete_forever, color: Color(0xFF000000)),
                    onPressed: () => todosController.removeTodo(filteredTodos[index]['index']),
                  ),
                ],
              ),
            ),
          ),
          feedback: Material(
            child: Card(
              color: const Color(0xFF42A5F5),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  filteredTodos[index]['title'],
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            elevation: 5.0,
          ),
          childWhenDragging: Container(), // 드래그 중인 카드 자리에 빈 공간을 표시
        );
      },
    );
  });
}
