import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/controllers/todos_controllers.dart';
import 'package:todo_list/data/color_source.dart';

Widget todoCard({required int type}) {
  final TodosController todosController = Get.find();

  return Obx(() {
    // type으로 item filter 후 order로 정렬
    final filteredTodos = todosController.todos
        .where((todo) => todo['type'] == type)
        .toList()
      ..sort((a, b) => a['order'].compareTo(b['order']));

    return ReorderableListView(
      onReorder: (int oldIndex, int newIndex) {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        final movedTodo = filteredTodos.removeAt(oldIndex);
        filteredTodos.insert(newIndex, movedTodo);

        // 새로운 순서에 맞게 order 값을 업데이트
        for (int i = 0; i < filteredTodos.length; i++) {
          filteredTodos[i]['order'] = i;
        }

        // 새로운 순서를 컨트롤러에 반영
        todosController.updateTodosOrder(type, filteredTodos);
      },
      children: List.generate(
        filteredTodos.length,
            (index) {
          return Draggable<RxMap<String, dynamic>>(
            key: ValueKey(filteredTodos[index]['index']),
            data: filteredTodos[index],
            feedback: Material(
              elevation: 5.0,
              child: Card(
                color: const Color(btnColor),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  child: Text(
                    filteredTodos[index]['title'],
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(blackColor), // 텍스트 색상 변경
                      fontWeight: FontWeight.bold, // 텍스트 굵게 설정
                      fontSize: 18, // 텍스트 크기 설정
                    ),
                  ),
                ),
              ),
            ),
            childWhenDragging: Opacity(
              opacity: 0.5,
              child: Card(
                color: const Color(btnColor),
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
            ),
            child: Card(
              color: const Color(btnColor),
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
          );
        },
      ),
    );
  });
}