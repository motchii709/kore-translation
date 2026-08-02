// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'open_ai_compatible_stream_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OpenAiCompatibleChatChunk {

 List<OpenAiCompatibleChunkChoice> get choices;
/// Create a copy of OpenAiCompatibleChatChunk
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenAiCompatibleChatChunkCopyWith<OpenAiCompatibleChatChunk> get copyWith => _$OpenAiCompatibleChatChunkCopyWithImpl<OpenAiCompatibleChatChunk>(this as OpenAiCompatibleChatChunk, _$identity);

  /// Serializes this OpenAiCompatibleChatChunk to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenAiCompatibleChatChunk&&const DeepCollectionEquality().equals(other.choices, choices));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(choices));

@override
String toString() {
  return 'OpenAiCompatibleChatChunk(choices: $choices)';
}


}

/// @nodoc
abstract mixin class $OpenAiCompatibleChatChunkCopyWith<$Res>  {
  factory $OpenAiCompatibleChatChunkCopyWith(OpenAiCompatibleChatChunk value, $Res Function(OpenAiCompatibleChatChunk) _then) = _$OpenAiCompatibleChatChunkCopyWithImpl;
@useResult
$Res call({
 List<OpenAiCompatibleChunkChoice> choices
});




}
/// @nodoc
class _$OpenAiCompatibleChatChunkCopyWithImpl<$Res>
    implements $OpenAiCompatibleChatChunkCopyWith<$Res> {
  _$OpenAiCompatibleChatChunkCopyWithImpl(this._self, this._then);

  final OpenAiCompatibleChatChunk _self;
  final $Res Function(OpenAiCompatibleChatChunk) _then;

/// Create a copy of OpenAiCompatibleChatChunk
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? choices = null,}) {
  return _then(_self.copyWith(
choices: null == choices ? _self.choices : choices // ignore: cast_nullable_to_non_nullable
as List<OpenAiCompatibleChunkChoice>,
  ));
}

}


/// Adds pattern-matching-related methods to [OpenAiCompatibleChatChunk].
extension OpenAiCompatibleChatChunkPatterns on OpenAiCompatibleChatChunk {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OpenAiCompatibleChatChunk value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OpenAiCompatibleChatChunk() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OpenAiCompatibleChatChunk value)  $default,){
final _that = this;
switch (_that) {
case _OpenAiCompatibleChatChunk():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OpenAiCompatibleChatChunk value)?  $default,){
final _that = this;
switch (_that) {
case _OpenAiCompatibleChatChunk() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<OpenAiCompatibleChunkChoice> choices)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OpenAiCompatibleChatChunk() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<OpenAiCompatibleChunkChoice> choices)  $default,) {final _that = this;
switch (_that) {
case _OpenAiCompatibleChatChunk():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<OpenAiCompatibleChunkChoice> choices)?  $default,) {final _that = this;
switch (_that) {
case _OpenAiCompatibleChatChunk() when $default != null:
return $default(_that.choices);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OpenAiCompatibleChatChunk implements OpenAiCompatibleChatChunk {
  const _OpenAiCompatibleChatChunk({final  List<OpenAiCompatibleChunkChoice> choices = const []}): _choices = choices;
  factory _OpenAiCompatibleChatChunk.fromJson(Map<String, dynamic> json) => _$OpenAiCompatibleChatChunkFromJson(json);

 final  List<OpenAiCompatibleChunkChoice> _choices;
@override@JsonKey() List<OpenAiCompatibleChunkChoice> get choices {
  if (_choices is EqualUnmodifiableListView) return _choices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_choices);
}


/// Create a copy of OpenAiCompatibleChatChunk
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpenAiCompatibleChatChunkCopyWith<_OpenAiCompatibleChatChunk> get copyWith => __$OpenAiCompatibleChatChunkCopyWithImpl<_OpenAiCompatibleChatChunk>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OpenAiCompatibleChatChunkToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpenAiCompatibleChatChunk&&const DeepCollectionEquality().equals(other._choices, _choices));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_choices));

