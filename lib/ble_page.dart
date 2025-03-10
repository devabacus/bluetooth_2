import 'package:bluetooth_2/ble_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BlePage extends ConsumerWidget {
  const BlePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adapterState = ref.watch(bluetoothStateProvider);
    final scanResultsStream = ref.watch(scanResultsProvider);
    final scanControl = ref.read(scanResultsProvider.notifier);
    
    // scanControl.startScan();
    
    return Expanded(
      child: Column(
        children: [
          scanResultsStream.when(
            data: (scanResults) {
              return ListView.builder(
                itemCount: scanResults.length,
                itemBuilder: (context, index) {
                  
                  return ListTile(title: Text("${scanResults[index]}"));
                },
              );
            },
          
            error: (_, __) => Text("Ошибка"),
            loading: () => Center(child: CircularProgressIndicator()),
          ),
          ElevatedButton(onPressed: scanControl.startScan, child: Text("start scan"))
        ],
      ),
    );
  }
}
