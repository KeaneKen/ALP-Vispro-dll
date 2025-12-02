import 'package:flutter/material.dart';
import 'navbar.dart';
import 'Dashboard.dart';
import 'cart.dart';
import 'profile.dart';

// Global cart counter
final ValueNotifier<int> cartItemCount = ValueNotifier<int>(3);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5D4037)),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const Dashboard(),
    const Cart(),
    const OrdersScreen(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _screens[_currentIndex],
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: cartItemCount,
        builder: (context, count, child) {
          return CustomBottomNavBar(
            currentIndex: _currentIndex,
            cartCount: count,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          );
        },
      ),
    );
  }
}

// Temporary screens untuk testing navbar
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFAE0),
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: const Color(0xFFEDCEAB),
      ),
      body: const Center(
        child: Text(
          'Home Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

// CartScreen sekarang menggunakan widget Cart dari cart.dart

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFAE0),
      body: Column(
        children: [
          const SizedBox(height: 40),
          Expanded(
            child: Center(
              child: Text(
                'Chat Screen',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFAE0),
      body: Column(
        children: [
          const SizedBox(height: 40),
          Expanded(
            child: Center(
              child: Text(
                'Profile Screen',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
