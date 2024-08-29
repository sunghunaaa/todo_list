import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/views/todo/todo_list.dart';

void main() => runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoList(),
    ));
