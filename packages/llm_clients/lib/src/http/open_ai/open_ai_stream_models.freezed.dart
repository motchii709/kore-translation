// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'open_ai_stream_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OpenAiChatChunk {

 List<OpenAiChunkChoice> get choices;
/// Create a copy of OpenAiChatChunk
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenAiChatChunkCopyWith<OpenAiChatChunk> get copyWith => _$OpenAiChatChunkCopyWithImpl<OpenAiChatChunk>(this as OpenAiChatChunk, _$identity);

  /// Serializes this OpenAiChatChunk to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenAiChatChunk&&const DeepCollectionEquality().equals(other.choices, choices));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(choices));

@override
String toString() {
  return 'OpenAiChatChunk(choices: $choices)';
}


}

/// @nodoc
abstract mixin class $OpenAiChatChunkCopyWith<$Res>  {
  factory $OpenAiChatChunkCopyWith(OpenAiChatChunk value, $Res Function(OpenAiChatChunk) _then) = _$OpenAiChatChunkCopyWithImpl;
@useResult
$Res call({
 List<OpenAiChunkChoice> choices
});




}
/// @nodoc
class _$OpenAiChatChunkCopyWithImpl<$Res>
    implements $OpenAiChatChunkCopyWith<$Res> {
  _$OpenAiChatChunkCopyWithImpl(this._self, this._then);

  final OpenAiChatChunk _self;
  final $Res Function(OpenAiChatChunk) _then;

/// Create a copy of OpenAiChatChunk
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? choices = null,}) {
  return _then(_self.copyWith(
choices: null == choices ? _self.choices : choices // ignore: cast_nullable_to_non_nullable
as List<OpenAiChunkChoice>,
  ));
}

}


/// Adds pattern-matching-related methods to [OpenAiChatChunk].
extension OpenAiChatChunkPatterns on OpenAiChatChunk {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OpenAiChatChunk value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OpenAiChatChunk() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OpenAiChatChunk value)  $default,){
final _that = this;
switch (_that) {
case _OpenAiChatChunk():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OpenAiChatChunk value)?  $default,){
final _that = this;
switch (_that) {
case _OpenAiChatChunk() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<OpenAiChunkChoice> choices)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OpenAiChatChunk() when $default != null:
return $default(_that.choices);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<OpenAiChunkChoice> choices)  $default,) {final _that = this;
switch (_that) {
case _OpenAiChatChunk():
return $default(_that.choices);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<OpenAiChunkChoice> choices)?  $default,) {final _that = this;
switch (_that) {
case _OpenAiChatChunk() when $default != null:
return $default(_that.choices);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OpenAiChatChunk implements OpenAiChatChunk {
  const _OpenAiChatChunk({final  List<OpenAiChunkChoice> choices = const []}): _choices = choices;
  factory _OpenAiChatChunk.fromJson(Map<String, dynamic> json) => _$OpenAiChatChunkFromJson(json);

 final  List<OpenAiChunkChoice> _choices;
@override@JsonKey() List<OpenAiChunkChoice> get choices {
  if (_choices is EqualUnmodifiableListView) return _choices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_choices);
}


/// Create a copy of OpenAiChatChunk
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpenAiChatChunkCopyWith<_OpenAiChatChunk> get copyWith => __$OpenAiChatChunkCopyWithImpl<_OpenAiChatChunk>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OpenAiChatChunkToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpenAiChatChunk&&const DeepCollectionEquality().equals(other._choices, _choices));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_choices));

@override
String toString() {
  return 'OpenAiChatChunk(choices: $choices)';
}


}

/// @nodoc
abstract mixin class _$OpenAiChatChunkCopyWith<$Res> implements $OpenAiChatChunkCopyWith<$Res> {
  factory _$OpenAiChatChunkCopyWith(_OpenAiChatChunk value, $Res Function(_OpenAiChatChunk) _then) = __$OpenAiChatChunkCopyWithImpl;
@override @useResult
$Res call({
 List<OpenAiChunkChoice> choices
});




}
/// @nodoc
class __$OpenAiChatChunkCopyWithImpl<$Res>
    implements _$OpenAiChatChunkCopyWith<$Res> {
  __$OpenAiChatChunkCopyWithImpl(this._self, this._then);

  final _OpenAiChatChunk _self;
  final $Res Function(_OpenAiChatChunk) _then;

/// Create a copy of OpenAiChatChunk
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? choices = null,}) {
  return _then(_OpenAiChatChunk(
choices: null == choices ? _self._choices : choices // ignore: cast_nullable_to_non_nullable
as List<OpenAiChunkChoice>,
  ));
}


}


