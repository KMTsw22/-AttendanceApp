import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:localstorage/localstorage.dart';

import 'StudentMange.dart';

class PlusStudent extends StatefulWidget {
  final LocalStorage storage;
  PlusStudent(this.storage);

  @override
  PlusStudentState createState() => PlusStudentState();
}
class PlusStudentState extends State<PlusStudent> {
  TextEditingController _name = TextEditingController(); // 수정: 상태로 옮김
  TextEditingController _phone = TextEditingController(); // 수정: 상태로 옮김
  TextEditingController _id = TextEditingController(); // 수정: 상태로 옮김
  TextEditingController _pw = TextEditingController();
  @override
  void initState() {
    super.initState();
    // 페이지가 처음 빌드될 때 저장소에서 데이터를 불러옴
    List<dynamic>? storedData = widget.storage.getItem('todos');
    if (storedData != null) {
      // JSON 형식으로 저장된 데이터를 TodoItem으로 변환하여 리스트에 저장
      list.items = storedData
          .map((item) =>
          TodoItem(name: item['name'],
              phone: item['phone'],
              id: item['id'],
              pw: item['pw']))
          .toList();
    }
  }
  void printd(){
    List<dynamic> _dataList = widget.storage.getItem('todos');
    for (int i = 0;i < _dataList.length;i++){
      print(_dataList[i]);
    }
    _clearStorage();
  }
  final TodoList list = TodoList();
  bool initialized = false;
  TextEditingController controller = TextEditingController();

  Future<void> addstudent() async {
    // 기존 JSON 파일의 내용을 읽어옵니다.
    Map<String, dynamic> newObject = {'name':'','phone':'','id':'','pw':''};
    final newItem = TodoItem(
      name: _name.text, // 이름을 가져옵니다. 기본값은 빈 문자열
      phone:_phone.text,
      id: _id.text,
      pw: _pw.text,
    );

    _addItem(newItem); // 새로운 TodoItem을 리스트에 추가
  }

  void _toggleItem(TodoItem item) {
    setState(() {
      _saveToStorage();
    });
  }

  void _addItem(TodoItem newItem) {
    setState(() {
      list.items.add(newItem);
      print(list.items);
      _saveToStorage(); // 저장소에 업데이트된 리스트 저장
    });
  }
  void _saveToStorage() {
    widget.storage.setItem('todos', list.toJSONEncodable());
  }

  void _clearStorage() async {
    await widget.storage.clear();
    setState(() {
      list.items = widget.storage.getItem('todos') ?? [];
    });
  }

  @override
  void dispose() {
    // 컨트롤러를 해제합니다.
    _name.dispose();
    _phone.dispose();
    _id.dispose();
    _pw.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      body:
        Column(
          children: [
            TextField(decoration: InputDecoration(border: OutlineInputBorder(), labelText: '이름',), controller: _name,),
            TextField(decoration: InputDecoration(border: OutlineInputBorder(), labelText: '전화번호'),controller: _phone,),
            TextField(decoration: InputDecoration(border: OutlineInputBorder(), labelText: '아이디',), controller: _id,),
            TextField(decoration: InputDecoration(border: OutlineInputBorder(), labelText: '비밀번호',), controller: _pw,),
            ElevatedButton(onPressed: () { addstudent();},child: Container(child: Text('추가'),  width: screenWidth * 0.5, height: screenheight * 0.1)),

          ],
        )
    );
  }
}