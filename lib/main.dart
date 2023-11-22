import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:testfirst/AttendancePage.dart';
import 'package:testfirst/StudentMange.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstPage(), // 처음에 표시할 페이지를 지정합니다.
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final storage = LocalStorage('DB');

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp, // 화면을 세로 방향으로 고정
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: Center(child:
        Column(
            children: [
              SizedBox(height: 200),
              // Text('Moebius',
              //   style: TextStyle(
              //   fontSize: 40, // 크기 설정
              //   fontWeight: FontWeight.bold, // 두껍게 설정
              //   color: Colors.red, // 색상 설정
              //   )
              // ,),
              SizedBox(height: 400),
              ElevatedButton(
                onPressed: () {
                  // 두 번째 페이지로 이동하는 코드를 작성합니다.
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Attendance(storage)),
                  );
                },
                child: Text('출석체크로 이동'),
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all<Size>(
                      Size(200, 50), // 너비와 높이를 조절하려면 이 값을 변경합니다.
                    ), backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF848484))
                ),

              ),
              SizedBox(height: 10),

              ElevatedButton(
                onPressed: () async {
                  // 두 번째 페이지로 이동하는 코드를 작성합니다.
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ManageMent(storage)),
                  );
                },
                child: Text('학생관리로 이동'),
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all<Size>(
                      Size(200, 50), // 너비와 높이를 조절하려면 이 값을 변경합니다.
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF848484))
                ),
                //0xFF8181F7
              ),
            ]
        ),
        ));
  }


}






