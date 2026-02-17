import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/my_documents.dart';
import 'screens/qa_screen.dart';
import 'screens/profile_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  
  final List<Widget> _screens = [
    const HomeScreen(),
    const MyDocs(),
    const QAScreen(),
    const ProfileScreen(),
  ];
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF4A2A82),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'My documents',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.smart_toy),
            label: 'ChatBot',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Profile'
          ),
        ],
      ),
    );
  }
}
