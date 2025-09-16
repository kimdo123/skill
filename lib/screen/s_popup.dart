import 'package:flutter/material.dart';

class PopupFragment extends StatelessWidget {
  const PopupFragment({super.key});

  /// 팝업 모달 열기
  void _openPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,      // 바깥 터치 시 닫기 허용
      barrierColor: Colors.black54,  // 배경 어둡게 반투명 처리
      builder: (_) {
        return const CustomModalAt(
          // 모달이 표시될 좌표
          x: 200,    // 왼쪽 기준 200px
          y: 400,    // 위쪽 기준 400px
          width: 150, // 모달 가로 크기 (height를 지정하지 않으면 내용물 높이에 맞춤)
          child: Column(
            mainAxisSize: MainAxisSize.min, // 내용 크기에 맞게 세로 크기 자동 조절
            children: [
              _Item(text: 'Add food image'),
              Divider(height: 1), // 구분선
              _Item(text: 'Add alarm'),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('앱 화면')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openPopup(context), // 버튼 클릭 시 모달 열기
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// 좌표(x, y) 기반 모달 위젯
/// 특징:
/// - width/height를 지정하면 고정 크기
/// - 지정하지 않으면 child 크기에 자동 맞춤
/// - 화면 크기를 넘길 경우 자동으로 스크롤 가능
class CustomModalAt extends StatelessWidget {
  final double x, y;             // 모달을 띄울 좌표
  final double? width, height;   // 고정 크기 (nullable)
  final double edgePadding;      // 화면 가장자리와의 여백
  final Widget child;            // 모달 안에 들어갈 내용

  const CustomModalAt({
    super.key,
    required this.x,
    required this.y,
    this.width,
    this.height,
    this.edgePadding = 12,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // 화면 전체 크기

    return Stack(
      children: [
        Positioned(
          left: x, // X 좌표
          top: y,  // Y 좌표
          child: Material(
            color: Colors.white,  // 모달 내부 배경색
            borderRadius: BorderRadius.circular(12), // 모서리 둥글게
            elevation: 8,                            // 그림자
            child: ConstrainedBox( // 자식 위젯(child)의 크기에 제한(Constraint) 을 주는 위젯
              // 모달 크기 제한: 화면을 넘어가지 않도록 보정
              constraints: BoxConstraints.loose(Size(
                width ?? size.width - x - edgePadding,
                height ?? size.height - y - edgePadding,
              )),
              // 내용이 많을 경우 스크롤 가능
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: child,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// 모달 내부 메뉴 항목
/// - InkWell로 감싸서 클릭 시 닫히도록 설정
class _Item extends StatelessWidget {
  final String text;
  const _Item({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context), // 클릭 시 모달 닫기
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}