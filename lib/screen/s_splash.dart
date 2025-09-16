import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // 애니메이션 컨트롤러 두개
  late final AnimationController _controller;
  late final AnimationController _controllerSecond;

  // 애니메이션 동작되는거 두개
  late final Animation<double> _animation;
  late final Animation<double> _animationSecond;

  // 애니메이션이 어떻게 동작하는지
  // 첫번째 애니메이션 되고(.forword) 끝나면(.then) 두번째 되고 끝나면 화면 이동
  Future<void> _loadData() async {
    // .then == 어떤 거 실행하고 그거 끝나면 다음꺼 실행함
    // controller.forward() 하면 방아쇠 역할. 실행되면 controller 가 있는 에니메이션이 실행됨.
    // 1. 아래꺼 실행
    _controller.forward().then((value) {
      // 2. 끝나면 아래꺼 실행
      _controllerSecond.forward().then((value) {
        // 3. 끝나면 화면이동
        Navigator.pushNamed(context, '/signIn');
      });
    });
  }

  @override
  // dispose 페이지가 끝날떄 실행됨 init 반대
  void dispose() {
    _controller.dispose();
    _controllerSecond.dispose();
    super.dispose();
  }

  // initState 로 컨트롤러 초기화
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      // 화면에 동기화 하겠다는 뜻
      vsync: this,
      // 이 애니메이션이 동작되는 시간 : 1초
      duration: Duration(seconds: 1),
    );
    _controllerSecond = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    // Tween: between 줄임말 에니메이션 사이 값 : 0~1
    _animation = Tween<double>(
      begin: 0,
      end: 1,
      // CurverdAnimation 애니메이션 효과 parent : 어떻게 동작시킬지 / Curves : 애니메이션 효과
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    // 두번째꺼도 똑같이
    _animationSecond = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controllerSecond, curve: Curves.easeInOut),
    );
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _animation,
              child: SvgPicture.asset('assets/symbol.svg'),
            ),
            FadeTransition(
              opacity: _animationSecond,
              child: Text('My Data Symbol', style: TextStyle(fontSize: 40)),
            ),
          ],
        ),
      ),
    );
  }
}
