import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: Column(
        children: [
          const Text('Today', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 15),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DottedBorder(
              dashPattern: const [6, 3],
              borderType: BorderType.RRect,
              radius: const Radius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        ' Download: 52 Mbps',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text('Upload: 15 Mbps', style: TextStyle(fontSize: 16)),
                      Text('Ping: 22 ms', style: TextStyle(fontSize: 16)),
                      Text('Time: 10:30 AM', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DottedBorder(
              dashPattern: const [6, 3],
              borderType: BorderType.RRect,
              radius: const Radius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ' Download: 52 Mbps',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text('Upload: 15 Mbps', style: TextStyle(fontSize: 16)),
                      Text('Ping: 22 ms', style: TextStyle(fontSize: 16)),
                      Text('Time: 10:30 AM', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
