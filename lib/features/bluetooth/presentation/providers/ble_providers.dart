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

  BluetoothDevice? _device;

  @override
  Stream<List<ScanResult>> build() {
    _requestPermission();
    return FlutterBluePlus.scanResults;
  }

  Future<void> startScan({
    Duration timeout = const Duration(seconds: 10),
  }) async {
    try {
      await FlutterBluePlus.startScan(timeout: timeout);
    } catch (e) {
      print("ошибка при сканировании $e");
    }
  }

  Future<void> connect(String deviceId) async {
      _device = BluetoothDevice.fromId(deviceId);
      if(_device != null){
        await _device!.connect();
      }
  }

Stream<BluetoothConnectionState>? connectedState() {
      if (_device == null) {
        return Stream.value(BluetoothConnectionState.disconnected);
      }
      return _device!.connectionState;
    }


  Future<void> _requestPermission() async {
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();
    await Permission.location.request();
  }
}

@riverpod
class ConnectedDevice extends _$ConnectedDevice {
  BluetoothDevice? _device;

  BluetoothDevice get device {
    _device ??= BluetoothDevice.fromId(deviceId);
    return _device!;
  }

  @override
  Stream<BluetoothConnectionState> build(String deviceId) {
    if (deviceId.isEmpty) {
      return Stream.value(BluetoothConnectionState.disconnected);
    }
    return device.connectionState;
  }

  Future<void> connect() async {
    if (state.isLoading) return;

    try {
      await FlutterBluePlus.stopScan();
      await device.connect();
    } catch (e) {
      print("Ошибка при подключении");
    }
  }
}
