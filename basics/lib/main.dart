import 'dart:async';
import 'package:basics/root_bottomnavigation.dart';
import 'package:basics/authentication/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'authentication/phone.dart';
import 'authentication/verify.dart';
import '2_bottom_nav_screens/home.dart';
import '2_bottom_nav_screens/package.dart';
import '2_bottom_nav_screens/user.dart';
import 'package:basics/navigation/map.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print("Firebase initialization warning: $e");
  }
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.amber,
        ),
      ),
      home: AuthenticationWrapper(),
      routes: {
        'map': (context) =>  Mapscreen(),
        'phone': (context) => const MyPhone(),
        'otp': (context) => const MyVerify(),
        'login': (context) => const LoginScreen(),
        'home': (context) => HomeScreen(),
        'packages': (context) => PackageScreen(),
        'user': (context) => UserScreen(),
        'navigation': (context) => const RootBottomNavigation(),
        'splash': (context) => SplashScreenWidget(),
      },
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data != null) {
            print("✓ User logged in: ${snapshot.data!.uid}");
            return const RootBottomNavigation();
          } else {
            print("✗ User not logged in - showing login");
            return const LoginScreen();
          }
        }
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text("Loading..."),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SplashScreenWidget extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenWidget> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          'assets/petslogin.jpeg',  
          width: 500,  
          height: 400,
        ),
      ),
    );
  }
}