@override
String toString() {
  return 'OpenAiCompatibleChatChunk(choices: $choices)';
}


}

/// @nodoc
abstract mixin class _$OpenAiCompatibleChatChunkCopyWith<$Res> implements $OpenAiCompatibleChatChunkCopyWith<$Res> {
  factory _$OpenAiCompatibleChatChunkCopyWith(_OpenAiCompatibleChatChunk value, $Res Function(_OpenAiCompatibleChatChunk) _then) = __$OpenAiCompatibleChatChunkCopyWithImpl;
@override @useResult
$Res call({
 List<OpenAiCompatibleChunkChoice> choices
});




}
/// @nodoc
class __$OpenAiCompatibleChatChunkCopyWithImpl<$Res>
    implements _$OpenAiCompatibleChatChunkCopyWith<$Res> {
  __$OpenAiCompatibleChatChunkCopyWithImpl(this._self, this._then);

  final _OpenAiCompatibleChatChunk _self;
  final $Res Function(_OpenAiCompatibleChatChunk) _then;

/// Create a copy of OpenAiCompatibleChatChunk
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? choices = null,}) {
  return _then(_OpenAiCompatibleChatChunk(
choices: null == choices ? _self._choices : choices // ignore: cast_nullable_to_non_nullable
as List<OpenAiCompatibleChunkChoice>,
  ));
}


}


/// @nodoc
mixin _$OpenAiCompatibleChunkChoice {

 OpenAiCompatibleChunkDelta? get delta;
/// Create a copy of OpenAiCompatibleChunkChoice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenAiCompatibleChunkChoiceCopyWith<OpenAiCompatibleChunkChoice> get copyWith => _$OpenAiCompatibleChunkChoiceCopyWithImpl<OpenAiCompatibleChunkChoice>(this as OpenAiCompatibleChunkChoice, _$identity);

  /// Serializes this OpenAiCompatibleChunkChoice to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenAiCompatibleChunkChoice&&(identical(other.delta, delta) || other.delta == delta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,delta);

@override
String toString() {
  return 'OpenAiCompatibleChunkChoice(delta: $delta)';
}


}

/// @nodoc
abstract mixin class $OpenAiCompatibleChunkChoiceCopyWith<$Res>  {
  factory $OpenAiCompatibleChunkChoiceCopyWith(OpenAiCompatibleChunkChoice value, $Res Function(OpenAiCompatibleChunkChoice) _then) = _$OpenAiCompatibleChunkChoiceCopyWithImpl;
@useResult
$Res call({
 OpenAiCompatibleChunkDelta? delta
});


$OpenAiCompatibleChunkDeltaCopyWith<$Res>? get delta;

}
/// @nodoc
class _$OpenAiCompatibleChunkChoiceCopyWithImpl<$Res>
    implements $OpenAiCompatibleChunkChoiceCopyWith<$Res> {
  _$OpenAiCompatibleChunkChoiceCopyWithImpl(this._self, this._then);

  final OpenAiCompatibleChunkChoice _self;
  final $Res Function(OpenAiCompatibleChunkChoice) _then;

/// Create a copy of OpenAiCompatibleChunkChoice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? delta = freezed,}) {
  return _then(_self.copyWith(
delta: freezed == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as OpenAiCompatibleChunkDelta?,
  ));
}
/// Create a copy of OpenAiCompatibleChunkChoice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OpenAiCompatibleChunkDeltaCopyWith<$Res>? get delta {
    if (_self.delta == null) {
    return null;
  }

  return $OpenAiCompatibleChunkDeltaCopyWith<$Res>(_self.delta!, (value) {
    return _then(_self.copyWith(delta: value));
  });
}
}


