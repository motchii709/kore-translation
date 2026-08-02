// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gemini_stream_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GeminiStreamChunk {

 List<GeminiCandidate> get candidates;
/// Create a copy of GeminiStreamChunk
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeminiStreamChunkCopyWith<GeminiStreamChunk> get copyWith => _$GeminiStreamChunkCopyWithImpl<GeminiStreamChunk>(this as GeminiStreamChunk, _$identity);

  /// Serializes this GeminiStreamChunk to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeminiStreamChunk&&const DeepCollectionEquality().equals(other.candidates, candidates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(candidates));

@override
String toString() {
  return 'GeminiStreamChunk(candidates: $candidates)';
}


}

/// @nodoc
abstract mixin class $GeminiStreamChunkCopyWith<$Res>  {
  factory $GeminiStreamChunkCopyWith(GeminiStreamChunk value, $Res Function(GeminiStreamChunk) _then) = _$GeminiStreamChunkCopyWithImpl;
@useResult
$Res call({
 List<GeminiCandidate> candidates
});




}
/// @nodoc
class _$GeminiStreamChunkCopyWithImpl<$Res>
    implements $GeminiStreamChunkCopyWith<$Res> {
  _$GeminiStreamChunkCopyWithImpl(this._self, this._then);

  final GeminiStreamChunk _self;
  final $Res Function(GeminiStreamChunk) _then;

/// Create a copy of GeminiStreamChunk
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? candidates = null,}) {
  return _then(_self.copyWith(
candidates: null == candidates ? _self.candidates : candidates // ignore: cast_nullable_to_non_nullable
as List<GeminiCandidate>,
  ));
}

}


/// Adds pattern-matching-related methods to [GeminiStreamChunk].
extension GeminiStreamChunkPatterns on GeminiStreamChunk {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GeminiStreamChunk value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GeminiStreamChunk() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GeminiStreamChunk value)  $default,){
final _that = this;
switch (_that) {
case _GeminiStreamChunk():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GeminiStreamChunk value)?  $default,){
final _that = this;
switch (_that) {
case _GeminiStreamChunk() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<GeminiCandidate> candidates)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GeminiStreamChunk() when $default != null:
return $default(_that.candidates);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<GeminiCandidate> candidates)  $default,) {final _that = this;
switch (_that) {
case _GeminiStreamChunk():
return $default(_that.candidates);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<GeminiCandidate> candidates)?  $default,) {final _that = this;
switch (_that) {
case _GeminiStreamChunk() when $default != null:
return $default(_that.candidates);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GeminiStreamChunk implements GeminiStreamChunk {
  const _GeminiStreamChunk({final  List<GeminiCandidate> candidates = const []}): _candidates = candidates;
  factory _GeminiStreamChunk.fromJson(Map<String, dynamic> json) => _$GeminiStreamChunkFromJson(json);

 final  List<GeminiCandidate> _candidates;
@override@JsonKey() List<GeminiCandidate> get candidates {
  if (_candidates is EqualUnmodifiableListView) return _candidates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_candidates);
}


/// Create a copy of GeminiStreamChunk
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeminiStreamChunkCopyWith<_GeminiStreamChunk> get copyWith => __$GeminiStreamChunkCopyWithImpl<_GeminiStreamChunk>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GeminiStreamChunkToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeminiStreamChunk&&const DeepCollectionEquality().equals(other._candidates, _candidates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_candidates));

@override
String toString() {
  return 'GeminiStreamChunk(candidates: $candidates)';
}


}

