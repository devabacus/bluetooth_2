// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ble_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bleStateHash() => r'f4451ab0106b14c41b2f59fd555724b16c2aa728';

/// See also [bleState].
@ProviderFor(bleState)
final bleStateProvider =
    AutoDisposeStreamProvider<BluetoothAdapterState>.internal(
      bleState,
      name: r'bleStateProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product') ? null : _$bleStateHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BleStateRef = AutoDisposeStreamProviderRef<BluetoothAdapterState>;
String _$requestBlePermissionsHash() =>
    r'd1dbca468b40c90620f6514964d7bf1d79a051b7';

/// See also [requestBlePermissions].
@ProviderFor(requestBlePermissions)
final requestBlePermissionsProvider = AutoDisposeFutureProvider<void>.internal(
  requestBlePermissions,
  name: r'requestBlePermissionsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$requestBlePermissionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RequestBlePermissionsRef = AutoDisposeFutureProviderRef<void>;
String _$scanResultsHash() => r'f08d538e115006434bde3250488215b94a28d693';

/// See also [ScanResults].
@ProviderFor(ScanResults)
final scanResultsProvider =
    AutoDisposeStreamNotifierProvider<ScanResults, List<ScanResult>>.internal(
      ScanResults.new,
      name: r'scanResultsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$scanResultsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ScanResults = AutoDisposeStreamNotifier<List<ScanResult>>;
String _$selectedDeviceHash() => r'ceba553cb1ad86571e732bf6681c9dddf94f4c4d';

/// See also [SelectedDevice].
@ProviderFor(SelectedDevice)
final selectedDeviceProvider =
    AutoDisposeNotifierProvider<SelectedDevice, BluetoothDevice?>.internal(
      SelectedDevice.new,
      name: r'selectedDeviceProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$selectedDeviceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SelectedDevice = AutoDisposeNotifier<BluetoothDevice?>;
String _$deviceConnectionHash() => r'c42f2a834b5d747deb847ff9a2b77e67528a6a60';

/// See also [DeviceConnection].
@ProviderFor(DeviceConnection)
final deviceConnectionProvider = AutoDisposeStreamNotifierProvider<
  DeviceConnection,
  BluetoothConnectionState
>.internal(
  DeviceConnection.new,
  name: r'deviceConnectionProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$deviceConnectionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DeviceConnection =
    AutoDisposeStreamNotifier<BluetoothConnectionState>;
String _$bleServiceHash() => r'56339222f73f09ff9bd50232ed4834f9b4557327';

/// See also [BleService].
@ProviderFor(BleService)
final bleServiceProvider =
    AutoDisposeNotifierProvider<BleService, BluetoothService?>.internal(
      BleService.new,
      name: r'bleServiceProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$bleServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$BleService = AutoDisposeNotifier<BluetoothService?>;
String _$characteristicNotificationsHash() =>
    r'e057291070b34e6c5f903eaa30c1c759674bbf4b';

/// See also [CharacteristicNotifications].
@ProviderFor(CharacteristicNotifications)
final characteristicNotificationsProvider = AutoDisposeStreamNotifierProvider<
  CharacteristicNotifications,
  List<int>
>.internal(
  CharacteristicNotifications.new,
  name: r'characteristicNotificationsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$characteristicNotificationsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CharacteristicNotifications = AutoDisposeStreamNotifier<List<int>>;
String _$writeCharacteristicHash() =>
    r'8eebc4df9fb8e435efb3b137eda9f353a40ec5c1';

/// See also [WriteCharacteristic].
@ProviderFor(WriteCharacteristic)
final writeCharacteristicProvider =
    AutoDisposeNotifierProvider<WriteCharacteristic, bool>.internal(
      WriteCharacteristic.new,
      name: r'writeCharacteristicProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$writeCharacteristicHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$WriteCharacteristic = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
