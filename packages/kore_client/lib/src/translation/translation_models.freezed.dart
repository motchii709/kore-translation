// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'translation_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TranslationCandidate {

 String? get text; String? get nuance;
/// Create a copy of TranslationCandidate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TranslationCandidateCopyWith<TranslationCandidate> get copyWith => _$TranslationCandidateCopyWithImpl<TranslationCandidate>(this as TranslationCandidate, _$identity);

  /// Serializes this TranslationCandidate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TranslationCandidate&&(identical(other.text, text) || other.text == text)&&(identical(other.nuance, nuance) || other.nuance == nuance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,nuance);

@override
String toString() {
  return 'TranslationCandidate(text: $text, nuance: $nuance)';
}


}

/// @nodoc
abstract mixin class $TranslationCandidateCopyWith<$Res>  {
  factory $TranslationCandidateCopyWith(TranslationCandidate value, $Res Function(TranslationCandidate) _then) = _$TranslationCandidateCopyWithImpl;
@useResult
$Res call({
 String? text, String? nuance
});




}
/// @nodoc
class _$TranslationCandidateCopyWithImpl<$Res>
    implements $TranslationCandidateCopyWith<$Res> {
  _$TranslationCandidateCopyWithImpl(this._self, this._then);

  final TranslationCandidate _self;
  final $Res Function(TranslationCandidate) _then;

/// Create a copy of TranslationCandidate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = freezed,Object? nuance = freezed,}) {
  return _then(_self.copyWith(
text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,nuance: freezed == nuance ? _self.nuance : nuance // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TranslationCandidate].
extension TranslationCandidatePatterns on TranslationCandidate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TranslationCandidate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TranslationCandidate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TranslationCandidate value)  $default,){
final _that = this;
switch (_that) {
case _TranslationCandidate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TranslationCandidate value)?  $default,){
final _that = this;
switch (_that) {
case _TranslationCandidate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? text,  String? nuance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TranslationCandidate() when $default != null:
return $default(_that.text,_that.nuance);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? text,  String? nuance)  $default,) {final _that = this;
switch (_that) {
case _TranslationCandidate():
return $default(_that.text,_that.nuance);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? text,  String? nuance)?  $default,) {final _that = this;
switch (_that) {
case _TranslationCandidate() when $default != null:
return $default(_that.text,_that.nuance);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TranslationCandidate implements TranslationCandidate {
  const _TranslationCandidate({this.text, this.nuance});
  factory _TranslationCandidate.fromJson(Map<String, dynamic> json) => _$TranslationCandidateFromJson(json);

@override final  String? text;
@override final  String? nuance;

/// Create a copy of TranslationCandidate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TranslationCandidateCopyWith<_TranslationCandidate> get copyWith => __$TranslationCandidateCopyWithImpl<_TranslationCandidate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TranslationCandidateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TranslationCandidate&&(identical(other.text, text) || other.text == text)&&(identical(other.nuance, nuance) || other.nuance == nuance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,nuance);

@override
String toString() {
  return 'TranslationCandidate(text: $text, nuance: $nuance)';
}


}

/// @nodoc
abstract mixin class _$TranslationCandidateCopyWith<$Res> implements $TranslationCandidateCopyWith<$Res> {
  factory _$TranslationCandidateCopyWith(_TranslationCandidate value, $Res Function(_TranslationCandidate) _then) = __$TranslationCandidateCopyWithImpl;
@override @useResult
$Res call({
 String? text, String? nuance
});




}
/// @nodoc
class __$TranslationCandidateCopyWithImpl<$Res>
    implements _$TranslationCandidateCopyWith<$Res> {
  __$TranslationCandidateCopyWithImpl(this._self, this._then);

  final _TranslationCandidate _self;
  final $Res Function(_TranslationCandidate) _then;

/// Create a copy of TranslationCandidate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = freezed,Object? nuance = freezed,}) {
  return _then(_TranslationCandidate(
text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,nuance: freezed == nuance ? _self.nuance : nuance // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$TranslationEvent {

/// The source text of the request this event belongs to, so consumers
/// can keep showing it after the input moved on.
 String? get sourceText; String? get thinking; TranslationResult? get result;
/// Create a copy of TranslationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TranslationEventCopyWith<TranslationEvent> get copyWith => _$TranslationEventCopyWithImpl<TranslationEvent>(this as TranslationEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TranslationEvent&&(identical(other.sourceText, sourceText) || other.sourceText == sourceText)&&(identical(other.thinking, thinking) || other.thinking == thinking)&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,sourceText,thinking,result);

@override
String toString() {
  return 'TranslationEvent(sourceText: $sourceText, thinking: $thinking, result: $result)';
}


}

/// @nodoc
abstract mixin class $TranslationEventCopyWith<$Res>  {
  factory $TranslationEventCopyWith(TranslationEvent value, $Res Function(TranslationEvent) _then) = _$TranslationEventCopyWithImpl;
@useResult
$Res call({
 String? sourceText, String? thinking, TranslationResult? result
});


$TranslationResultCopyWith<$Res>? get result;

}
/// @nodoc
class _$TranslationEventCopyWithImpl<$Res>
    implements $TranslationEventCopyWith<$Res> {
  _$TranslationEventCopyWithImpl(this._self, this._then);

  final TranslationEvent _self;
  final $Res Function(TranslationEvent) _then;

/// Create a copy of TranslationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sourceText = freezed,Object? thinking = freezed,Object? result = freezed,}) {
  return _then(_self.copyWith(
sourceText: freezed == sourceText ? _self.sourceText : sourceText // ignore: cast_nullable_to_non_nullable
as String?,thinking: freezed == thinking ? _self.thinking : thinking // ignore: cast_nullable_to_non_nullable
as String?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as TranslationResult?,
  ));
}
/// Create a copy of TranslationEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TranslationResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $TranslationResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}


/// Adds pattern-matching-related methods to [TranslationEvent].
extension TranslationEventPatterns on TranslationEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TranslationEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TranslationEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TranslationEvent value)  $default,){
final _that = this;
switch (_that) {
case _TranslationEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TranslationEvent value)?  $default,){
final _that = this;
switch (_that) {
case _TranslationEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? sourceText,  String? thinking,  TranslationResult? result)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TranslationEvent() when $default != null:
return $default(_that.sourceText,_that.thinking,_that.result);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? sourceText,  String? thinking,  TranslationResult? result)  $default,) {final _that = this;
switch (_that) {
case _TranslationEvent():
return $default(_that.sourceText,_that.thinking,_that.result);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? sourceText,  String? thinking,  TranslationResult? result)?  $default,) {final _that = this;
switch (_that) {
case _TranslationEvent() when $default != null:
return $default(_that.sourceText,_that.thinking,_that.result);case _:
  return null;

}
}

}

/// @nodoc


class _TranslationEvent implements TranslationEvent {
  const _TranslationEvent({this.sourceText, this.thinking, this.result});
  

/// The source text of the request this event belongs to, so consumers
/// can keep showing it after the input moved on.
@override final  String? sourceText;
@override final  String? thinking;
@override final  TranslationResult? result;

/// Create a copy of TranslationEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TranslationEventCopyWith<_TranslationEvent> get copyWith => __$TranslationEventCopyWithImpl<_TranslationEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TranslationEvent&&(identical(other.sourceText, sourceText) || other.sourceText == sourceText)&&(identical(other.thinking, thinking) || other.thinking == thinking)&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,sourceText,thinking,result);

@override
String toString() {
  return 'TranslationEvent(sourceText: $sourceText, thinking: $thinking, result: $result)';
}


}

/// @nodoc
abstract mixin class _$TranslationEventCopyWith<$Res> implements $TranslationEventCopyWith<$Res> {
  factory _$TranslationEventCopyWith(_TranslationEvent value, $Res Function(_TranslationEvent) _then) = __$TranslationEventCopyWithImpl;
@override @useResult
$Res call({
 String? sourceText, String? thinking, TranslationResult? result
});


@override $TranslationResultCopyWith<$Res>? get result;

}
/// @nodoc
class __$TranslationEventCopyWithImpl<$Res>
    implements _$TranslationEventCopyWith<$Res> {
  __$TranslationEventCopyWithImpl(this._self, this._then);

  final _TranslationEvent _self;
  final $Res Function(_TranslationEvent) _then;

/// Create a copy of TranslationEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sourceText = freezed,Object? thinking = freezed,Object? result = freezed,}) {
  return _then(_TranslationEvent(
sourceText: freezed == sourceText ? _self.sourceText : sourceText // ignore: cast_nullable_to_non_nullable
as String?,thinking: freezed == thinking ? _self.thinking : thinking // ignore: cast_nullable_to_non_nullable
as String?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as TranslationResult?,
  ));
}

/// Create a copy of TranslationEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TranslationResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $TranslationResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}


/// @nodoc
mixin _$TranslationResult {

 String? get translation;@JsonKey(name: 'detected_language') String? get detectedLanguage;/// The language the model translated into — its own decision whenever
/// the request leaves the choice to it (language pairing).
@JsonKey(name: 'target_language') String? get targetLanguage; String? get explanation;/// Correction notes from a proofread request. Its presence is what marks
/// a result as a proofread — translations carry [explanation] instead.
 String? get proofread; List<TranslationCandidate>? get alternatives;
/// Create a copy of TranslationResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TranslationResultCopyWith<TranslationResult> get copyWith => _$TranslationResultCopyWithImpl<TranslationResult>(this as TranslationResult, _$identity);

  /// Serializes this TranslationResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TranslationResult&&(identical(other.translation, translation) || other.translation == translation)&&(identical(other.detectedLanguage, detectedLanguage) || other.detectedLanguage == detectedLanguage)&&(identical(other.targetLanguage, targetLanguage) || other.targetLanguage == targetLanguage)&&(identical(other.explanation, explanation) || other.explanation == explanation)&&(identical(other.proofread, proofread) || other.proofread == proofread)&&const DeepCollectionEquality().equals(other.alternatives, alternatives));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,translation,detectedLanguage,targetLanguage,explanation,proofread,const DeepCollectionEquality().hash(alternatives));

@override
String toString() {
  return 'TranslationResult(translation: $translation, detectedLanguage: $detectedLanguage, targetLanguage: $targetLanguage, explanation: $explanation, proofread: $proofread, alternatives: $alternatives)';
}


}

/// @nodoc
abstract mixin class $TranslationResultCopyWith<$Res>  {
  factory $TranslationResultCopyWith(TranslationResult value, $Res Function(TranslationResult) _then) = _$TranslationResultCopyWithImpl;
@useResult
$Res call({
 String? translation,@JsonKey(name: 'detected_language') String? detectedLanguage,@JsonKey(name: 'target_language') String? targetLanguage, String? explanation, String? proofread, List<TranslationCandidate>? alternatives
});




}
/// @nodoc
class _$TranslationResultCopyWithImpl<$Res>
    implements $TranslationResultCopyWith<$Res> {
  _$TranslationResultCopyWithImpl(this._self, this._then);

  final TranslationResult _self;
  final $Res Function(TranslationResult) _then;

/// Create a copy of TranslationResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? translation = freezed,Object? detectedLanguage = freezed,Object? targetLanguage = freezed,Object? explanation = freezed,Object? proofread = freezed,Object? alternatives = freezed,}) {
  return _then(_self.copyWith(
translation: freezed == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as String?,detectedLanguage: freezed == detectedLanguage ? _self.detectedLanguage : detectedLanguage // ignore: cast_nullable_to_non_nullable
as String?,targetLanguage: freezed == targetLanguage ? _self.targetLanguage : targetLanguage // ignore: cast_nullable_to_non_nullable
as String?,explanation: freezed == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String?,proofread: freezed == proofread ? _self.proofread : proofread // ignore: cast_nullable_to_non_nullable
as String?,alternatives: freezed == alternatives ? _self.alternatives : alternatives // ignore: cast_nullable_to_non_nullable
as List<TranslationCandidate>?,
  ));
}

}


