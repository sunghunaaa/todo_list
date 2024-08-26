import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodosController extends GetxController {
  // ~ state list all todo
  RxList<RxMap<String, dynamic>> todos = <RxMap<String, dynamic>>[
    {
      'title': '견적서 양식 등록',
      'manager': '김발자',
      'content': '본사에 필요한 견적서 양식을 작성하여 제출한다.',
      'date': '2024-08-30',
      'type': 0
    }.obs,{
      'title': '급한 일정 입니다.',
      'manager': '김발자',
      'content': '본사에 필요한 견적서 양식을 작성하여 제출한다.',
      'date': '2024-08-30',
      'type': 1
    }.obs,
  ].obs;

  // ~ controller text field for input todo
  TextEditingController todoInputController = TextEditingController();
  FocusNode todoInputFocusNode = FocusNode();

  // ! method to add todo
  void addTodo() {
    todos.add({'todo': todoInputController.text, 'done': false}.obs);
    todoInputController.clear();
    todoInputFocusNode.requestFocus();
  }

  // ! method to remove todo
  void removeTodo(int index) => todos.removeAt(index);

  // ! method to change status todo
  void changeStatusTodo(int index) {
    todos[index]['done'] = !todos[index]['done'];
  }
}
