// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ApiErrorEnvelope {

 ApiErrorDetail? get error;
/// Create a copy of ApiErrorEnvelope
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiErrorEnvelopeCopyWith<ApiErrorEnvelope> get copyWith => _$ApiErrorEnvelopeCopyWithImpl<ApiErrorEnvelope>(this as ApiErrorEnvelope, _$identity);

  /// Serializes this ApiErrorEnvelope to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiErrorEnvelope&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'ApiErrorEnvelope(error: $error)';
}


}

/// @nodoc
abstract mixin class $ApiErrorEnvelopeCopyWith<$Res>  {
  factory $ApiErrorEnvelopeCopyWith(ApiErrorEnvelope value, $Res Function(ApiErrorEnvelope) _then) = _$ApiErrorEnvelopeCopyWithImpl;
@useResult
$Res call({
 ApiErrorDetail? error
});


$ApiErrorDetailCopyWith<$Res>? get error;

}
/// @nodoc
class _$ApiErrorEnvelopeCopyWithImpl<$Res>
    implements $ApiErrorEnvelopeCopyWith<$Res> {
  _$ApiErrorEnvelopeCopyWithImpl(this._self, this._then);

  final ApiErrorEnvelope _self;
  final $Res Function(ApiErrorEnvelope) _then;

/// Create a copy of ApiErrorEnvelope
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? error = freezed,}) {
  return _then(_self.copyWith(
error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorDetail?,
  ));
}
/// Create a copy of ApiErrorEnvelope
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiErrorDetailCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $ApiErrorDetailCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}


/// Adds pattern-matching-related methods to [ApiErrorEnvelope].
extension ApiErrorEnvelopePatterns on ApiErrorEnvelope {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApiErrorEnvelope value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApiErrorEnvelope() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApiErrorEnvelope value)  $default,){
final _that = this;
switch (_that) {
case _ApiErrorEnvelope():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApiErrorEnvelope value)?  $default,){
final _that = this;
switch (_that) {
case _ApiErrorEnvelope() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ApiErrorDetail? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApiErrorEnvelope() when $default != null:
return $default(_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ApiErrorDetail? error)  $default,) {final _that = this;
switch (_that) {
case _ApiErrorEnvelope():
return $default(_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ApiErrorDetail? error)?  $default,) {final _that = this;
switch (_that) {
case _ApiErrorEnvelope() when $default != null:
return $default(_that.error);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApiErrorEnvelope implements ApiErrorEnvelope {
  const _ApiErrorEnvelope({this.error});
  factory _ApiErrorEnvelope.fromJson(Map<String, dynamic> json) => _$ApiErrorEnvelopeFromJson(json);

@override final  ApiErrorDetail? error;

/// Create a copy of ApiErrorEnvelope
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApiErrorEnvelopeCopyWith<_ApiErrorEnvelope> get copyWith => __$ApiErrorEnvelopeCopyWithImpl<_ApiErrorEnvelope>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApiErrorEnvelopeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiErrorEnvelope&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'ApiErrorEnvelope(error: $error)';
}


}

/// @nodoc
abstract mixin class _$ApiErrorEnvelopeCopyWith<$Res> implements $ApiErrorEnvelopeCopyWith<$Res> {
  factory _$ApiErrorEnvelopeCopyWith(_ApiErrorEnvelope value, $Res Function(_ApiErrorEnvelope) _then) = __$ApiErrorEnvelopeCopyWithImpl;
@override @useResult
$Res call({
 ApiErrorDetail? error
});


@override $ApiErrorDetailCopyWith<$Res>? get error;

}
/// @nodoc
class __$ApiErrorEnvelopeCopyWithImpl<$Res>
    implements _$ApiErrorEnvelopeCopyWith<$Res> {
  __$ApiErrorEnvelopeCopyWithImpl(this._self, this._then);

  final _ApiErrorEnvelope _self;
  final $Res Function(_ApiErrorEnvelope) _then;

/// Create a copy of ApiErrorEnvelope
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? error = freezed,}) {
  return _then(_ApiErrorEnvelope(
error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiErrorDetail?,
  ));
}

/// Create a copy of ApiErrorEnvelope
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiErrorDetailCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $ApiErrorDetailCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}


/// @nodoc
mixin _$ApiErrorDetail {

 String? get message;
/// Create a copy of ApiErrorDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiErrorDetailCopyWith<ApiErrorDetail> get copyWith => _$ApiErrorDetailCopyWithImpl<ApiErrorDetail>(this as ApiErrorDetail, _$identity);

  /// Serializes this ApiErrorDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiErrorDetail&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ApiErrorDetail(message: $message)';
}


}

/// @nodoc
abstract mixin class $ApiErrorDetailCopyWith<$Res>  {
  factory $ApiErrorDetailCopyWith(ApiErrorDetail value, $Res Function(ApiErrorDetail) _then) = _$ApiErrorDetailCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$ApiErrorDetailCopyWithImpl<$Res>
    implements $ApiErrorDetailCopyWith<$Res> {
  _$ApiErrorDetailCopyWithImpl(this._self, this._then);

  final ApiErrorDetail _self;
  final $Res Function(ApiErrorDetail) _then;

/// Create a copy of ApiErrorDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = freezed,}) {
  return _then(_self.copyWith(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ApiErrorDetail].
extension ApiErrorDetailPatterns on ApiErrorDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApiErrorDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApiErrorDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApiErrorDetail value)  $default,){
final _that = this;
switch (_that) {
case _ApiErrorDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApiErrorDetail value)?  $default,){
final _that = this;
switch (_that) {
case _ApiErrorDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApiErrorDetail() when $default != null:
return $default(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? message)  $default,) {final _that = this;
switch (_that) {
case _ApiErrorDetail():
return $default(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? message)?  $default,) {final _that = this;
switch (_that) {
case _ApiErrorDetail() when $default != null:
return $default(_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApiErrorDetail implements ApiErrorDetail {
  const _ApiErrorDetail({this.message});
  factory _ApiErrorDetail.fromJson(Map<String, dynamic> json) => _$ApiErrorDetailFromJson(json);

@override final  String? message;

/// Create a copy of ApiErrorDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApiErrorDetailCopyWith<_ApiErrorDetail> get copyWith => __$ApiErrorDetailCopyWithImpl<_ApiErrorDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApiErrorDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiErrorDetail&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ApiErrorDetail(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ApiErrorDetailCopyWith<$Res> implements $ApiErrorDetailCopyWith<$Res> {
  factory _$ApiErrorDetailCopyWith(_ApiErrorDetail value, $Res Function(_ApiErrorDetail) _then) = __$ApiErrorDetailCopyWithImpl;
@override @useResult
$Res call({
 String? message
});




}
/// @nodoc
class __$ApiErrorDetailCopyWithImpl<$Res>
    implements _$ApiErrorDetailCopyWith<$Res> {
  __$ApiErrorDetailCopyWithImpl(this._self, this._then);

  final _ApiErrorDetail _self;
  final $Res Function(_ApiErrorDetail) _then;

/// Create a copy of ApiErrorDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(_ApiErrorDetail(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
