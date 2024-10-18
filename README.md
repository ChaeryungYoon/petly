Petly App
프로젝트 개요
Petly는 반려동물 관리 앱으로, 사용자에게 반려동물의 건강 관리, 예방접종 일정, 주간 스케줄 등을 관리할 수 있는 기능을 제공합니다. 이 앱은 Flutter를 기반으로 개발되었습니다.

사용 기술
Flutter: 크로스 플랫폼 앱 개발을 위한 프레임워크
Firebase: 사용자 인증 및 데이터 관리를 위한 백엔드 서비스
Table Calendar: 달력 UI 구현을 위한 패키지
flutter_local_notifications: 알림 기능 구현을 위한 패키지
timezone: 알림 시간 관리 및 설정을 위한 패키지
기능 구현
1. 로그인 화면
사용자는 이메일과 비밀번호를 통해 로그인할 수 있으며, 회원가입 화면으로 이동할 수 있는 버튼도 포함되어 있습니다.

dart
코드 복사
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      // 오류 처리
    }
  }

  @override
  Widget build(BuildContext context) {
    // UI 구성
  }
}
2. 스플래쉬 화면
앱이 시작할 때 보여지는 화면으로, 2초 후 로그인 화면으로 자동으로 전환됩니다.

dart
코드 복사
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('assets/splash_logo.png')),
    );
  }
}
3. 홈 화면
홈 화면에서는 월간 캘린더와 랜덤으로 선택된 팁, 예방접종 정보를 표시합니다.

dart
코드 복사
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 필요한 변수 및 메서드 정의
}
4. 개체별 관리 화면
반려동물 정보를 등록하고 관리하는 화면입니다. 의료 정보와 예방접종 일정 등을 추가할 수 있습니다. 화면 구성은 다음과 같습니다.

dart
코드 복사
class ManagementScreen extends StatelessWidget {
  const ManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Management')),
      body: Column(
        children: [
          // 반려동물 정보 표시
          // 의료정보 추가 버튼
          // 주간 캘린더
          // 예방접종 일정 표시
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 반려동물 추가
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
5. 메뉴 탭
왼쪽 상단에 메뉴 탭을 추가하여 사용자 계정 정보와 등록된 반려동물 목록을 보여줍니다. 사용자가 반려동물 정보를 쉽게 추가하거나 수정할 수 있도록 UI를 설계했습니다.

결론
이 프로젝트를 통해 Flutter와 Firebase를 이용하여 실질적인 모바일 앱을 개발할 수 있었습니다. 앱의 주요 기능들을 구현하고 테스트하는 과정에서 많은 것을 배울 수 있었습니다. 앞으로도 지속적으로 업데이트 및 개선할 예정입니다.
