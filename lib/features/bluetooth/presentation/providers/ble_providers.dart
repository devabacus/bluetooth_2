import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ble_providers.g.dart';


class BleUuids {
  static const String serviceUuid = "6e400001-b5a3-f393-e0a9-e50e24dcca9e";
  static const String writeCharacteristicUuid = "6e400002-b5a3-f393-e0a9-e50e24dcca9e";
  static const String notifyCharacteristicUuid = "6e400003-b5a3-f393-e0a9-e50e24dcca9e";
}


@riverpod
Stream<BluetoothAdapterState> bleState(Ref ref) {
  return FlutterBluePlus.adapterState;
}

@riverpod
Future<void> requestBlePermissions(Ref ref) async {
  await Permission.bluetoothScan.request();
  await Permission.bluetoothConnect.request();
  await Permission.location.request();
}

@riverpod
class ScanResults extends _$ScanResults {
  BluetoothDevice? _device;

  @override
  Stream<List<ScanResult>> build() {
    ref.watch(requestBlePermissionsProvider);
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

  Future<void> stopScan() async {
    try {
      await FlutterBluePlus.stopScan();
    } catch (e) {
      print("ошибка при остановке сканировании $e");
    }
  }
}

@riverpod
class SelectedDevice extends _$SelectedDevice {
  @override
  BluetoothDevice? build() {
    return null;
  }

  void setDevice(BluetoothDevice device) {
    state = device;
    print('${device.advName} connected');
    
  }
}

@riverpod
class DeviceConnection extends _$DeviceConnection {
  @override
  Stream<BluetoothConnectionState> build() {
    final device = ref.watch(selectedDeviceProvider);
    if (device == null) {
      return Stream.value(BluetoothConnectionState.disconnected);
    }
    return device.connectionState;
  }

  Future<void> connect() async {
    final device = ref.read(selectedDeviceProvider);
    if (device == null) return;

    try {
      await FlutterBluePlus.stopScan();
      await device.connect();
      await ref.read(bleServiceProvider.notifier).discoverServices();
    } catch (e) {
      print("Ошибка при подключении: $e");
    }
  }

  Future<void> disconnect() async {
    final device = ref.read(selectedDeviceProvider);
    if (device == null) return;

    try {
      await device.disconnect();
    } catch (e) {
      print("Ошибка при отключении: $e");
    }
  }
}

@riverpod
class BleService extends _$BleService {
  BluetoothService? _service;

  @override
  BluetoothService? build() {
    return _service;
  }

  Future<void> discoverServices() async {
    final device = ref.read(selectedDeviceProvider);
    if (device == null) return;

    try {
      // Обнаруживаем сервисы
      await device.discoverServices();
      
      // Получаем сервисы
      final services = device.servicesList;
      
      // Находим наш сервис по UUID
      for (var service in services) {
        if (service.serviceUuid.toString().toLowerCase().contains(BleUuids.serviceUuid.toLowerCase())) {
          _service = service;
          state = service;
          return;
        }
      }
    } catch (e) {
      print("Ошибка при обнаружении сервисов: $e");
    }
  }
  
  BluetoothCharacteristic? getCharacteristic(String uuid) {
    if (_service == null) return null;
    
    for (var characteristic in _service!.characteristics) {
      if (characteristic.characteristicUuid.toString().toLowerCase().contains(uuid.toLowerCase())) {
        return characteristic;
      }
    }
    return null;
  }
}


@riverpod
class CharacteristicNotifications extends _$CharacteristicNotifications {
  BluetoothCharacteristic? _notifyCharacteristic;
  
  @override
  Stream<List<int>> build() {
    // Получаем сервис
    final service = ref.watch(bleServiceProvider);
    if (service == null) return Stream.value([]);
    
    // Получаем характеристику для уведомлений
    _notifyCharacteristic = ref.read(bleServiceProvider.notifier).getCharacteristic(BleUuids.notifyCharacteristicUuid);
    if (_notifyCharacteristic == null) return Stream.value([]);
    
    // Настраиваем уведомления
    _setupNotifications();
    
    // Возвращаем поток значений
    return _notifyCharacteristic!.lastValueStream;
  }

  Future<void> _setupNotifications() async {
    if (_notifyCharacteristic == null) return;
    
    try {
      await _notifyCharacteristic!.setNotifyValue(true);
    } catch (e) {
      print("Ошибка при настройке уведомлений: $e");
    }
  }
}

@riverpod
class WriteCharacteristic extends _$WriteCharacteristic {
  BluetoothCharacteristic? _writeCharacteristic;
  
  @override
  bool build() {
    // Получаем сервис
    final service = ref.watch(bleServiceProvider);
    if (service == null) return false;
    
    // Получаем характеристику для записи
    _writeCharacteristic = ref.read(bleServiceProvider.notifier).getCharacteristic(BleUuids.writeCharacteristicUuid);
    return _writeCharacteristic != null;
  }

  Future<void> writeData(List<int> data) async {
    if (_writeCharacteristic == null) return;
    
    try {
      await _writeCharacteristic!.write(data);
    } catch (e) {
      print("Ошибка при записи данных: $e");
    }
  }
}