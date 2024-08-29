import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodosController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController managerController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  //todo List 기본
  RxList<RxMap<String, dynamic>> todos = <RxMap<String, dynamic>>[
    {
      'index': 1,
      'order': 0,
      'title': '견적서 양식 등록',
      'manager': '김발자',
      'content': '본사에 필요한 견적서 양식을 작성하여 제출한다.',
      'date': '2024-08-30',
      'type': 0,
    }.obs,
    {
      'index': 2,
      'order': 0,
      'title': '급한 일정 입니다.',
      'manager': '김발자',
      'content': '본사에 필요한 견적서 양식을 작성하여 제출한다.',
      'date': '2024-08-30',
      'type': 1,
    }.obs,
  ].obs;

  //todo List 추가
  void addTodo({required String title,required String manager,required String content,required String date,}) {
    int index = todos.length+1;
    // p : previous , n: next
    int maxOrder = todos
        .where((todo) => todo['type'] == 0)
        .map((todo) => todo['order'])
        .fold(0, (p, n) => p > n ? p : n);

    //type default 값은 0
    //model을 사용하지 않아 default 처리 여기서.
    todos.add({
      'index': index,
      'title': title == "" ? '제목 없음' : title,
      'manager': manager == "" ? '담당자 없음' : manager,
      'content': content == "" ? '내용 없음' : content,
      'date': date == "" ? '날짜 없음' : date,
      'type': 0,
      'order': maxOrder + 1,
      'done': false,
    }.obs);

    clearInput();
  }

  //todo 상태 변경(drag and drop) - 다른 열
  void updateType(RxMap<String, dynamic> todo, int newType) {
    todo['type'] = newType;
  }

  //todo 상태 변경(drag and drop) - 같은 열
  void updateOrder(List<RxMap<String, dynamic>> updateTodos) {
    for (var todo in updateTodos) {
      var originalTodo = todos.firstWhere((t) => t['index'] == todo['index']);

      originalTodo['order'] = todo['order'];
    }

    todos.refresh();
  }

  //todo 삭제 (보통 실제 데이터를 삭제하지 않고 del_yn의 값을 변경하여 list에 뜨지 않게 함.)
  Future<void> removeTodo(int idx) async {
    todos.removeWhere((todo) => todo['index'] == idx);

    //잘못생각하고 Index도 초기화 함.. index가 커지면 list 조회를 오래한다고 착각했다
    // for (int i = 0; i < todos.length; i++) {
    //   todos[i]['index'] = i;
    // }
  }

  //todo input 초기화
  void clearInput() {
    titleController.clear();
    managerController.clear();
    contentController.clear();
    dateController.clear();
  }

  //todo setState
  void refreshTodo(){
    todos.refresh();
  }

  //dialog back
  Future<void> back() async {
    Get.back();
  }
}
