import 'package:flutter/material.dart';
import 'package:wifi_logger/history_screen.dart';
import 'package:wifi_logger/home_screen.dart';

class BottomNavigationHandler extends StatefulWidget {
  const BottomNavigationHandler({super.key});

  @override
  State<BottomNavigationHandler> createState() =>
      _BottomNavigationHandlerState();
}

class _BottomNavigationHandlerState extends State<BottomNavigationHandler> {
  int currentIndex = 0;

  final List<Widget> pages = [HomeScreen(), HistoryScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
        ],
      ),
    );
  }
}
