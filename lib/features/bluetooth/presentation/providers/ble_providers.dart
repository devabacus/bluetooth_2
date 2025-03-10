import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ble_providers.g.dart';

@riverpod
Stream<BluetoothAdapterState> bleState(Ref ref) {
  return FlutterBluePlus.adapterState;
}

@riverpod
class ScanResults extends _$ScanResults {
  @override
  Stream<List<ScanResult>> build() {
    _requestPermission();
    return FlutterBluePlus.scanResults;
  }

  Future<void> startScan({
    Duration timeout = const Duration(seconds: 10),
  }) async {
    try {
      _bleTurnOnCheck();
      await FlutterBluePlus.startScan(timeout: timeout);
    } catch (e) {
      print("ошибка при сканировании $e");
    }
  }


@riverpod
class BleConnect extends _$BleConnect {
  @override
   build() {
    return ;
  }
}


  Future<void> _bleTurnOnCheck() async {
    final bluetoothState = await ref.read(bleStateProvider.future);
    if (bluetoothState != BluetoothAdapterState.on) {
      await FlutterBluePlus.turnOn();
    }
    await Future.delayed(Duration(milliseconds: 500));
    final newState = await ref.read(bleStateProvider.future);
    if (newState != BluetoothAdapterState.on) {
      throw Exception("Не удалось включить bluetooth");
    }
  }

  Future<void> _requestPermission() async {
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();
    await Permission.location.request();
  }
}

