// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppSettingsStorage)
final appSettingsStorageProvider = AppSettingsStorageProvider._();

final class AppSettingsStorageProvider
    extends $AsyncNotifierProvider<AppSettingsStorage, AppSettings> {
  AppSettingsStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appSettingsStorageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appSettingsStorageHash();

  @$internal
  @override
  AppSettingsStorage create() => AppSettingsStorage();
}

String _$appSettingsStorageHash() =>
    r'200a7468cabf0dec27485d1dfba334f9fad992f3';

abstract class _$AppSettingsStorage extends $AsyncNotifier<AppSettings> {
  FutureOr<AppSettings> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AppSettings>, AppSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AppSettings>, AppSettings>,
              AsyncValue<AppSettings>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
