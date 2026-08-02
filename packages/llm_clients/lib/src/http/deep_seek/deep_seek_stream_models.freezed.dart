// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deep_seek_stream_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeepSeekChatChunk {

 List<DeepSeekChunkChoice> get choices;
/// Create a copy of DeepSeekChatChunk
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeepSeekChatChunkCopyWith<DeepSeekChatChunk> get copyWith => _$DeepSeekChatChunkCopyWithImpl<DeepSeekChatChunk>(this as DeepSeekChatChunk, _$identity);

  /// Serializes this DeepSeekChatChunk to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeepSeekChatChunk&&const DeepCollectionEquality().equals(other.choices, choices));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(choices));

@override
String toString() {
  return 'DeepSeekChatChunk(choices: $choices)';
}


}

/// @nodoc
abstract mixin class $DeepSeekChatChunkCopyWith<$Res>  {
  factory $DeepSeekChatChunkCopyWith(DeepSeekChatChunk value, $Res Function(DeepSeekChatChunk) _then) = _$DeepSeekChatChunkCopyWithImpl;
@useResult
$Res call({
 List<DeepSeekChunkChoice> choices
});




}
/// @nodoc
class _$DeepSeekChatChunkCopyWithImpl<$Res>
    implements $DeepSeekChatChunkCopyWith<$Res> {
  _$DeepSeekChatChunkCopyWithImpl(this._self, this._then);

  final DeepSeekChatChunk _self;
  final $Res Function(DeepSeekChatChunk) _then;

/// Create a copy of DeepSeekChatChunk
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? choices = null,}) {
  return _then(_self.copyWith(
choices: null == choices ? _self.choices : choices // ignore: cast_nullable_to_non_nullable
as List<DeepSeekChunkChoice>,
  ));
}

}


/// Adds pattern-matching-related methods to [DeepSeekChatChunk].
extension DeepSeekChatChunkPatterns on DeepSeekChatChunk {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeepSeekChatChunk value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeepSeekChatChunk() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeepSeekChatChunk value)  $default,){
final _that = this;
switch (_that) {
case _DeepSeekChatChunk():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeepSeekChatChunk value)?  $default,){
final _that = this;
switch (_that) {
case _DeepSeekChatChunk() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<DeepSeekChunkChoice> choices)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeepSeekChatChunk() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<DeepSeekChunkChoice> choices)  $default,) {final _that = this;
switch (_that) {
case _DeepSeekChatChunk():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<DeepSeekChunkChoice> choices)?  $default,) {final _that = this;
switch (_that) {
case _DeepSeekChatChunk() when $default != null:
return $default(_that.choices);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeepSeekChatChunk implements DeepSeekChatChunk {
  const _DeepSeekChatChunk({final  List<DeepSeekChunkChoice> choices = const []}): _choices = choices;
  factory _DeepSeekChatChunk.fromJson(Map<String, dynamic> json) => _$DeepSeekChatChunkFromJson(json);

 final  List<DeepSeekChunkChoice> _choices;
@override@JsonKey() List<DeepSeekChunkChoice> get choices {
  if (_choices is EqualUnmodifiableListView) return _choices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_choices);
}


/// Create a copy of DeepSeekChatChunk
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeepSeekChatChunkCopyWith<_DeepSeekChatChunk> get copyWith => __$DeepSeekChatChunkCopyWithImpl<_DeepSeekChatChunk>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeepSeekChatChunkToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeepSeekChatChunk&&const DeepCollectionEquality().equals(other._choices, _choices));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_choices));

@override
String toString() {
  return 'DeepSeekChatChunk(choices: $choices)';
}


}

/// @nodoc
abstract mixin class _$DeepSeekChatChunkCopyWith<$Res> implements $DeepSeekChatChunkCopyWith<$Res> {
  factory _$DeepSeekChatChunkCopyWith(_DeepSeekChatChunk value, $Res Function(_DeepSeekChatChunk) _then) = __$DeepSeekChatChunkCopyWithImpl;
@override @useResult
$Res call({
 List<DeepSeekChunkChoice> choices
});




}
/// @nodoc
class __$DeepSeekChatChunkCopyWithImpl<$Res>
    implements _$DeepSeekChatChunkCopyWith<$Res> {
  __$DeepSeekChatChunkCopyWithImpl(this._self, this._then);

  final _DeepSeekChatChunk _self;
  final $Res Function(_DeepSeekChatChunk) _then;

/// Create a copy of DeepSeekChatChunk
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? choices = null,}) {
  return _then(_DeepSeekChatChunk(
choices: null == choices ? _self._choices : choices // ignore: cast_nullable_to_non_nullable
as List<DeepSeekChunkChoice>,
  ));
}


}


