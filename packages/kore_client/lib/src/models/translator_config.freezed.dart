// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'translator_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TranslatorConfig {

 LlmProvider get provider; String get apiKey; String get baseUrl; String get model;
/// Create a copy of TranslatorConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TranslatorConfigCopyWith<TranslatorConfig> get copyWith => _$TranslatorConfigCopyWithImpl<TranslatorConfig>(this as TranslatorConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TranslatorConfig&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.model, model) || other.model == model));
}


@override
int get hashCode => Object.hash(runtimeType,provider,apiKey,baseUrl,model);

@override
String toString() {
  return 'TranslatorConfig(provider: $provider, apiKey: $apiKey, baseUrl: $baseUrl, model: $model)';
}


}

/// @nodoc
abstract mixin class $TranslatorConfigCopyWith<$Res>  {
  factory $TranslatorConfigCopyWith(TranslatorConfig value, $Res Function(TranslatorConfig) _then) = _$TranslatorConfigCopyWithImpl;
@useResult
$Res call({
 LlmProvider provider, String apiKey, String baseUrl, String model
});




}
/// @nodoc
class _$TranslatorConfigCopyWithImpl<$Res>
    implements $TranslatorConfigCopyWith<$Res> {
  _$TranslatorConfigCopyWithImpl(this._self, this._then);

  final TranslatorConfig _self;
  final $Res Function(TranslatorConfig) _then;

/// Create a copy of TranslatorConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? provider = null,Object? apiKey = null,Object? baseUrl = null,Object? model = null,}) {
  return _then(_self.copyWith(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as LlmProvider,apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TranslatorConfig].
extension TranslatorConfigPatterns on TranslatorConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TranslatorConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TranslatorConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TranslatorConfig value)  $default,){
final _that = this;
switch (_that) {
case _TranslatorConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TranslatorConfig value)?  $default,){
final _that = this;
switch (_that) {
case _TranslatorConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LlmProvider provider,  String apiKey,  String baseUrl,  String model)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TranslatorConfig() when $default != null:
return $default(_that.provider,_that.apiKey,_that.baseUrl,_that.model);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LlmProvider provider,  String apiKey,  String baseUrl,  String model)  $default,) {final _that = this;
switch (_that) {
case _TranslatorConfig():
return $default(_that.provider,_that.apiKey,_that.baseUrl,_that.model);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LlmProvider provider,  String apiKey,  String baseUrl,  String model)?  $default,) {final _that = this;
switch (_that) {
case _TranslatorConfig() when $default != null:
return $default(_that.provider,_that.apiKey,_that.baseUrl,_that.model);case _:
  return null;

}
}

}

/// @nodoc


class _TranslatorConfig extends TranslatorConfig {
  const _TranslatorConfig({required this.provider, required this.apiKey, this.baseUrl = '', this.model = ''}): super._();
  

@override final  LlmProvider provider;
@override final  String apiKey;
@override@JsonKey() final  String baseUrl;
@override@JsonKey() final  String model;

/// Create a copy of TranslatorConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TranslatorConfigCopyWith<_TranslatorConfig> get copyWith => __$TranslatorConfigCopyWithImpl<_TranslatorConfig>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TranslatorConfig&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.model, model) || other.model == model));
}


@override
int get hashCode => Object.hash(runtimeType,provider,apiKey,baseUrl,model);

@override
String toString() {
  return 'TranslatorConfig(provider: $provider, apiKey: $apiKey, baseUrl: $baseUrl, model: $model)';
}


}

/// @nodoc
abstract mixin class _$TranslatorConfigCopyWith<$Res> implements $TranslatorConfigCopyWith<$Res> {
  factory _$TranslatorConfigCopyWith(_TranslatorConfig value, $Res Function(_TranslatorConfig) _then) = __$TranslatorConfigCopyWithImpl;
@override @useResult
$Res call({
 LlmProvider provider, String apiKey, String baseUrl, String model
});




}
/// @nodoc
class __$TranslatorConfigCopyWithImpl<$Res>
    implements _$TranslatorConfigCopyWith<$Res> {
  __$TranslatorConfigCopyWithImpl(this._self, this._then);

  final _TranslatorConfig _self;
  final $Res Function(_TranslatorConfig) _then;

/// Create a copy of TranslatorConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? provider = null,Object? apiKey = null,Object? baseUrl = null,Object? model = null,}) {
  return _then(_TranslatorConfig(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as LlmProvider,apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