/// Adds pattern-matching-related methods to [TranslationResult].
extension TranslationResultPatterns on TranslationResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TranslationResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TranslationResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TranslationResult value)  $default,){
final _that = this;
switch (_that) {
case _TranslationResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TranslationResult value)?  $default,){
final _that = this;
switch (_that) {
case _TranslationResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? translation, @JsonKey(name: 'detected_language')  String? detectedLanguage, @JsonKey(name: 'target_language')  String? targetLanguage,  String? explanation,  String? proofread,  List<TranslationCandidate>? alternatives)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TranslationResult() when $default != null:
return $default(_that.translation,_that.detectedLanguage,_that.targetLanguage,_that.explanation,_that.proofread,_that.alternatives);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? translation, @JsonKey(name: 'detected_language')  String? detectedLanguage, @JsonKey(name: 'target_language')  String? targetLanguage,  String? explanation,  String? proofread,  List<TranslationCandidate>? alternatives)  $default,) {final _that = this;
switch (_that) {
case _TranslationResult():
return $default(_that.translation,_that.detectedLanguage,_that.targetLanguage,_that.explanation,_that.proofread,_that.alternatives);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? translation, @JsonKey(name: 'detected_language')  String? detectedLanguage, @JsonKey(name: 'target_language')  String? targetLanguage,  String? explanation,  String? proofread,  List<TranslationCandidate>? alternatives)?  $default,) {final _that = this;
switch (_that) {
case _TranslationResult() when $default != null:
return $default(_that.translation,_that.detectedLanguage,_that.targetLanguage,_that.explanation,_that.proofread,_that.alternatives);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TranslationResult implements TranslationResult {
  const _TranslationResult({this.translation, @JsonKey(name: 'detected_language') this.detectedLanguage, @JsonKey(name: 'target_language') this.targetLanguage, this.explanation, this.proofread, final  List<TranslationCandidate>? alternatives}): _alternatives = alternatives;
  factory _TranslationResult.fromJson(Map<String, dynamic> json) => _$TranslationResultFromJson(json);

@override final  String? translation;
@override@JsonKey(name: 'detected_language') final  String? detectedLanguage;
/// The language the model translated into — its own decision whenever
/// the request leaves the choice to it (language pairing).
@override@JsonKey(name: 'target_language') final  String? targetLanguage;
@override final  String? explanation;
/// Correction notes from a proofread request. Its presence is what marks
/// a result as a proofread — translations carry [explanation] instead.
@override final  String? proofread;
 final  List<TranslationCandidate>? _alternatives;
@override List<TranslationCandidate>? get alternatives {
  final value = _alternatives;
  if (value == null) return null;
  if (_alternatives is EqualUnmodifiableListView) return _alternatives;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of TranslationResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TranslationResultCopyWith<_TranslationResult> get copyWith => __$TranslationResultCopyWithImpl<_TranslationResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TranslationResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TranslationResult&&(identical(other.translation, translation) || other.translation == translation)&&(identical(other.detectedLanguage, detectedLanguage) || other.detectedLanguage == detectedLanguage)&&(identical(other.targetLanguage, targetLanguage) || other.targetLanguage == targetLanguage)&&(identical(other.explanation, explanation) || other.explanation == explanation)&&(identical(other.proofread, proofread) || other.proofread == proofread)&&const DeepCollectionEquality().equals(other._alternatives, _alternatives));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,translation,detectedLanguage,targetLanguage,explanation,proofread,const DeepCollectionEquality().hash(_alternatives));

@override
String toString() {
  return 'TranslationResult(translation: $translation, detectedLanguage: $detectedLanguage, targetLanguage: $targetLanguage, explanation: $explanation, proofread: $proofread, alternatives: $alternatives)';
}


}

/// @nodoc
abstract mixin class _$TranslationResultCopyWith<$Res> implements $TranslationResultCopyWith<$Res> {
  factory _$TranslationResultCopyWith(_TranslationResult value, $Res Function(_TranslationResult) _then) = __$TranslationResultCopyWithImpl;
@override @useResult
$Res call({
 String? translation,@JsonKey(name: 'detected_language') String? detectedLanguage,@JsonKey(name: 'target_language') String? targetLanguage, String? explanation, String? proofread, List<TranslationCandidate>? alternatives
});




}
/// @nodoc
class __$TranslationResultCopyWithImpl<$Res>
    implements _$TranslationResultCopyWith<$Res> {
  __$TranslationResultCopyWithImpl(this._self, this._then);

  final _TranslationResult _self;
  final $Res Function(_TranslationResult) _then;

/// Create a copy of TranslationResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? translation = freezed,Object? detectedLanguage = freezed,Object? targetLanguage = freezed,Object? explanation = freezed,Object? proofread = freezed,Object? alternatives = freezed,}) {
  return _then(_TranslationResult(
translation: freezed == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as String?,detectedLanguage: freezed == detectedLanguage ? _self.detectedLanguage : detectedLanguage // ignore: cast_nullable_to_non_nullable
as String?,targetLanguage: freezed == targetLanguage ? _self.targetLanguage : targetLanguage // ignore: cast_nullable_to_non_nullable
as String?,explanation: freezed == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String?,proofread: freezed == proofread ? _self.proofread : proofread // ignore: cast_nullable_to_non_nullable
as String?,alternatives: freezed == alternatives ? _self._alternatives : alternatives // ignore: cast_nullable_to_non_nullable
as List<TranslationCandidate>?,
  ));
}


}

// dart format on
