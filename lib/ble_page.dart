import 'package:bluetooth_2/features/bluetooth/presentation/providers/ble_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BlePage extends ConsumerWidget {
  const BlePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final adapterState = ref.watch(bleStateProvider);
    final scanResultsStream = ref.watch(scanResultsProvider);
    final scanControl = ref.read(scanResultsProvider.notifier);
    // scanControl.startScan();

    return Scaffold(
      appBar: AppBar(
        actions: [
          // Chip(label: label)
        ],
        title: Text("Поиск устройств", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.lightBlue,
        ),
        
      body: Column(
        children: [
          Expanded(
            child: scanResultsStream.when(
              data: (scanResults) {
                return ListView.builder(
                  itemCount: scanResults.length,
                  itemBuilder: (context, index) {
                    final scanResult = scanResults[index];
                    final device = scanResult.device;
                    return ListTile(
                      title:
                          device.advName.isEmpty
                              ? Text("Неизвестное устройство")
                              : Text(device.advName),
                      subtitle: Text("${scanResult.device.remoteId}"),
                      trailing: Text(scanResult.rssi.toString()),
                      onTap: ()=> scanControl.connect(scanResult.device.remoteId.toString()),
                    );
                  },
                );
              },

              error: (_, __) => Text("Ошибка"),
              loading: () => Center(child: CircularProgressIndicator()),
            ),
          ),
          ElevatedButton(
            onPressed: scanControl.startScan,
            child: Text("start scan"),
          ),
        ],
      ),
    );
  }
}



