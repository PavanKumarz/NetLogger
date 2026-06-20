import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:wifi_logger/services/db_service.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Map<String, dynamic>> _results = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadResults();
  }

  Future<void> _loadResults() async {
    final data = await DbService.getResults();
    setState(() {
      _results = data;
      _loading = false;
    });
  }

  Future<void> _clearHistory() async {
    await DbService.deleteAll();
    _loadResults();
  }

  Widget _buildChart() {
    final chartData = _results.reversed.toList();

    final downloadSpots = <FlSpot>[];
    final uploadSpots = <FlSpot>[];

    for (int i = 0; i < chartData.length; i++) {
      final download = (chartData[i]['download_speed'] as num).toDouble();
      final upload = (chartData[i]['upload_speed'] as num).toDouble();
      downloadSpots.add(FlSpot(i.toDouble(), download));
      uploadSpots.add(FlSpot(i.toDouble(), upload));
    }

    return Container(
      height: 220,
      padding: const EdgeInsets.fromLTRB(8, 16, 16, 8),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: true, drawVerticalLine: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 35,
                getTitlesWidget: (value, meta) => Text(
                  value.toInt().toString(),
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: downloadSpots,
              isCurved: true,
              color: Colors.green,
              barWidth: 2,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(show: false),
            ),
            LineChartBarData(
              spots: uploadSpots,
              isCurved: true,
              color: Colors.blue,
              barWidth: 2,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(width: 10, height: 10, color: Colors.green),
          const SizedBox(width: 6),
          const Text('Download', style: TextStyle(fontSize: 12)),
          const SizedBox(width: 16),
          Container(width: 10, height: 10, color: Colors.blue),
          const SizedBox(width: 6),
          const Text('Upload', style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: _results.isEmpty ? null : _clearHistory,
            tooltip: 'Clear history',
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _results.isEmpty
          ? const Center(child: Text('No tests yet. Run a speed test first.'))
          : RefreshIndicator(
              onRefresh: _loadResults,
              child: ListView(
                padding: const EdgeInsets.only(bottom: 12),
                children: [
                  if (_results.length >= 2) ...[
                    _buildChart(),
                    _buildLegend(),
                    const SizedBox(height: 12),
                  ],
                  ..._results.map((r) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      child: DottedBorder(
                        dashPattern: const [6, 3],
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                r['network_name'] ?? 'Unknown',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Download: ${r['download_speed']} Mbps'),
                                  Text('Upload: ${r['upload_speed']} Mbps'),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Ping: ${r['ping']} ms'),
                                  Text(r['tested_at'] ?? ''),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
    );
  }
}
