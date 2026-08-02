// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppSettings {

 LlmProvider get provider; String get baseUrl; String get apiKey; String get model; String get acpCommand; String get codexCommand; bool get thinking; String get systemPrompt;
/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppSettingsCopyWith<AppSettings> get copyWith => _$AppSettingsCopyWithImpl<AppSettings>(this as AppSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppSettings&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.model, model) || other.model == model)&&(identical(other.acpCommand, acpCommand) || other.acpCommand == acpCommand)&&(identical(other.codexCommand, codexCommand) || other.codexCommand == codexCommand)&&(identical(other.thinking, thinking) || other.thinking == thinking)&&(identical(other.systemPrompt, systemPrompt) || other.systemPrompt == systemPrompt));
}


@override
int get hashCode => Object.hash(runtimeType,provider,baseUrl,apiKey,model,acpCommand,codexCommand,thinking,systemPrompt);

@override
String toString() {
  return 'AppSettings(provider: $provider, baseUrl: $baseUrl, apiKey: $apiKey, model: $model, acpCommand: $acpCommand, codexCommand: $codexCommand, thinking: $thinking, systemPrompt: $systemPrompt)';
}


}

/// @nodoc
abstract mixin class $AppSettingsCopyWith<$Res>  {
  factory $AppSettingsCopyWith(AppSettings value, $Res Function(AppSettings) _then) = _$AppSettingsCopyWithImpl;
@useResult
$Res call({
 LlmProvider provider, String baseUrl, String apiKey, String model, String acpCommand, String codexCommand, bool thinking, String systemPrompt
});




}
/// @nodoc
class _$AppSettingsCopyWithImpl<$Res>
    implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._self, this._then);

  final AppSettings _self;
  final $Res Function(AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? provider = null,Object? baseUrl = null,Object? apiKey = null,Object? model = null,Object? acpCommand = null,Object? codexCommand = null,Object? thinking = null,Object? systemPrompt = null,}) {
  return _then(_self.copyWith(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as LlmProvider,baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,acpCommand: null == acpCommand ? _self.acpCommand : acpCommand // ignore: cast_nullable_to_non_nullable
as String,codexCommand: null == codexCommand ? _self.codexCommand : codexCommand // ignore: cast_nullable_to_non_nullable
as String,thinking: null == thinking ? _self.thinking : thinking // ignore: cast_nullable_to_non_nullable
as bool,systemPrompt: null == systemPrompt ? _self.systemPrompt : systemPrompt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AppSettings].
extension AppSettingsPatterns on AppSettings {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppSettings value)  $default,){
final _that = this;
switch (_that) {
case _AppSettings():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppSettings value)?  $default,){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LlmProvider provider,  String baseUrl,  String apiKey,  String model,  String acpCommand,  String codexCommand,  bool thinking,  String systemPrompt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that.provider,_that.baseUrl,_that.apiKey,_that.model,_that.acpCommand,_that.codexCommand,_that.thinking,_that.systemPrompt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LlmProvider provider,  String baseUrl,  String apiKey,  String model,  String acpCommand,  String codexCommand,  bool thinking,  String systemPrompt)  $default,) {final _that = this;
switch (_that) {
case _AppSettings():
return $default(_that.provider,_that.baseUrl,_that.apiKey,_that.model,_that.acpCommand,_that.codexCommand,_that.thinking,_that.systemPrompt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LlmProvider provider,  String baseUrl,  String apiKey,  String model,  String acpCommand,  String codexCommand,  bool thinking,  String systemPrompt)?  $default,) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that.provider,_that.baseUrl,_that.apiKey,_that.model,_that.acpCommand,_that.codexCommand,_that.thinking,_that.systemPrompt);case _:
  return null;

}
}

}

/// @nodoc


class _AppSettings extends AppSettings {
  const _AppSettings({this.provider = LlmProvider.openAi, this.baseUrl = '', this.apiKey = '', this.model = '', this.acpCommand = '', this.codexCommand = '', this.thinking = true, this.systemPrompt = ''}): super._();
  

@override@JsonKey() final  LlmProvider provider;
@override@JsonKey() final  String baseUrl;
@override@JsonKey() final  String apiKey;
@override@JsonKey() final  String model;
@override@JsonKey() final  String acpCommand;
@override@JsonKey() final  String codexCommand;
@override@JsonKey() final  bool thinking;
@override@JsonKey() final  String systemPrompt;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppSettingsCopyWith<_AppSettings> get copyWith => __$AppSettingsCopyWithImpl<_AppSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppSettings&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.model, model) || other.model == model)&&(identical(other.acpCommand, acpCommand) || other.acpCommand == acpCommand)&&(identical(other.codexCommand, codexCommand) || other.codexCommand == codexCommand)&&(identical(other.thinking, thinking) || other.thinking == thinking)&&(identical(other.systemPrompt, systemPrompt) || other.systemPrompt == systemPrompt));
}


@override
int get hashCode => Object.hash(runtimeType,provider,baseUrl,apiKey,model,acpCommand,codexCommand,thinking,systemPrompt);

@override
String toString() {
  return 'AppSettings(provider: $provider, baseUrl: $baseUrl, apiKey: $apiKey, model: $model, acpCommand: $acpCommand, codexCommand: $codexCommand, thinking: $thinking, systemPrompt: $systemPrompt)';
}


}

/// @nodoc
abstract mixin class _$AppSettingsCopyWith<$Res> implements $AppSettingsCopyWith<$Res> {
  factory _$AppSettingsCopyWith(_AppSettings value, $Res Function(_AppSettings) _then) = __$AppSettingsCopyWithImpl;
@override @useResult
$Res call({
 LlmProvider provider, String baseUrl, String apiKey, String model, String acpCommand, String codexCommand, bool thinking, String systemPrompt
});




}
/// @nodoc
class __$AppSettingsCopyWithImpl<$Res>
    implements _$AppSettingsCopyWith<$Res> {
  __$AppSettingsCopyWithImpl(this._self, this._then);

  final _AppSettings _self;
  final $Res Function(_AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? provider = null,Object? baseUrl = null,Object? apiKey = null,Object? model = null,Object? acpCommand = null,Object? codexCommand = null,Object? thinking = null,Object? systemPrompt = null,}) {
  return _then(_AppSettings(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as LlmProvider,baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,acpCommand: null == acpCommand ? _self.acpCommand : acpCommand // ignore: cast_nullable_to_non_nullable
as String,codexCommand: null == codexCommand ? _self.codexCommand : codexCommand // ignore: cast_nullable_to_non_nullable
as String,thinking: null == thinking ? _self.thinking : thinking // ignore: cast_nullable_to_non_nullable
as bool,systemPrompt: null == systemPrompt ? _self.systemPrompt : systemPrompt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
