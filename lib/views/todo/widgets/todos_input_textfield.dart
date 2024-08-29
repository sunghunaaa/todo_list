import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/controllers/todos_controllers.dart';
import 'package:todo_list/data/color_source.dart';

Column todosInputTextField() {
  final TodosController todosController = Get.find();

  return Column(
    children: [
      TextField(
        controller: todosController.titleController,
        decoration: const InputDecoration(
          labelText: '제목',
          counterText: '',
        ),
        maxLength: 20,
      ),
      TextField(
        controller: todosController.managerController,
        decoration: const InputDecoration(
          labelText: '담당자',
          counterText: '',
        ),
        maxLength: 10,
      ),
      TextField(
        controller: todosController.contentController,
        decoration: const InputDecoration(
          labelText: '내용',
          counterText: '',
        ),
        maxLength: 65,
      ),
      TextField(
        controller: todosController.dateController,
        decoration: const InputDecoration(
          labelText: '날짜',
          counterText: '',
        ),
        maxLength: 15,
      ),
      const SizedBox(
        height: 20,
      ), // 여유 공간 추가
      ElevatedButton(
        onPressed: () {
          //인스턴스 꼬이는 거 임시 방지
          if (Get.isRegistered<TodosController>()) {
            todosController.addTodo(
              title: todosController.titleController.text,
              manager: todosController.managerController.text,
              content: todosController.contentController.text,
              date: todosController.dateController.text,
            );
          } else {
            // 에러 처리 또는 컨트롤러 재등록 로직 추가 가능
            print('컨트롤러가 해제되었습니다.');
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color(
              mainColor,
            ),
          ),
        ),
        child: const Text(
          '제출',
          style: TextStyle(
            color: Color(
              blackColor,
            ),
          ),
        ),
      ),
    ],
  );
}