/// @nodoc
mixin _$OpenAiChunkChoice {

 OpenAiChunkDelta? get delta;
/// Create a copy of OpenAiChunkChoice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenAiChunkChoiceCopyWith<OpenAiChunkChoice> get copyWith => _$OpenAiChunkChoiceCopyWithImpl<OpenAiChunkChoice>(this as OpenAiChunkChoice, _$identity);

  /// Serializes this OpenAiChunkChoice to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenAiChunkChoice&&(identical(other.delta, delta) || other.delta == delta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,delta);

@override
String toString() {
  return 'OpenAiChunkChoice(delta: $delta)';
}


}

/// @nodoc
abstract mixin class $OpenAiChunkChoiceCopyWith<$Res>  {
  factory $OpenAiChunkChoiceCopyWith(OpenAiChunkChoice value, $Res Function(OpenAiChunkChoice) _then) = _$OpenAiChunkChoiceCopyWithImpl;
@useResult
$Res call({
 OpenAiChunkDelta? delta
});


$OpenAiChunkDeltaCopyWith<$Res>? get delta;

}
/// @nodoc
class _$OpenAiChunkChoiceCopyWithImpl<$Res>
    implements $OpenAiChunkChoiceCopyWith<$Res> {
  _$OpenAiChunkChoiceCopyWithImpl(this._self, this._then);

  final OpenAiChunkChoice _self;
  final $Res Function(OpenAiChunkChoice) _then;

/// Create a copy of OpenAiChunkChoice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? delta = freezed,}) {
  return _then(_self.copyWith(
delta: freezed == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as OpenAiChunkDelta?,
  ));
}
/// Create a copy of OpenAiChunkChoice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OpenAiChunkDeltaCopyWith<$Res>? get delta {
    if (_self.delta == null) {
    return null;
  }

  return $OpenAiChunkDeltaCopyWith<$Res>(_self.delta!, (value) {
    return _then(_self.copyWith(delta: value));
  });
}
}


/// Adds pattern-matching-related methods to [OpenAiChunkChoice].
extension OpenAiChunkChoicePatterns on OpenAiChunkChoice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OpenAiChunkChoice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OpenAiChunkChoice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OpenAiChunkChoice value)  $default,){
final _that = this;
switch (_that) {
case _OpenAiChunkChoice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OpenAiChunkChoice value)?  $default,){
final _that = this;
switch (_that) {
case _OpenAiChunkChoice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OpenAiChunkDelta? delta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OpenAiChunkChoice() when $default != null:
return $default(_that.delta);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OpenAiChunkDelta? delta)  $default,) {final _that = this;
switch (_that) {
case _OpenAiChunkChoice():
return $default(_that.delta);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OpenAiChunkDelta? delta)?  $default,) {final _that = this;
switch (_that) {
case _OpenAiChunkChoice() when $default != null:
return $default(_that.delta);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OpenAiChunkChoice implements OpenAiChunkChoice {
  const _OpenAiChunkChoice({this.delta});
  factory _OpenAiChunkChoice.fromJson(Map<String, dynamic> json) => _$OpenAiChunkChoiceFromJson(json);

@override final  OpenAiChunkDelta? delta;

/// Create a copy of OpenAiChunkChoice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpenAiChunkChoiceCopyWith<_OpenAiChunkChoice> get copyWith => __$OpenAiChunkChoiceCopyWithImpl<_OpenAiChunkChoice>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OpenAiChunkChoiceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpenAiChunkChoice&&(identical(other.delta, delta) || other.delta == delta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,delta);

@override
String toString() {
  return 'OpenAiChunkChoice(delta: $delta)';
}


}

/// @nodoc
abstract mixin class _$OpenAiChunkChoiceCopyWith<$Res> implements $OpenAiChunkChoiceCopyWith<$Res> {
  factory _$OpenAiChunkChoiceCopyWith(_OpenAiChunkChoice value, $Res Function(_OpenAiChunkChoice) _then) = __$OpenAiChunkChoiceCopyWithImpl;
@override @useResult
$Res call({
 OpenAiChunkDelta? delta
});


@override $OpenAiChunkDeltaCopyWith<$Res>? get delta;

}
/// @nodoc
class __$OpenAiChunkChoiceCopyWithImpl<$Res>
    implements _$OpenAiChunkChoiceCopyWith<$Res> {
  __$OpenAiChunkChoiceCopyWithImpl(this._self, this._then);

  final _OpenAiChunkChoice _self;
  final $Res Function(_OpenAiChunkChoice) _then;

/// Create a copy of OpenAiChunkChoice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? delta = freezed,}) {
  return _then(_OpenAiChunkChoice(
delta: freezed == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as OpenAiChunkDelta?,
  ));
}

/// Create a copy of OpenAiChunkChoice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OpenAiChunkDeltaCopyWith<$Res>? get delta {
    if (_self.delta == null) {
    return null;
  }

  return $OpenAiChunkDeltaCopyWith<$Res>(_self.delta!, (value) {
    return _then(_self.copyWith(delta: value));
  });
}
}