/// @nodoc
mixin _$DeepSeekChunkChoice {

 DeepSeekChunkDelta? get delta;
/// Create a copy of DeepSeekChunkChoice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeepSeekChunkChoiceCopyWith<DeepSeekChunkChoice> get copyWith => _$DeepSeekChunkChoiceCopyWithImpl<DeepSeekChunkChoice>(this as DeepSeekChunkChoice, _$identity);

  /// Serializes this DeepSeekChunkChoice to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeepSeekChunkChoice&&(identical(other.delta, delta) || other.delta == delta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,delta);

@override
String toString() {
  return 'DeepSeekChunkChoice(delta: $delta)';
}


}

/// @nodoc
abstract mixin class $DeepSeekChunkChoiceCopyWith<$Res>  {
  factory $DeepSeekChunkChoiceCopyWith(DeepSeekChunkChoice value, $Res Function(DeepSeekChunkChoice) _then) = _$DeepSeekChunkChoiceCopyWithImpl;
@useResult
$Res call({
 DeepSeekChunkDelta? delta
});


$DeepSeekChunkDeltaCopyWith<$Res>? get delta;

}
/// @nodoc
class _$DeepSeekChunkChoiceCopyWithImpl<$Res>
    implements $DeepSeekChunkChoiceCopyWith<$Res> {
  _$DeepSeekChunkChoiceCopyWithImpl(this._self, this._then);

  final DeepSeekChunkChoice _self;
  final $Res Function(DeepSeekChunkChoice) _then;

/// Create a copy of DeepSeekChunkChoice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? delta = freezed,}) {
  return _then(_self.copyWith(
delta: freezed == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as DeepSeekChunkDelta?,
  ));
}
/// Create a copy of DeepSeekChunkChoice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeepSeekChunkDeltaCopyWith<$Res>? get delta {
    if (_self.delta == null) {
    return null;
  }

  return $DeepSeekChunkDeltaCopyWith<$Res>(_self.delta!, (value) {
    return _then(_self.copyWith(delta: value));
  });
}
}


/// Adds pattern-matching-related methods to [DeepSeekChunkChoice].
extension DeepSeekChunkChoicePatterns on DeepSeekChunkChoice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeepSeekChunkChoice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeepSeekChunkChoice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeepSeekChunkChoice value)  $default,){
final _that = this;
switch (_that) {
case _DeepSeekChunkChoice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeepSeekChunkChoice value)?  $default,){
final _that = this;
switch (_that) {
case _DeepSeekChunkChoice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DeepSeekChunkDelta? delta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeepSeekChunkChoice() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DeepSeekChunkDelta? delta)  $default,) {final _that = this;
switch (_that) {
case _DeepSeekChunkChoice():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DeepSeekChunkDelta? delta)?  $default,) {final _that = this;
switch (_that) {
case _DeepSeekChunkChoice() when $default != null:
return $default(_that.delta);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeepSeekChunkChoice implements DeepSeekChunkChoice {
  const _DeepSeekChunkChoice({this.delta});
  factory _DeepSeekChunkChoice.fromJson(Map<String, dynamic> json) => _$DeepSeekChunkChoiceFromJson(json);

@override final  DeepSeekChunkDelta? delta;

/// Create a copy of DeepSeekChunkChoice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeepSeekChunkChoiceCopyWith<_DeepSeekChunkChoice> get copyWith => __$DeepSeekChunkChoiceCopyWithImpl<_DeepSeekChunkChoice>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeepSeekChunkChoiceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeepSeekChunkChoice&&(identical(other.delta, delta) || other.delta == delta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,delta);

@override
String toString() {
  return 'DeepSeekChunkChoice(delta: $delta)';
}


}

/// @nodoc
abstract mixin class _$DeepSeekChunkChoiceCopyWith<$Res> implements $DeepSeekChunkChoiceCopyWith<$Res> {
  factory _$DeepSeekChunkChoiceCopyWith(_DeepSeekChunkChoice value, $Res Function(_DeepSeekChunkChoice) _then) = __$DeepSeekChunkChoiceCopyWithImpl;
@override @useResult
$Res call({
 DeepSeekChunkDelta? delta
});


@override $DeepSeekChunkDeltaCopyWith<$Res>? get delta;

}
/// @nodoc
class __$DeepSeekChunkChoiceCopyWithImpl<$Res>
    implements _$DeepSeekChunkChoiceCopyWith<$Res> {
  __$DeepSeekChunkChoiceCopyWithImpl(this._self, this._then);

  final _DeepSeekChunkChoice _self;
  final $Res Function(_DeepSeekChunkChoice) _then;

/// Create a copy of DeepSeekChunkChoice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? delta = freezed,}) {
  return _then(_DeepSeekChunkChoice(
delta: freezed == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as DeepSeekChunkDelta?,
  ));
}

/// Create a copy of DeepSeekChunkChoice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeepSeekChunkDeltaCopyWith<$Res>? get delta {
    if (_self.delta == null) {
    return null;
  }

  return $DeepSeekChunkDeltaCopyWith<$Res>(_self.delta!, (value) {
    return _then(_self.copyWith(delta: value));
  });
}
}


