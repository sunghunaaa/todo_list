import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodosController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController managerController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  FocusNode todoInputFocusNode = FocusNode();

  //todo List 기본
  RxList<RxMap<String, dynamic>> todos = <RxMap<String, dynamic>>[
    {
      'index' : 0,
      'title': '견적서 양식 등록',
      'manager': '김발자',
      'content': '본사에 필요한 견적서 양식을 작성하여 제출한다.',
      'date': '2024-08-30',
      'type': 0,
      'done': false
    }.obs,
    {
      'index' : 1,
      'title': '급한 일정 입니다.',
      'manager': '김발자',
      'content': '본사에 필요한 견적서 양식을 작성하여 제출한다.',
      'date': '2024-08-30',
      'type': 1,
      'done': false
    }.obs,
  ].obs;

  //todo List 추가
  void addTodo({required String title, required String manager, required String content, required String date}) {
    int index = todos.length;

    //type default 값은 0
    todos.add({
      'index': index,
      'title': title == "" ? '제목 없음' : title,
      'manager': manager == "" ? '담당자 없음' : manager,
      'content': content == "" ? '내용 없음' : content,
      'date': date == "" ? '날짜 없음' : date,
      'type': 0,
      'done': false
    }.obs);

    clearInputs();
  }

  //todo List input 초기화
  void clearInputs() {
    titleController.clear();
    managerController.clear();
    contentController.clear();
    dateController.clear();
    todoInputFocusNode.requestFocus();
  }

  //todo 삭제 (보통 실제 데이터를 삭제하지 않고 del_yn의 값을 변경하여 list에 뜨지 않게 함.)
  void removeTodo(int index) {
    todos.removeAt(index);
    //index 재정렬
    for (int i = 0; i < todos.length; i++) {
      todos[i]['index'] = i;
    }
  }

  //todo 상태 변경(drag and drop)
  void changeStateTodo(int index, int type) {
    todos[index]['state'] = type;
  }
}