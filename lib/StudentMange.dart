import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localstorage/localstorage.dart';
import 'package:testfirst/AttendancePage.dart';
import 'PlusStudent.dart';

class TodoItem {
  String name;
  String phone;
  String id;
  String pw;

  TodoItem({
    required this.name,
    required this.phone,
    required this.id,
    required this.pw,
  });
  toJSONEncodable() {
    Map<String, dynamic> m = new Map();
    m['name'] = name;
    m['phone'] = phone;
    m['id'] = id;
    m['pw'] = pw;
    return m;
  }
}

class TodoList {
  List<TodoItem> items = [];
  toJSONEncodable() {
    return items.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }
}

class ManageMent extends StatefulWidget {
  final LocalStorage storage; // 추가: LocalStorage를 위한 멤버 변수 선언

  // 생성자 수정
  ManageMent(this.storage); // LocalStorage를 받는 생성자 추가

  @override
  ManagePage createState() => ManagePage();
}

class ManagePage extends State<ManageMent> {


  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width -12;
    String password = '';
    double screenheight = MediaQuery.of(context).size.height;
    List<List<String>> studentList = [];
    List<Widget> studentWidgets = [];
    List<dynamic> _dataList = [];
    if (widget.storage.getItem('todos') != null){
      _dataList = widget.storage.getItem('todos');
      print(_dataList);
    }
    print(_dataList);
    for (int i = 0;i < _dataList.length;i++){
      studentWidgets.add(
        Column(
          children: [
            Container( height:3.0,
              width:screenWidth+12,
              color: Colors.white,),
            Row(
            children: [
              Container(width: screenWidth*0.1,height: 50.0, decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.black,), child: Center(child: Text((i+1).toString(), style: TextStyle(color: Colors.white,fontSize: 16.0,fontWeight: FontWeight.bold),),),),
              Container(width: 3.0, height: screenheight *0.1,color: Colors.white,),
              Container(padding:EdgeInsets.all(20), child:Text(_dataList[i]['name'] , textAlign: TextAlign.center, style: TextStyle(fontSize: 16.0),), width: screenWidth*0.15,), // 학생 이름 표시
              Container(width: 3.0, height: screenheight *0.1,color: Colors.white,),
              Container(padding:EdgeInsets.all(20), child:Text(_dataList[i]['phone'], textAlign: TextAlign.center, style: TextStyle(fontSize: 16.0),), width: screenWidth*0.34,), // 학생 이름 표시
              Container(width: 3.0, height: screenheight *0.1,color: Colors.white,),
              Container(padding:EdgeInsets.all(20), child:Text(_dataList[i]['id'], textAlign: TextAlign.center, style: TextStyle(fontSize: 16.0),), width: screenWidth*0.2,), // 학생 이름 표시
              Container(width: 3.0, height: screenheight *0.1,color: Colors.white,),
              Container(padding:EdgeInsets.all(20), child:Text(_dataList[i]['pw'], textAlign: TextAlign.center, style: TextStyle(fontSize: 16.0),), width: screenWidth*0.195,), // 학생 이름 표시
            ]),
          ]),
      );
    }
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp, // 화면을 세로 방향으로
    ]);
    return Scaffold(
        body:
        SingleChildScrollView(
        child:
        Column(children:[
          Container(
              color: Color(0xFF848484),
              child: Row(
                children: [
                  Container(width: screenWidth*0.1,height: 50.0, decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.black,), child: Center(child: Text('번호', style: TextStyle(color: Colors.white,fontSize: 16.0,fontWeight: FontWeight.bold),),),),
                  Container(width: 3.0, height: screenheight *0.1,color: Colors.white,),
                  Container(padding:EdgeInsets.fromLTRB(0,50,0,50), child:Text('이름', textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0,  fontWeight: FontWeight.bold),), width: screenWidth*0.15, height: screenheight *0.1,), // 학생 이름 표시
                  Container(width: 3.0, height: screenheight *0.1,color: Colors.white,),
                  Container(padding:EdgeInsets.fromLTRB(0,50,0,50),child:Text('전화번호', textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),), width: screenWidth*0.34,height: screenheight *0.1,), // 학생 이름 표시
                  Container(width: 3.0, height: screenheight *0.1,color: Colors.white,),
                  Container(padding:EdgeInsets.fromLTRB(0,50,0,50),child:Text('아이디', textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),), width: screenWidth*0.2,height: screenheight *0.1,), // 학생 이름 표시
                  Container(width: 3.0, height: screenheight *0.1,color: Colors.white,),
                  Container(padding:EdgeInsets.fromLTRB(0,50,0,50),child:Text('비밀번호',  textAlign: TextAlign.center,style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),), width: screenWidth*0.195,height: screenheight *0.1,), // 학생 이름 표시
                ],
              )
          ),
          Column(
              children:[
                Container(
                  color: Colors.black12,
                  child: Column(
                    children: studentWidgets,
                  ),
                ),
              ]
          ),
          Row(
            children: [
              Container(child: ElevatedButton(onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlusStudent(widget.storage)),
              );}, child: Text('추가', textAlign: TextAlign.center, style: TextStyle(fontSize: 25.0, ), ), style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF848484)),)), width: (screenWidth + 9) / 2, height: screenheight *0.1,color: Color(0xFF848484)),
              Container(width: 3.0, height: screenheight *0.1,color: Colors.white,),
              Container(child: ElevatedButton(onPressed: () {}, child: Text('삭제', textAlign: TextAlign.center, style: TextStyle(fontSize: 25.0, ), ), style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF848484)),)), width: (screenWidth + 9) / 2, height: screenheight *0.1,color: Color(0xFF848484)),

            ]
          ),
        ])
        ));
  }
}