/// @nodoc
abstract mixin class _$GeminiStreamChunkCopyWith<$Res> implements $GeminiStreamChunkCopyWith<$Res> {
  factory _$GeminiStreamChunkCopyWith(_GeminiStreamChunk value, $Res Function(_GeminiStreamChunk) _then) = __$GeminiStreamChunkCopyWithImpl;
@override @useResult
$Res call({
 List<GeminiCandidate> candidates
});




}
/// @nodoc
class __$GeminiStreamChunkCopyWithImpl<$Res>
    implements _$GeminiStreamChunkCopyWith<$Res> {
  __$GeminiStreamChunkCopyWithImpl(this._self, this._then);

  final _GeminiStreamChunk _self;
  final $Res Function(_GeminiStreamChunk) _then;

/// Create a copy of GeminiStreamChunk
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? candidates = null,}) {
  return _then(_GeminiStreamChunk(
candidates: null == candidates ? _self._candidates : candidates // ignore: cast_nullable_to_non_nullable
as List<GeminiCandidate>,
  ));
}


}


/// @nodoc
mixin _$GeminiCandidate {

 GeminiContent? get content;
/// Create a copy of GeminiCandidate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeminiCandidateCopyWith<GeminiCandidate> get copyWith => _$GeminiCandidateCopyWithImpl<GeminiCandidate>(this as GeminiCandidate, _$identity);

  /// Serializes this GeminiCandidate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeminiCandidate&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content);

@override
String toString() {
  return 'GeminiCandidate(content: $content)';
}


}

/// @nodoc
abstract mixin class $GeminiCandidateCopyWith<$Res>  {
  factory $GeminiCandidateCopyWith(GeminiCandidate value, $Res Function(GeminiCandidate) _then) = _$GeminiCandidateCopyWithImpl;
@useResult
$Res call({
 GeminiContent? content
});


$GeminiContentCopyWith<$Res>? get content;

}
/// @nodoc
class _$GeminiCandidateCopyWithImpl<$Res>
    implements $GeminiCandidateCopyWith<$Res> {
  _$GeminiCandidateCopyWithImpl(this._self, this._then);

  final GeminiCandidate _self;
  final $Res Function(GeminiCandidate) _then;

/// Create a copy of GeminiCandidate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = freezed,}) {
  return _then(_self.copyWith(
content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as GeminiContent?,
  ));
}
/// Create a copy of GeminiCandidate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeminiContentCopyWith<$Res>? get content {
    if (_self.content == null) {
    return null;
  }

  return $GeminiContentCopyWith<$Res>(_self.content!, (value) {
    return _then(_self.copyWith(content: value));
  });
}
}


