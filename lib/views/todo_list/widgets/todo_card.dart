import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:todo_list/controllers/todos_controllers.dart';
import 'package:todo_list/data/color_source.dart';
import 'package:todo_list/views/todo_detail/todo_detail.dart';

Widget todoCard({required int type}) {
  final TodosController todosController = Get.find();

  void showTodoDetailDialog(RxMap<String, dynamic>? todo) {
    // 데이터가 null일 경우 다이얼로그를 닫음
    if (todo == null) {
      Get.back();
      return;
    }

    // 다이얼로그 띄우기
    Get.defaultDialog(
      title: todo['title'] ?? 'No Title',
      content: TodoDetail(
        index: todo['index'],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("확인"),
        ),
        TextButton(
          onPressed: () async {
            await todosController.removeTodo(todo['index']);
            todosController.refreshTodo();
          },
          child: const Text("삭제"),
        ),
      ],
    );
  }

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
            feedback: Card(
              color: const Color(btnColor),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Text(
                  filteredTodos[index]['title'],
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(blackColor),
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            childWhenDragging: Opacity(
              opacity: 0.5,
              child: Card(
                color: const Color(btnColor),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 10.0,
                        child: Text(
                          filteredTodos[index]['index'].toString(),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          filteredTodos[index]['title'],
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                        width: 10.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            child: Card(
              color: const Color(btnColor),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 10.0,
                      child: Text(
                        filteredTodos[index]['index'].toString(),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        filteredTodos[index]['title'],
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    IconButton(
                      icon: const Icon(Icons.info_outline, color: Colors.black),
                      onPressed: () {
                        Get.defaultDialog(
                          title: filteredTodos[index]['title'],
                          content: TodoDetail(
                            index: filteredTodos[index]['index'],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text("확인"),
                            ),
                            TextButton(
                              onPressed: () async {
                                await todosController.back();
                                Future.delayed(
                                  const Duration(milliseconds: 1000),
                                  () {
                                    todosController.removeTodo(
                                      filteredTodos[index]['index'],
                                    );
                                    todosController.refreshTodo();
                                  },
                                );
                              },
                              child: const Text("삭제"),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                      height: 30.0,
                      width: 10.0,
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
