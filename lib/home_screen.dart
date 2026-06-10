import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('WiFi Logger'), centerTitle: false),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Current Network\n    Home_WiFi',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 5),

          Text('Download Speed\n       0 Mbps', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 5),

          Text('Upload speed\n     0 Mbps', style: TextStyle(fontSize: 18)),

          const SizedBox(height: 5),

          Text('Ping\n0 ms', style: TextStyle(fontSize: 18)),

          const SizedBox(height: 5),

          Text('Status: Not Tested', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  'START SPEED TEST',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text('Last Test:\n   Never', style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
