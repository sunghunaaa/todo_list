import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/controllers/todos_controllers.dart';

class TodoDetail extends StatelessWidget {
  final TodosController todosController = Get.find();
  final int index;

  TodoDetail({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Obx((){
      Map<String, dynamic> todo = todosController.todos.firstWhere((t) => t['index'] == index);


      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('제목 : ${todo['title']}'),
          Text('담당자 : ${todo['manager']}'),
          Text('내용 : ${todo['content']}'),
          Text('날짜 : ${todo['date']}'),
        ],
      );
    });
  }
}