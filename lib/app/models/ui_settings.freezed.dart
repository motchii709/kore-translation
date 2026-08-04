// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ui_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UiSettings {

 ThemeMode get themeMode; SubmitShortcut get submitShortcut; SubmitAction get submitAction; AppLanguage get language;
/// Create a copy of UiSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UiSettingsCopyWith<UiSettings> get copyWith => _$UiSettingsCopyWithImpl<UiSettings>(this as UiSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UiSettings&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.submitShortcut, submitShortcut) || other.submitShortcut == submitShortcut)&&(identical(other.submitAction, submitAction) || other.submitAction == submitAction)&&(identical(other.language, language) || other.language == language));
}


@override
int get hashCode => Object.hash(runtimeType,themeMode,submitShortcut,submitAction,language);

@override
String toString() {
  return 'UiSettings(themeMode: $themeMode, submitShortcut: $submitShortcut, submitAction: $submitAction, language: $language)';
}


}

/// @nodoc
abstract mixin class $UiSettingsCopyWith<$Res>  {
  factory $UiSettingsCopyWith(UiSettings value, $Res Function(UiSettings) _then) = _$UiSettingsCopyWithImpl;
@useResult
$Res call({
 ThemeMode themeMode, SubmitShortcut submitShortcut, SubmitAction submitAction, AppLanguage language
});




}
/// @nodoc
class _$UiSettingsCopyWithImpl<$Res>
    implements $UiSettingsCopyWith<$Res> {
  _$UiSettingsCopyWithImpl(this._self, this._then);

  final UiSettings _self;
  final $Res Function(UiSettings) _then;

/// Create a copy of UiSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? themeMode = null,Object? submitShortcut = null,Object? submitAction = null,Object? language = null,}) {
  return _then(_self.copyWith(
themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,submitShortcut: null == submitShortcut ? _self.submitShortcut : submitShortcut // ignore: cast_nullable_to_non_nullable
as SubmitShortcut,submitAction: null == submitAction ? _self.submitAction : submitAction // ignore: cast_nullable_to_non_nullable
as SubmitAction,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as AppLanguage,
  ));
}

}


/// Adds pattern-matching-related methods to [UiSettings].
extension UiSettingsPatterns on UiSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UiSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UiSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UiSettings value)  $default,){
final _that = this;
switch (_that) {
case _UiSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UiSettings value)?  $default,){
final _that = this;
switch (_that) {
case _UiSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ThemeMode themeMode,  SubmitShortcut submitShortcut,  SubmitAction submitAction,  AppLanguage language)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UiSettings() when $default != null:
return $default(_that.themeMode,_that.submitShortcut,_that.submitAction,_that.language);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ThemeMode themeMode,  SubmitShortcut submitShortcut,  SubmitAction submitAction,  AppLanguage language)  $default,) {final _that = this;
switch (_that) {
case _UiSettings():
return $default(_that.themeMode,_that.submitShortcut,_that.submitAction,_that.language);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ThemeMode themeMode,  SubmitShortcut submitShortcut,  SubmitAction submitAction,  AppLanguage language)?  $default,) {final _that = this;
switch (_that) {
case _UiSettings() when $default != null:
return $default(_that.themeMode,_that.submitShortcut,_that.submitAction,_that.language);case _:
  return null;

}
}

}

/// @nodoc


class _UiSettings implements UiSettings {
  const _UiSettings({this.themeMode = ThemeMode.system, this.submitShortcut = SubmitShortcut.enter, this.submitAction = SubmitAction.translate, this.language = AppLanguage.system});
  

@override@JsonKey() final  ThemeMode themeMode;
@override@JsonKey() final  SubmitShortcut submitShortcut;
@override@JsonKey() final  SubmitAction submitAction;
@override@JsonKey() final  AppLanguage language;

/// Create a copy of UiSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UiSettingsCopyWith<_UiSettings> get copyWith => __$UiSettingsCopyWithImpl<_UiSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UiSettings&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.submitShortcut, submitShortcut) || other.submitShortcut == submitShortcut)&&(identical(other.submitAction, submitAction) || other.submitAction == submitAction)&&(identical(other.language, language) || other.language == language));
}


@override
int get hashCode => Object.hash(runtimeType,themeMode,submitShortcut,submitAction,language);

@override
String toString() {
  return 'UiSettings(themeMode: $themeMode, submitShortcut: $submitShortcut, submitAction: $submitAction, language: $language)';
}


}

/// @nodoc
abstract mixin class _$UiSettingsCopyWith<$Res> implements $UiSettingsCopyWith<$Res> {
  factory _$UiSettingsCopyWith(_UiSettings value, $Res Function(_UiSettings) _then) = __$UiSettingsCopyWithImpl;
@override @useResult
$Res call({
 ThemeMode themeMode, SubmitShortcut submitShortcut, SubmitAction submitAction, AppLanguage language
});




}
/// @nodoc
class __$UiSettingsCopyWithImpl<$Res>
    implements _$UiSettingsCopyWith<$Res> {
  __$UiSettingsCopyWithImpl(this._self, this._then);

  final _UiSettings _self;
  final $Res Function(_UiSettings) _then;

/// Create a copy of UiSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? themeMode = null,Object? submitShortcut = null,Object? submitAction = null,Object? language = null,}) {
  return _then(_UiSettings(
themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,submitShortcut: null == submitShortcut ? _self.submitShortcut : submitShortcut // ignore: cast_nullable_to_non_nullable
as SubmitShortcut,submitAction: null == submitAction ? _self.submitAction : submitAction // ignore: cast_nullable_to_non_nullable
as SubmitAction,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as AppLanguage,
  ));
}


}

// dart format on
