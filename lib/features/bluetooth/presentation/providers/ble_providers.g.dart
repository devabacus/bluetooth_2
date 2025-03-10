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
String _$scanResultsHash() => r'c01373cbc720cd0e5ab1081e4274a9542206f76f';

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
String _$connectedDeviceHash() => r'5e9c6b1538a4a05fcf62fa9dde5ef3d357bc8e32';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ConnectedDevice
    extends BuildlessAutoDisposeStreamNotifier<BluetoothConnectionState> {
  late final String deviceId;

  Stream<BluetoothConnectionState> build(String deviceId);
}

/// See also [ConnectedDevice].
@ProviderFor(ConnectedDevice)
const connectedDeviceProvider = ConnectedDeviceFamily();

/// See also [ConnectedDevice].
class ConnectedDeviceFamily
    extends Family<AsyncValue<BluetoothConnectionState>> {
  /// See also [ConnectedDevice].
  const ConnectedDeviceFamily();

  /// See also [ConnectedDevice].
  ConnectedDeviceProvider call(String deviceId) {
    return ConnectedDeviceProvider(deviceId);
  }

  @override
  ConnectedDeviceProvider getProviderOverride(
    covariant ConnectedDeviceProvider provider,
  ) {
    return call(provider.deviceId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'connectedDeviceProvider';
}

/// See also [ConnectedDevice].
class ConnectedDeviceProvider
    extends
        AutoDisposeStreamNotifierProviderImpl<
          ConnectedDevice,
          BluetoothConnectionState
        > {
  /// See also [ConnectedDevice].
  ConnectedDeviceProvider(String deviceId)
    : this._internal(
        () => ConnectedDevice()..deviceId = deviceId,
        from: connectedDeviceProvider,
        name: r'connectedDeviceProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$connectedDeviceHash,
        dependencies: ConnectedDeviceFamily._dependencies,
        allTransitiveDependencies:
            ConnectedDeviceFamily._allTransitiveDependencies,
        deviceId: deviceId,
      );

  ConnectedDeviceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.deviceId,
  }) : super.internal();

  final String deviceId;

  @override
  Stream<BluetoothConnectionState> runNotifierBuild(
    covariant ConnectedDevice notifier,
  ) {
    return notifier.build(deviceId);
  }

  @override
  Override overrideWith(ConnectedDevice Function() create) {
    return ProviderOverride(
      origin: this,
      override: ConnectedDeviceProvider._internal(
        () => create()..deviceId = deviceId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        deviceId: deviceId,
      ),
    );
  }

  @override
  AutoDisposeStreamNotifierProviderElement<
    ConnectedDevice,
    BluetoothConnectionState
  >
  createElement() {
    return _ConnectedDeviceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ConnectedDeviceProvider && other.deviceId == deviceId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, deviceId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ConnectedDeviceRef
    on AutoDisposeStreamNotifierProviderRef<BluetoothConnectionState> {
  /// The parameter `deviceId` of this provider.
  String get deviceId;
}

class _ConnectedDeviceProviderElement
    extends
        AutoDisposeStreamNotifierProviderElement<
          ConnectedDevice,
          BluetoothConnectionState
        >
    with ConnectedDeviceRef {
  _ConnectedDeviceProviderElement(super.provider);

  @override
  String get deviceId => (origin as ConnectedDeviceProvider).deviceId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