/// @nodoc
mixin _$OpenAiChunkDelta {

 String? get content;
/// Create a copy of OpenAiChunkDelta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenAiChunkDeltaCopyWith<OpenAiChunkDelta> get copyWith => _$OpenAiChunkDeltaCopyWithImpl<OpenAiChunkDelta>(this as OpenAiChunkDelta, _$identity);

  /// Serializes this OpenAiChunkDelta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenAiChunkDelta&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content);

@override
String toString() {
  return 'OpenAiChunkDelta(content: $content)';
}


}

/// @nodoc
abstract mixin class $OpenAiChunkDeltaCopyWith<$Res>  {
  factory $OpenAiChunkDeltaCopyWith(OpenAiChunkDelta value, $Res Function(OpenAiChunkDelta) _then) = _$OpenAiChunkDeltaCopyWithImpl;
@useResult
$Res call({
 String? content
});




}
/// @nodoc
class _$OpenAiChunkDeltaCopyWithImpl<$Res>
    implements $OpenAiChunkDeltaCopyWith<$Res> {
  _$OpenAiChunkDeltaCopyWithImpl(this._self, this._then);

  final OpenAiChunkDelta _self;
  final $Res Function(OpenAiChunkDelta) _then;

/// Create a copy of OpenAiChunkDelta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = freezed,}) {
  return _then(_self.copyWith(
content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OpenAiChunkDelta].
extension OpenAiChunkDeltaPatterns on OpenAiChunkDelta {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OpenAiChunkDelta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OpenAiChunkDelta() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OpenAiChunkDelta value)  $default,){
final _that = this;
switch (_that) {
case _OpenAiChunkDelta():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OpenAiChunkDelta value)?  $default,){
final _that = this;
switch (_that) {
case _OpenAiChunkDelta() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? content)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OpenAiChunkDelta() when $default != null:
return $default(_that.content);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? content)  $default,) {final _that = this;
switch (_that) {
case _OpenAiChunkDelta():
return $default(_that.content);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? content)?  $default,) {final _that = this;
switch (_that) {
case _OpenAiChunkDelta() when $default != null:
return $default(_that.content);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OpenAiChunkDelta implements OpenAiChunkDelta {
  const _OpenAiChunkDelta({this.content});
  factory _OpenAiChunkDelta.fromJson(Map<String, dynamic> json) => _$OpenAiChunkDeltaFromJson(json);

@override final  String? content;

/// Create a copy of OpenAiChunkDelta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpenAiChunkDeltaCopyWith<_OpenAiChunkDelta> get copyWith => __$OpenAiChunkDeltaCopyWithImpl<_OpenAiChunkDelta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OpenAiChunkDeltaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpenAiChunkDelta&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content);

@override
String toString() {
  return 'OpenAiChunkDelta(content: $content)';
}


}

/// @nodoc
abstract mixin class _$OpenAiChunkDeltaCopyWith<$Res> implements $OpenAiChunkDeltaCopyWith<$Res> {
  factory _$OpenAiChunkDeltaCopyWith(_OpenAiChunkDelta value, $Res Function(_OpenAiChunkDelta) _then) = __$OpenAiChunkDeltaCopyWithImpl;
@override @useResult
$Res call({
 String? content
});




}
/// @nodoc
class __$OpenAiChunkDeltaCopyWithImpl<$Res>
    implements _$OpenAiChunkDeltaCopyWith<$Res> {
  __$OpenAiChunkDeltaCopyWithImpl(this._self, this._then);

  final _OpenAiChunkDelta _self;
  final $Res Function(_OpenAiChunkDelta) _then;

/// Create a copy of OpenAiChunkDelta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? content = freezed,}) {
  return _then(_OpenAiChunkDelta(
content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
