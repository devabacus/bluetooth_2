import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'ble_providers.g.dart';

@riverpod
Stream<BluetoothAdapterState> bluetoothState(Ref ref) {
  return FlutterBluePlus.adapterState;
}

@riverpod
class ScanResults extends _$ScanResults {
  @override
  Stream<List<ScanResult>> build() {
    return FlutterBluePlus.scanResults;
  }

  Future<void> startScan() async {
    await FlutterBluePlus.startScan();
  }
}

// @riverpod
// int getSimpleValue(Ref ref) {
//   return 20;
// }

// @riverpod
// Stream<int> timer(Ref ref) {
//   final stream = Stream<int>.periodic(
//     const Duration(seconds: 1),
//     (count) => count,
//   ).take(5);

//   return stream;
// }

// @riverpod
// FutureOr<int> dataInFuture(Ref ref) async {
//   await Future.delayed(const Duration(seconds: 2));

//   return 654651315;
// }