/// Adds pattern-matching-related methods to [OpenAiCompatibleChunkChoice].
extension OpenAiCompatibleChunkChoicePatterns on OpenAiCompatibleChunkChoice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OpenAiCompatibleChunkChoice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OpenAiCompatibleChunkChoice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OpenAiCompatibleChunkChoice value)  $default,){
final _that = this;
switch (_that) {
case _OpenAiCompatibleChunkChoice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OpenAiCompatibleChunkChoice value)?  $default,){
final _that = this;
switch (_that) {
case _OpenAiCompatibleChunkChoice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OpenAiCompatibleChunkDelta? delta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OpenAiCompatibleChunkChoice() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OpenAiCompatibleChunkDelta? delta)  $default,) {final _that = this;
switch (_that) {
case _OpenAiCompatibleChunkChoice():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OpenAiCompatibleChunkDelta? delta)?  $default,) {final _that = this;
switch (_that) {
case _OpenAiCompatibleChunkChoice() when $default != null:
return $default(_that.delta);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OpenAiCompatibleChunkChoice implements OpenAiCompatibleChunkChoice {
  const _OpenAiCompatibleChunkChoice({this.delta});
  factory _OpenAiCompatibleChunkChoice.fromJson(Map<String, dynamic> json) => _$OpenAiCompatibleChunkChoiceFromJson(json);

@override final  OpenAiCompatibleChunkDelta? delta;

/// Create a copy of OpenAiCompatibleChunkChoice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpenAiCompatibleChunkChoiceCopyWith<_OpenAiCompatibleChunkChoice> get copyWith => __$OpenAiCompatibleChunkChoiceCopyWithImpl<_OpenAiCompatibleChunkChoice>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OpenAiCompatibleChunkChoiceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpenAiCompatibleChunkChoice&&(identical(other.delta, delta) || other.delta == delta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,delta);

@override
String toString() {
  return 'OpenAiCompatibleChunkChoice(delta: $delta)';
}


}

/// @nodoc
abstract mixin class _$OpenAiCompatibleChunkChoiceCopyWith<$Res> implements $OpenAiCompatibleChunkChoiceCopyWith<$Res> {
  factory _$OpenAiCompatibleChunkChoiceCopyWith(_OpenAiCompatibleChunkChoice value, $Res Function(_OpenAiCompatibleChunkChoice) _then) = __$OpenAiCompatibleChunkChoiceCopyWithImpl;
@override @useResult
$Res call({
 OpenAiCompatibleChunkDelta? delta
});


@override $OpenAiCompatibleChunkDeltaCopyWith<$Res>? get delta;

}
/// @nodoc
class __$OpenAiCompatibleChunkChoiceCopyWithImpl<$Res>
    implements _$OpenAiCompatibleChunkChoiceCopyWith<$Res> {
  __$OpenAiCompatibleChunkChoiceCopyWithImpl(this._self, this._then);

  final _OpenAiCompatibleChunkChoice _self;
  final $Res Function(_OpenAiCompatibleChunkChoice) _then;

/// Create a copy of OpenAiCompatibleChunkChoice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? delta = freezed,}) {
  return _then(_OpenAiCompatibleChunkChoice(
delta: freezed == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as OpenAiCompatibleChunkDelta?,
  ));
}

/// Create a copy of OpenAiCompatibleChunkChoice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OpenAiCompatibleChunkDeltaCopyWith<$Res>? get delta {
    if (_self.delta == null) {
    return null;
  }

  return $OpenAiCompatibleChunkDeltaCopyWith<$Res>(_self.delta!, (value) {
    return _then(_self.copyWith(delta: value));
  });
}
}


/// @nodoc
mixin _$OpenAiCompatibleChunkDelta {

 String? get content;
/// Create a copy of OpenAiCompatibleChunkDelta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenAiCompatibleChunkDeltaCopyWith<OpenAiCompatibleChunkDelta> get copyWith => _$OpenAiCompatibleChunkDeltaCopyWithImpl<OpenAiCompatibleChunkDelta>(this as OpenAiCompatibleChunkDelta, _$identity);

  /// Serializes this OpenAiCompatibleChunkDelta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenAiCompatibleChunkDelta&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content);

@override
String toString() {
  return 'OpenAiCompatibleChunkDelta(content: $content)';
}


}

