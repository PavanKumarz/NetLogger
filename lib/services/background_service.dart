import 'package:workmanager/workmanager.dart';
import 'package:net_logger/services/api_service.dart';
import 'package:net_logger/services/db_service.dart';

const String speedTestTask = 'speedTestTask';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == speedTestTask) {
      try {
        final ping = await ApiService.measurePing();
        final download = await ApiService.measureDownloadSpeed();
        final upload = await ApiService.measureUploadSpeed();

        await DbService.insertResult(
          networkName: 'Background Test',
          downloadSpeed: download == -1 ? 0 : download,
          uploadSpeed: upload == -1 ? 0 : upload,
          ping: ping == -1 ? 0 : ping,
          testedAt: _formattedTime(),
        );
      } catch (e) {
        //silent fail background task should not crash
      }
    }
    return Future.value(true);
  });
}

String _formattedTime() {
  final now = DateTime.now();
  final hour = now.hour % 12 == 0 ? 12 : now.hour % 12;
  final minute = now.minute.toString().padLeft(2, '0');
  final period = now.hour >= 12 ? 'PM' : 'AM';
  return '$hour:$minute $period';
}

class BackgroundService {
  static Future<void> initialize() async {
    await Workmanager().initialize(callbackDispatcher);
  }

  static Future<void> startPeriodicTest() async {
    await Workmanager().registerPeriodicTask(
      'periodic-speed-test',
      speedTestTask,
      frequency: const Duration(minutes: 15),
      constraints: Constraints(networkType: NetworkType.connected),
    );
  }

  static Future<void> stopPeriodicTest() async {
    await Workmanager().cancelByUniqueName('periodic-speed-test');
  }
}