/// Adds pattern-matching-related methods to [GeminiCandidate].
extension GeminiCandidatePatterns on GeminiCandidate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GeminiCandidate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GeminiCandidate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GeminiCandidate value)  $default,){
final _that = this;
switch (_that) {
case _GeminiCandidate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GeminiCandidate value)?  $default,){
final _that = this;
switch (_that) {
case _GeminiCandidate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( GeminiContent? content)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GeminiCandidate() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( GeminiContent? content)  $default,) {final _that = this;
switch (_that) {
case _GeminiCandidate():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( GeminiContent? content)?  $default,) {final _that = this;
switch (_that) {
case _GeminiCandidate() when $default != null:
return $default(_that.content);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GeminiCandidate implements GeminiCandidate {
  const _GeminiCandidate({this.content});
  factory _GeminiCandidate.fromJson(Map<String, dynamic> json) => _$GeminiCandidateFromJson(json);

@override final  GeminiContent? content;

/// Create a copy of GeminiCandidate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeminiCandidateCopyWith<_GeminiCandidate> get copyWith => __$GeminiCandidateCopyWithImpl<_GeminiCandidate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GeminiCandidateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeminiCandidate&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content);

@override
String toString() {
  return 'GeminiCandidate(content: $content)';
}


}

/// @nodoc
abstract mixin class _$GeminiCandidateCopyWith<$Res> implements $GeminiCandidateCopyWith<$Res> {
  factory _$GeminiCandidateCopyWith(_GeminiCandidate value, $Res Function(_GeminiCandidate) _then) = __$GeminiCandidateCopyWithImpl;
@override @useResult
$Res call({
 GeminiContent? content
});


@override $GeminiContentCopyWith<$Res>? get content;

}
/// @nodoc
class __$GeminiCandidateCopyWithImpl<$Res>
    implements _$GeminiCandidateCopyWith<$Res> {
  __$GeminiCandidateCopyWithImpl(this._self, this._then);

  final _GeminiCandidate _self;
  final $Res Function(_GeminiCandidate) _then;

/// Create a copy of GeminiCandidate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? content = freezed,}) {
  return _then(_GeminiCandidate(
content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as GeminiContent?,
  ));
}

/// Create a copy of GeminiCandidate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeminiContentCopyWith<$Res>? get content {
    if (_self.content == null) {
    return null;
  }

  return $GeminiContentCopyWith<$Res>(_self.content!, (value) {
    return _then(_self.copyWith(content: value));
  });
}
}


/// @nodoc
mixin _$GeminiContent {

 List<GeminiPart> get parts;
/// Create a copy of GeminiContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeminiContentCopyWith<GeminiContent> get copyWith => _$GeminiContentCopyWithImpl<GeminiContent>(this as GeminiContent, _$identity);

  /// Serializes this GeminiContent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeminiContent&&const DeepCollectionEquality().equals(other.parts, parts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(parts));

@override
String toString() {
  return 'GeminiContent(parts: $parts)';
}


}

/// @nodoc
abstract mixin class $GeminiContentCopyWith<$Res>  {
  factory $GeminiContentCopyWith(GeminiContent value, $Res Function(GeminiContent) _then) = _$GeminiContentCopyWithImpl;
@useResult
$Res call({
 List<GeminiPart> parts
});




}
/// @nodoc
class _$GeminiContentCopyWithImpl<$Res>
    implements $GeminiContentCopyWith<$Res> {
  _$GeminiContentCopyWithImpl(this._self, this._then);

  final GeminiContent _self;
  final $Res Function(GeminiContent) _then;

/// Create a copy of GeminiContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? parts = null,}) {
  return _then(_self.copyWith(
parts: null == parts ? _self.parts : parts // ignore: cast_nullable_to_non_nullable
as List<GeminiPart>,
  ));
}

}


/// Adds pattern-matching-related methods to [GeminiContent].
extension GeminiContentPatterns on GeminiContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GeminiContent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GeminiContent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GeminiContent value)  $default,){
final _that = this;
switch (_that) {
case _GeminiContent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GeminiContent value)?  $default,){
final _that = this;
switch (_that) {
case _GeminiContent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<GeminiPart> parts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GeminiContent() when $default != null:
return $default(_that.parts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<GeminiPart> parts)  $default,) {final _that = this;
switch (_that) {
case _GeminiContent():
return $default(_that.parts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<GeminiPart> parts)?  $default,) {final _that = this;
switch (_that) {
case _GeminiContent() when $default != null:
return $default(_that.parts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GeminiContent implements GeminiContent {
  const _GeminiContent({final  List<GeminiPart> parts = const []}): _parts = parts;
  factory _GeminiContent.fromJson(Map<String, dynamic> json) => _$GeminiContentFromJson(json);

 final  List<GeminiPart> _parts;
@override@JsonKey() List<GeminiPart> get parts {
  if (_parts is EqualUnmodifiableListView) return _parts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_parts);
}


/// Create a copy of GeminiContent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeminiContentCopyWith<_GeminiContent> get copyWith => __$GeminiContentCopyWithImpl<_GeminiContent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GeminiContentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeminiContent&&const DeepCollectionEquality().equals(other._parts, _parts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_parts));

@override
String toString() {
  return 'GeminiContent(parts: $parts)';
}


}

/// @nodoc
abstract mixin class _$GeminiContentCopyWith<$Res> implements $GeminiContentCopyWith<$Res> {
  factory _$GeminiContentCopyWith(_GeminiContent value, $Res Function(_GeminiContent) _then) = __$GeminiContentCopyWithImpl;
@override @useResult
$Res call({
 List<GeminiPart> parts
});




}
/// @nodoc
class __$GeminiContentCopyWithImpl<$Res>
    implements _$GeminiContentCopyWith<$Res> {
  __$GeminiContentCopyWithImpl(this._self, this._then);

  final _GeminiContent _self;
  final $Res Function(_GeminiContent) _then;

/// Create a copy of GeminiContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? parts = null,}) {
  return _then(_GeminiContent(
parts: null == parts ? _self._parts : parts // ignore: cast_nullable_to_non_nullable
as List<GeminiPart>,
  ));
}


}


/// @nodoc
mixin _$GeminiPart {

 String? get text; bool get thought;
/// Create a copy of GeminiPart
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeminiPartCopyWith<GeminiPart> get copyWith => _$GeminiPartCopyWithImpl<GeminiPart>(this as GeminiPart, _$identity);

  /// Serializes this GeminiPart to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeminiPart&&(identical(other.text, text) || other.text == text)&&(identical(other.thought, thought) || other.thought == thought));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,thought);

@override
String toString() {
  return 'GeminiPart(text: $text, thought: $thought)';
}


}

/// @nodoc
abstract mixin class $GeminiPartCopyWith<$Res>  {
  factory $GeminiPartCopyWith(GeminiPart value, $Res Function(GeminiPart) _then) = _$GeminiPartCopyWithImpl;
@useResult
$Res call({
 String? text, bool thought
});




}
/// @nodoc
class _$GeminiPartCopyWithImpl<$Res>
    implements $GeminiPartCopyWith<$Res> {
  _$GeminiPartCopyWithImpl(this._self, this._then);

  final GeminiPart _self;
  final $Res Function(GeminiPart) _then;

/// Create a copy of GeminiPart
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = freezed,Object? thought = null,}) {
  return _then(_self.copyWith(
text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,thought: null == thought ? _self.thought : thought // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [GeminiPart].
extension GeminiPartPatterns on GeminiPart {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GeminiPart value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GeminiPart() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GeminiPart value)  $default,){
final _that = this;
switch (_that) {
case _GeminiPart():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GeminiPart value)?  $default,){
final _that = this;
switch (_that) {
case _GeminiPart() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? text,  bool thought)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GeminiPart() when $default != null:
return $default(_that.text,_that.thought);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? text,  bool thought)  $default,) {final _that = this;
switch (_that) {
case _GeminiPart():
return $default(_that.text,_that.thought);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? text,  bool thought)?  $default,) {final _that = this;
switch (_that) {
case _GeminiPart() when $default != null:
return $default(_that.text,_that.thought);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GeminiPart implements GeminiPart {
  const _GeminiPart({this.text, this.thought = false});
  factory _GeminiPart.fromJson(Map<String, dynamic> json) => _$GeminiPartFromJson(json);

@override final  String? text;
@override@JsonKey() final  bool thought;

/// Create a copy of GeminiPart
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeminiPartCopyWith<_GeminiPart> get copyWith => __$GeminiPartCopyWithImpl<_GeminiPart>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GeminiPartToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeminiPart&&(identical(other.text, text) || other.text == text)&&(identical(other.thought, thought) || other.thought == thought));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,thought);

@override
String toString() {
  return 'GeminiPart(text: $text, thought: $thought)';
}


}

/// @nodoc
abstract mixin class _$GeminiPartCopyWith<$Res> implements $GeminiPartCopyWith<$Res> {
  factory _$GeminiPartCopyWith(_GeminiPart value, $Res Function(_GeminiPart) _then) = __$GeminiPartCopyWithImpl;
@override @useResult
$Res call({
 String? text, bool thought
});




}
/// @nodoc
class __$GeminiPartCopyWithImpl<$Res>
    implements _$GeminiPartCopyWith<$Res> {
  __$GeminiPartCopyWithImpl(this._self, this._then);

  final _GeminiPart _self;
  final $Res Function(_GeminiPart) _then;

/// Create a copy of GeminiPart
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = freezed,Object? thought = null,}) {
  return _then(_GeminiPart(
text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,thought: null == thought ? _self.thought : thought // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