/// @nodoc
abstract mixin class $OpenAiCompatibleChunkDeltaCopyWith<$Res>  {
  factory $OpenAiCompatibleChunkDeltaCopyWith(OpenAiCompatibleChunkDelta value, $Res Function(OpenAiCompatibleChunkDelta) _then) = _$OpenAiCompatibleChunkDeltaCopyWithImpl;
@useResult
$Res call({
 String? content
});




}
/// @nodoc
class _$OpenAiCompatibleChunkDeltaCopyWithImpl<$Res>
    implements $OpenAiCompatibleChunkDeltaCopyWith<$Res> {
  _$OpenAiCompatibleChunkDeltaCopyWithImpl(this._self, this._then);

  final OpenAiCompatibleChunkDelta _self;
  final $Res Function(OpenAiCompatibleChunkDelta) _then;

/// Create a copy of OpenAiCompatibleChunkDelta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = freezed,}) {
  return _then(_self.copyWith(
content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OpenAiCompatibleChunkDelta].
extension OpenAiCompatibleChunkDeltaPatterns on OpenAiCompatibleChunkDelta {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OpenAiCompatibleChunkDelta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OpenAiCompatibleChunkDelta() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OpenAiCompatibleChunkDelta value)  $default,){
final _that = this;
switch (_that) {
case _OpenAiCompatibleChunkDelta():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OpenAiCompatibleChunkDelta value)?  $default,){
final _that = this;
switch (_that) {
case _OpenAiCompatibleChunkDelta() when $default != null:
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
case _OpenAiCompatibleChunkDelta() when $default != null:
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
case _OpenAiCompatibleChunkDelta():
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
case _OpenAiCompatibleChunkDelta() when $default != null:
return $default(_that.content);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OpenAiCompatibleChunkDelta implements OpenAiCompatibleChunkDelta {
  const _OpenAiCompatibleChunkDelta({this.content});
  factory _OpenAiCompatibleChunkDelta.fromJson(Map<String, dynamic> json) => _$OpenAiCompatibleChunkDeltaFromJson(json);

@override final  String? content;

/// Create a copy of OpenAiCompatibleChunkDelta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpenAiCompatibleChunkDeltaCopyWith<_OpenAiCompatibleChunkDelta> get copyWith => __$OpenAiCompatibleChunkDeltaCopyWithImpl<_OpenAiCompatibleChunkDelta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OpenAiCompatibleChunkDeltaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpenAiCompatibleChunkDelta&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content);

@override
String toString() {
  return 'OpenAiCompatibleChunkDelta(content: $content)';
}


}

/// @nodoc
abstract mixin class _$OpenAiCompatibleChunkDeltaCopyWith<$Res> implements $OpenAiCompatibleChunkDeltaCopyWith<$Res> {
  factory _$OpenAiCompatibleChunkDeltaCopyWith(_OpenAiCompatibleChunkDelta value, $Res Function(_OpenAiCompatibleChunkDelta) _then) = __$OpenAiCompatibleChunkDeltaCopyWithImpl;
@override @useResult
$Res call({
 String? content
});




}
/// @nodoc
class __$OpenAiCompatibleChunkDeltaCopyWithImpl<$Res>
    implements _$OpenAiCompatibleChunkDeltaCopyWith<$Res> {
  __$OpenAiCompatibleChunkDeltaCopyWithImpl(this._self, this._then);

  final _OpenAiCompatibleChunkDelta _self;
  final $Res Function(_OpenAiCompatibleChunkDelta) _then;

/// Create a copy of OpenAiCompatibleChunkDelta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? content = freezed,}) {
  return _then(_OpenAiCompatibleChunkDelta(
content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
