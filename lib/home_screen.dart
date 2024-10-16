import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  // TIP 리스트
  final List<String> _tips = [
    '멀티즈는 피부 관리가 중요해요.\n털이 잘 엉켜서 정기적인 빗질과 목욕이 필요해요.',
    '강아지는 매일 산책이 중요해요. 신선한 공기를 마시며 운동을 시켜주세요.',
    '반려견의 건강을 위해 정기적인 예방접종을 잊지 마세요.',
    '고양이도 물을 많이 마셔야 해요. 깨끗한 물을 자주 바꿔주세요.',
    '반려동물의 식단은 영양소가 골고루 들어간 균형잡힌 식사가 중요해요.',
  ];

  // 랜덤 TIP을 위한 변수
  late String _randomTip;

  // 알림 관련 변수
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    // Timezone 초기화
    tz.initializeTimeZones();

    // 랜덤 TIP 선택
    _randomTip = _tips[Random().nextInt(_tips.length)];

    // 알림 초기화
    var initializationSettingsAndroid =
    const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // 예방접종 알림 설정
    _scheduleVaccinationNotification();
  }

  // 예방접종 알림 설정 메서드
  Future<void> _scheduleVaccinationNotification() async {
    var androidDetails = const AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
    );
    var platformDetails = NotificationDetails(android: androidDetails);

    // 알림 스케줄 (여기서는 10초 후 알림)
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      '예방접종 알림',
      '예방접종이 다가오고 있습니다!',
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)), // 알림 시간을 설정
      platformDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Petly'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 상단의 월간 캘린더 표시 부분
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TableCalendar(
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    calendarFormat: CalendarFormat.month,
                    locale: 'ko_KR',
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    calendarStyle: const CalendarStyle(
                      selectedDecoration: BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: BoxDecoration(
                        color: Colors.purple,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // TIP 및 예방접종 정보 표시 부분
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'TIP!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(_randomTip), // 랜덤으로 선택된 TIP 출력
                  const SizedBox(height: 20),
                  const Text(
                    '예방접종',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '예정일: 2023 / 09 / 13',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // 하단 네비게이션 바
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: '상세',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: '위치 기반',
          ),
        ],
      ),
    );
  }
}

