import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:localstorage/localstorage.dart';


class Attendance extends StatefulWidget {



  final LocalStorage storage; // 추가: LocalStorage를 위한 멤버 변수 선언
  Attendance(this.storage); // LocalStorage를 받는 생성자 추가
  @override
  AttendancePage createState() => AttendancePage();
}

class AttendancePage extends State<Attendance> {
  int CurrentStatus = 0; //0-> 아이디 1-> 비밀번호
  String nowText = '';
  String nextpw = '';
  String nextphone = '';
  String nextname = '';
  TextEditingController _textController = TextEditingController(); // 수정: 상태로 옮김
  late List<List<dynamic>> PassList;

  Future<void> sendMessage(String telephone, String name) async {
    var url = Uri.parse('http://127.0.0.1:8000/SendMessage/$telephone/$name');
    try {
      var response = await http.post(url);

      if (response.statusCode == 200) {
        print('메시지 전송 성공');
        // 성공적으로 요청을 처리한 후의 로직을 추가할 수 있습니다.
      } else {
        print('메시지 전송 실패: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('오류 발생: $e');
    }
  }


  void OkBtn(String Id){
    print(CurrentStatus);
    if (CurrentStatus == 0) {
      List<dynamic> ll = [];
      if (widget.storage.getItem('todos') != null) {
        ll = widget.storage.getItem('todos');
      }
      for (int i = 0; i < ll.length; i++) {
        print(ll[i]['id']);
        print(Id);
        if (ll[i]['id'] == Id) {
          nextpw = ll[i]['pw'];
          nextphone = ll[i]['phone'];
          nextname = ll[i]['name'];
          CurrentStatus = 1;
        }
      }
    }
    else{
      if (Id == nextpw){
         sendMessage(nextphone, nextname);
      }

    }
  }

  void plusText(String value) {
    String currentText = _textController.text;
    if (currentText.length >= 4){

    }else {
      currentText += value;
      setState(() {
        _textController.text = currentText;
      });
    }
    print(currentText);
  }
  void minusText() {
    String currentText = _textController.text;
    currentText = currentText.substring(0,currentText.length-1);
    setState(() {
      _textController.text = currentText;
    });
  }
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    // 페이지가 dispose될 때 컨트롤러 해제
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _textController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    String password = '';
    double screenheight = MediaQuery.of(context).size.height;
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
        body: Container(color:Colors.lightBlueAccent, child:
          OrientationBuilder(
            builder: (context, orientation){
              return Column(children: [
                Container(
                  color: Colors.white,
                  height: isPortrait? screenheight * 0.3: screenheight * 0.4, // 세로 모드와 가로 모드에 따라 높이 조절
                  child: (() {
                    if (CurrentStatus == 0) {
                      return TextField(
                        textAlign: isPortrait ? TextAlign.start : TextAlign.center, // isPortrait 값에 따라서 가운데 정렬 또는 시작 정렬을 설정
                        decoration: InputDecoration(
                          hintText: nowText,
                        ),
                        controller: _textController,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          fontSize: 150.0,
                          letterSpacing: isPortrait ? 3.0 : 100.0,
                        ),
                      );
                    } else {
                      return TextField(
                        decoration: InputDecoration(
                          hintText: '비밀번호',
                        ),
                        controller: _textController,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          fontSize: 150.0,
                        ),
                      );; // 조건이 아닐 경우 빈 컨테이너 또는 다른 위젯을 반환
                    }
                  })(),
                ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: () {plusText('1');}, child: Container(width: isPortrait ? screenWidth * 0.25 : screenWidth * 0.295, height: screenheight * 0.15, child: Center(child: Text('1')),),),
                    ElevatedButton(onPressed: () {plusText('2');}, child: Container(width: isPortrait ? screenWidth * 0.25 : screenWidth * 0.295, height: screenheight * 0.15,child: Center(child: Text('2')),),),
                    ElevatedButton(onPressed: () {plusText('3');}, child: Container(width: isPortrait ? screenWidth * 0.25 : screenWidth * 0.295, height: screenheight * 0.15,child: Center(child: Text('3')),),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: () {plusText('4');}, child: Container(width: isPortrait ? screenWidth * 0.25 : screenWidth * 0.295, height: screenheight * 0.15, child: Center(child: Text('4')),),),
                    ElevatedButton(onPressed: () {plusText('5');}, child: Container(width: isPortrait ? screenWidth * 0.25 : screenWidth * 0.295, height: screenheight * 0.15, child: Center(child: Text('5')),),),
                    ElevatedButton(onPressed: () {plusText('6');}, child: Container(width: isPortrait ? screenWidth * 0.25 : screenWidth * 0.295, height: screenheight * 0.15, child: Center(child: Text('6')),),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: () {plusText('7');}, child: Container(width: isPortrait ? screenWidth * 0.25 : screenWidth * 0.295, height: screenheight * 0.15, child: Center(child: Text('7')),),),
                    ElevatedButton(onPressed: () {plusText('8');}, child: Container(width: isPortrait ? screenWidth * 0.25 : screenWidth * 0.295, height: screenheight * 0.15, child: Center(child: Text('8')),),),
                    ElevatedButton(onPressed: () {plusText('9');}, child: Container(width: isPortrait ? screenWidth * 0.25 : screenWidth * 0.295, height: screenheight * 0.15, child: Center(child: Text('9')),),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: () {minusText();}, child: Container(width: isPortrait ? screenWidth * 0.25 : screenWidth * 0.295, height: screenheight * 0.15, child: Center(child: Text('-')),),),
                    ElevatedButton(onPressed: () {plusText('0');}, child: Container(width: isPortrait ? screenWidth * 0.25 : screenWidth * 0.295, height: screenheight * 0.15, child: Center(child: Text('0')),),),
                    ElevatedButton(
                      onPressed: () {OkBtn(_textController.text);},
                      child: Container(
                        width: isPortrait ? screenWidth * 0.25 : screenWidth * 0.295,
                        height: screenheight * 0.15,
                        child: Center(child: Text('Ok')),
                      ),
                    )

                  ],
                ),
              ],
            )
          ],);
            }
        )
    ));
  }
}
