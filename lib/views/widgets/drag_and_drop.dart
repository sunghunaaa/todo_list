import 'package:flutter/material.dart';

class DragAndDrop extends StatefulWidget {
  const DragAndDrop({super.key});

  @override
  State<DragAndDrop> createState() => _DragAndDropState();
}

class _DragAndDropState extends State<DragAndDrop> {
  final List<String> _items = [
    '전화',
    '메시지',
    '사진',
    '카메라',
    '시계',
    '지도',
    '달력',
    '메모',
    '앱스토어',
    '설정'
  ];

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      //scrollDirection: Axis.horizontal,
      // children 속성에 드래그 가능한 위젯들을 넣음
      children: _items
          .map((item) => Text(
        item,
        key: ValueKey(item), // 각 아이템에 고유한 키를 지정
        style: TextStyle(fontSize: 24),
      ))
          .toList(),
      // onReorder 속성에 아이템의 순서가 바뀔 때 호출되는 콜백 함수를 지정
      onReorder: (oldIndex, newIndex) {
        setState(() {
          // 아이템의 순서를 변경하는 로직
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = _items.removeAt(oldIndex);
          _items.insert(newIndex, item);
        });
      },
    );
  }
}
