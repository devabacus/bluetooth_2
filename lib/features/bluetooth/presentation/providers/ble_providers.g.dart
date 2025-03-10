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
String _$scanResultsHash() => r'6f17cdcdf86ce26562497e456f74ff2cc9ddc28d';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
