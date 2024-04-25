import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trailquest/pages/challenge_page.dart';
import 'package:trailquest/pages/profile_page.dart';
import 'package:trailquest/pages/start_page.dart';
import 'package:trailquest/pages/trail_page.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

WebSocketChannel? channel;
var jsonString = '';
List<dynamic> dataList = [];

void Listen(){
  try {
      channel?.stream.listen((jsonString) {
      Map <String, dynamic> jsonDecoded = jsonDecode(jsonString);
      String msgID;
      if (jsonDecoded.isNotEmpty) {
        // Get the first key-value pair from the Map
        MapEntry<String, dynamic> firstEntry = jsonDecoded.entries.first;
        
        // Extract the value
        msgID = firstEntry.value;
    
        MapEntry<String, dynamic> secondEntry = jsonDecoded.entries.elementAt(1);
        dynamic data = secondEntry.value;

        switch (msgID) {
          case 'leaderboard': 
            dataList = jsonDecode(data);
            break;
          case 'init':
            print(jsonDecode(data));
            break;
        }
      }             
    });
  } catch (e) {
    print(e);
  }

}

void main() {
  channel = WebSocketChannel.connect(Uri.parse("ws://localhost:3000"));
  Listen();
  runApp(const MainApp());
  channel?.sink.close();
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}


class _MainAppState extends State<MainApp> {
  int myIndex = 0; 
  final screens = [
    const StartPage(),
    TrailPage(),
    ChallengePage(), 
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,

      theme: ThemeData(fontFamily: 'InterRegular'),

      home: Scaffold(
        body: screens[myIndex],

        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
          },
          currentIndex: myIndex,
          backgroundColor: Colors.green.shade600,
          selectedItemColor: Colors.white,
          items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/img_home.svg',
              width: 40,
              height: 40,
              colorFilter: ColorFilter.mode(Colors.green.shade900, BlendMode.srcIn),),
            activeIcon: SvgPicture.asset('assets/images/img_home.svg',
              width: 40,
              height: 40,
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),),
            label: 'Start'),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/img_trails.svg',
              width: 40,
              height: 40,
              colorFilter: ColorFilter.mode(Colors.green.shade900, BlendMode.srcIn),),
            activeIcon: SvgPicture.asset('assets/images/img_trails.svg',
              width: 40,
              height: 40,
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn)),
            label: 'Trails'),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/img_trophy.svg',
              width: 40,
              height: 40,
              colorFilter: ColorFilter.mode(Colors.green.shade900, BlendMode.srcIn),),
            activeIcon: SvgPicture.asset('assets/images/img_trophy.svg',
              width: 40,
              height: 40,
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn)),
            label: 'Challanges'),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/img_profile.svg',
              width: 40,
              height: 40,
              colorFilter: ColorFilter.mode(Colors.green.shade900, BlendMode.srcIn),),
            activeIcon: SvgPicture.asset('assets/images/img_profile.svg',
              width: 40,
              height: 40,
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn)),
            label: 'Profile')
          ],
        ),
      ),
    );
  }
}
