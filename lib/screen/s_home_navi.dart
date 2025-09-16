import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myhealthdata/screen/bottom_navigation_bar/s_alarm.dart';
import 'package:myhealthdata/screen/bottom_navigation_bar/s_home.dart';
import 'package:myhealthdata/screen/bottom_navigation_bar/s_my_page.dart';
import 'package:myhealthdata/screen/bottom_navigation_bar/s_workout.dart';

class HomeScreenNB extends StatefulWidget {
  const HomeScreenNB({super.key});

  @override
  State<HomeScreenNB> createState() => _HomeScreenNBState();
}

class _HomeScreenNBState extends State<HomeScreenNB> {
  int _selectedIdx = 0;

  List<Widget> get _pages => [
    HomeScreen(),
    AlarmScreen(),
    WorkOutScreen(),
    MyPageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIdx, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIdx,
        onTap: (index) {
          setState(() {
            _selectedIdx = index;
          });
        },
        // 선택 O 색깔
        selectedItemColor: Colors.white,
        // 선택 X 색깔
        unselectedItemColor: Colors.grey,
        // 내비 바 색
        backgroundColor: Colors.grey[800],
        // 클릭시 커지는거 막기
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/home.svg',
              width: 30,
              // 위젯의 색상을 바꾸는 코드
              colorFilter: ColorFilter.mode(
                // 선택되면 white 아니면 grey
                _selectedIdx == 0 ? Colors.white : Colors.grey,
                // srcIn : svg 모양은 유지, 그 위에 색칠
                BlendMode.srcIn,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/alarm.svg',
              width: 30,
              colorFilter: ColorFilter.mode(
                _selectedIdx == 1 ? Colors.white : Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            label: 'Alarm',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/workout.svg',
              width: 30,
              colorFilter: ColorFilter.mode(
                _selectedIdx == 2 ? Colors.white : Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            label: 'Workout',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/mypage.svg',
              width: 30,
              colorFilter: ColorFilter.mode(
                _selectedIdx == 3 ? Colors.white : Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            label: 'MyPage',
          ),
        ],
      ),
    );
  }
}
