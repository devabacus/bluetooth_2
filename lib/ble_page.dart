import 'package:bluetooth_2/device_page.dart';
import 'package:bluetooth_2/features/bluetooth/presentation/providers/ble_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BlePage extends ConsumerStatefulWidget {
  const BlePage({super.key});

  @override
  ConsumerState<BlePage> createState() => _BlePageState();
}

class _BlePageState extends ConsumerState<BlePage> {
  @override
  void initState() {
    super.initState();
    // Запускаем сканирование при открытии страницы
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScan();
    });
  }

  Future<void> _startScan() async {
    final scanControl = ref.read(scanResultsProvider.notifier);
    await scanControl.startScan();
  }

  @override
  Widget build(BuildContext context) {
    final scanResultsStream = ref.watch(scanResultsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Поиск устройств", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.lightBlue,
        actions: [
          // Кнопка обновления сканирования
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _startScan,
          ),
        ],
      ),
      body: scanResultsStream.when(
        data: (scanResults) {
          if (scanResults.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bluetooth_searching, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text("Устройства не найдены", style: TextStyle(fontSize: 18, color: Colors.grey)),
                ],
              ),
            );
          }
          
          return ListView.builder(
            itemCount: scanResults.length,
            itemBuilder: (context, index) {
              final scanResult = scanResults[index];
              final device = scanResult.device;
              return ListTile(
                title: device.advName.isEmpty
                    ? const Text("Неизвестное устройство")
                    : Text(device.advName),
                subtitle: Text("${device.remoteId}"),
                trailing: Text("${scanResult.rssi} dBm"),
                onTap: () => _connectToDevice(context, device),
              );
            },
          );
        },
        error: (_, __) => const Center(child: Text("Ошибка сканирования")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  void _connectToDevice(BuildContext context, BluetoothDevice device) async {
    // Показываем индикатор загрузки
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        title: Text("Подключение"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text("Подключение к устройству..."),
          ],
        ),
      ),
    );

    try {
      // Устанавливаем выбранное устройство
      ref.read(selectedDeviceProvider.notifier).setDevice(device);
      
      // Подключаемся к устройству (обнаружение сервисов происходит автоматически внутри connect)
      await ref.read(deviceConnectionProvider.notifier).connect();
      
      // Закрываем диалог и переходим на страницу устройства
      if (context.mounted) {
        Navigator.of(context).pop(); // Закрываем диалог
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const DevicePage(),
          ),
        );
      }
    } catch (e) {
      print("Ошибка при подключении: $e");
      if (context.mounted) {
        Navigator.of(context).pop(); // Закрываем диалог
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Ошибка подключения: $e")),
        );
      }
    }
  }
}