/// @nodoc
mixin _$DeepSeekChunkDelta {

 String? get content;@JsonKey(name: 'reasoning_content') String? get reasoningContent;
/// Create a copy of DeepSeekChunkDelta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeepSeekChunkDeltaCopyWith<DeepSeekChunkDelta> get copyWith => _$DeepSeekChunkDeltaCopyWithImpl<DeepSeekChunkDelta>(this as DeepSeekChunkDelta, _$identity);

  /// Serializes this DeepSeekChunkDelta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeepSeekChunkDelta&&(identical(other.content, content) || other.content == content)&&(identical(other.reasoningContent, reasoningContent) || other.reasoningContent == reasoningContent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,reasoningContent);

@override
String toString() {
  return 'DeepSeekChunkDelta(content: $content, reasoningContent: $reasoningContent)';
}


}

/// @nodoc
abstract mixin class $DeepSeekChunkDeltaCopyWith<$Res>  {
  factory $DeepSeekChunkDeltaCopyWith(DeepSeekChunkDelta value, $Res Function(DeepSeekChunkDelta) _then) = _$DeepSeekChunkDeltaCopyWithImpl;
@useResult
$Res call({
 String? content,@JsonKey(name: 'reasoning_content') String? reasoningContent
});




}
/// @nodoc
class _$DeepSeekChunkDeltaCopyWithImpl<$Res>
    implements $DeepSeekChunkDeltaCopyWith<$Res> {
  _$DeepSeekChunkDeltaCopyWithImpl(this._self, this._then);

  final DeepSeekChunkDelta _self;
  final $Res Function(DeepSeekChunkDelta) _then;

/// Create a copy of DeepSeekChunkDelta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = freezed,Object? reasoningContent = freezed,}) {
  return _then(_self.copyWith(
content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,reasoningContent: freezed == reasoningContent ? _self.reasoningContent : reasoningContent // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DeepSeekChunkDelta].
extension DeepSeekChunkDeltaPatterns on DeepSeekChunkDelta {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeepSeekChunkDelta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeepSeekChunkDelta() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeepSeekChunkDelta value)  $default,){
final _that = this;
switch (_that) {
case _DeepSeekChunkDelta():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeepSeekChunkDelta value)?  $default,){
final _that = this;
switch (_that) {
case _DeepSeekChunkDelta() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? content, @JsonKey(name: 'reasoning_content')  String? reasoningContent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeepSeekChunkDelta() when $default != null:
return $default(_that.content,_that.reasoningContent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? content, @JsonKey(name: 'reasoning_content')  String? reasoningContent)  $default,) {final _that = this;
switch (_that) {
case _DeepSeekChunkDelta():
return $default(_that.content,_that.reasoningContent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? content, @JsonKey(name: 'reasoning_content')  String? reasoningContent)?  $default,) {final _that = this;
switch (_that) {
case _DeepSeekChunkDelta() when $default != null:
return $default(_that.content,_that.reasoningContent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeepSeekChunkDelta implements DeepSeekChunkDelta {
  const _DeepSeekChunkDelta({this.content, @JsonKey(name: 'reasoning_content') this.reasoningContent});
  factory _DeepSeekChunkDelta.fromJson(Map<String, dynamic> json) => _$DeepSeekChunkDeltaFromJson(json);

@override final  String? content;
@override@JsonKey(name: 'reasoning_content') final  String? reasoningContent;

/// Create a copy of DeepSeekChunkDelta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeepSeekChunkDeltaCopyWith<_DeepSeekChunkDelta> get copyWith => __$DeepSeekChunkDeltaCopyWithImpl<_DeepSeekChunkDelta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeepSeekChunkDeltaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeepSeekChunkDelta&&(identical(other.content, content) || other.content == content)&&(identical(other.reasoningContent, reasoningContent) || other.reasoningContent == reasoningContent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,reasoningContent);

@override
String toString() {
  return 'DeepSeekChunkDelta(content: $content, reasoningContent: $reasoningContent)';
}


}

/// @nodoc
abstract mixin class _$DeepSeekChunkDeltaCopyWith<$Res> implements $DeepSeekChunkDeltaCopyWith<$Res> {
  factory _$DeepSeekChunkDeltaCopyWith(_DeepSeekChunkDelta value, $Res Function(_DeepSeekChunkDelta) _then) = __$DeepSeekChunkDeltaCopyWithImpl;
@override @useResult
$Res call({
 String? content,@JsonKey(name: 'reasoning_content') String? reasoningContent
});




}
/// @nodoc
class __$DeepSeekChunkDeltaCopyWithImpl<$Res>
    implements _$DeepSeekChunkDeltaCopyWith<$Res> {
  __$DeepSeekChunkDeltaCopyWithImpl(this._self, this._then);

  final _DeepSeekChunkDelta _self;
  final $Res Function(_DeepSeekChunkDelta) _then;

/// Create a copy of DeepSeekChunkDelta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? content = freezed,Object? reasoningContent = freezed,}) {
  return _then(_DeepSeekChunkDelta(
content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,reasoningContent: freezed == reasoningContent ? _self.reasoningContent : reasoningContent // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
