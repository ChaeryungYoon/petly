import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';  // Firebase Core import
import 'login_screen.dart';  // 로그인 화면 파일 import
import 'home_screen.dart';  // 홈 화면 파일 import
import 'package:firebase_auth/firebase_auth.dart';  // Firebase 인증 상태 체크

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // Firebase 초기화 전 설정
  await Firebase.initializeApp();  // Firebase 초기화
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Petly',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(), // 앱 시작 시 스플래쉬 화면
    );
  }
}

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
      // 스플래쉬 화면 2초 보여준 후, AuthWrapper로 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthWrapper()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/splash_logo.png'), // 스플래쉬 로고
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),  // Firebase 인증 상태 확인
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());  // 로딩 중일 때
        } else if (snapshot.hasData) {
          return const HomeScreen();  // 로그인된 경우 홈 화면
        } else {
          return const LoginScreen();  // 로그인이 안 된 경우 로그인 화면
        }
      },
    );
  }
}
