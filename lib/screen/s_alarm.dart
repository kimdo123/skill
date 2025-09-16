import 'package:flutter/material.dart';

const kDark = Color(0xFF111827);
const kBg = Color(0xFFF3F4F6);
const kGray = Color(0xFF9CA3AF);

class AlarmFragment extends StatefulWidget {
  const AlarmFragment({super.key});

  @override
  State<AlarmFragment> createState() => _AlarmFragmentState();
}

/// - enabled: 스위치 ON/OFF 상태(변하는 값)
/// - icon, time: 표시용(예제에선 간단히 String/아이콘)
class AlarmData {
  bool enabled;         // on/off
  final IconData icon;  // icon
  final String time;    // 설정시간 (필요없음)

  AlarmData({this.enabled = false, required this.icon, required this.time});
}

class _AlarmFragmentState extends State<AlarmFragment> {
  // 알람 목록: 화면은 이 리스트만 렌더링한다.
  final List<AlarmData> _alarms = [];

  // 새 알람 추가시
  void _addAlarm() {
    setState(() {
      _alarms.add(
          AlarmData(enabled: false, icon: Icons.restaurant, time: '15 : 00'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('MY Health DATA'),
          backgroundColor: kDark,
          foregroundColor: Colors.white),

      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
        itemCount: _alarms.length,
        itemBuilder: (_, i) {
          final alarm = _alarms[i];
          return AlarmItem(
            data: alarm, // 알람 데이터
            onChanged: (v) => setState(() {
              // 스위치 토글 시 상태만 바꿔 다시 그림
              alarm.enabled = v;
            }),
          );
        },
      ),

      // + 버튼: 항목을 추가하면 길어지고, 자동으로 스크롤 가능
      floatingActionButton: FloatingActionButton(
        backgroundColor: kDark,
        onPressed: _addAlarm,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

/// 공통 알람 위젯
class AlarmItem extends StatelessWidget {
  final AlarmData data;
  final ValueChanged<bool> onChanged;

  const AlarmItem({
    super.key,
    required this.data,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration:
          BoxDecoration(color: kBg, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          // 좌측 아이콘(라운드 사각)
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Icon(data.icon, color: kDark),
          ),
          const SizedBox(width: 12),

          // 시간 텍스트
          Text(data.time,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),

          const Spacer(), // 오른쪽 끝으로 밀기

          // 스위치: 시각 테마만 간단히 맞춤
          Switch(
            value: data.enabled,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: kDark,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: kGray,
          ),
        ],
      ),
    );
  }
}
