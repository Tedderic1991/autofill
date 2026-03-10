// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entitlement_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Phase 1 stub — always returns [EntitlementTier.free].
///
/// Phase 4 replaces this with a real RevenueCat-backed implementation
/// using Riverpod's [ProviderContainer.overrideWith]. No other code
/// needs to change when Phase 4 lands.

@ProviderFor(entitlementTier)
final entitlementTierProvider = EntitlementTierProvider._();

/// Phase 1 stub — always returns [EntitlementTier.free].
///
/// Phase 4 replaces this with a real RevenueCat-backed implementation
/// using Riverpod's [ProviderContainer.overrideWith]. No other code
/// needs to change when Phase 4 lands.

final class EntitlementTierProvider extends $FunctionalProvider<EntitlementTier,
    EntitlementTier, EntitlementTier> with $Provider<EntitlementTier> {
  /// Phase 1 stub — always returns [EntitlementTier.free].
  ///
  /// Phase 4 replaces this with a real RevenueCat-backed implementation
  /// using Riverpod's [ProviderContainer.overrideWith]. No other code
  /// needs to change when Phase 4 lands.
  EntitlementTierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'entitlementTierProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$entitlementTierHash();

  @$internal
  @override
  $ProviderElement<EntitlementTier> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EntitlementTier create(Ref ref) {
    return entitlementTier(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EntitlementTier value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EntitlementTier>(value),
    );
  }
}

String _$entitlementTierHash() => r'67261ccdd8cbd9f4162f63d5bc797b87a0befbd2';
