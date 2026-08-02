// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'codex_stream_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CodexTurnEvent {

 String get delta;
/// Create a copy of CodexTurnEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CodexTurnEventCopyWith<CodexTurnEvent> get copyWith => _$CodexTurnEventCopyWithImpl<CodexTurnEvent>(this as CodexTurnEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CodexTurnEvent&&(identical(other.delta, delta) || other.delta == delta));
}


@override
int get hashCode => Object.hash(runtimeType,delta);

@override
String toString() {
  return 'CodexTurnEvent(delta: $delta)';
}


}

/// @nodoc
abstract mixin class $CodexTurnEventCopyWith<$Res>  {
  factory $CodexTurnEventCopyWith(CodexTurnEvent value, $Res Function(CodexTurnEvent) _then) = _$CodexTurnEventCopyWithImpl;
@useResult
$Res call({
 String delta
});




}
/// @nodoc
class _$CodexTurnEventCopyWithImpl<$Res>
    implements $CodexTurnEventCopyWith<$Res> {
  _$CodexTurnEventCopyWithImpl(this._self, this._then);

  final CodexTurnEvent _self;
  final $Res Function(CodexTurnEvent) _then;

/// Create a copy of CodexTurnEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? delta = null,}) {
  return _then(_self.copyWith(
delta: null == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CodexTurnEvent].
extension CodexTurnEventPatterns on CodexTurnEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CodexAgentMessageDelta value)?  agentMessageDelta,TResult Function( CodexReasoningSummaryTextDelta value)?  reasoningSummaryTextDelta,TResult Function( CodexReasoningTextDelta value)?  reasoningTextDelta,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CodexAgentMessageDelta() when agentMessageDelta != null:
return agentMessageDelta(_that);case CodexReasoningSummaryTextDelta() when reasoningSummaryTextDelta != null:
return reasoningSummaryTextDelta(_that);case CodexReasoningTextDelta() when reasoningTextDelta != null:
return reasoningTextDelta(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CodexAgentMessageDelta value)  agentMessageDelta,required TResult Function( CodexReasoningSummaryTextDelta value)  reasoningSummaryTextDelta,required TResult Function( CodexReasoningTextDelta value)  reasoningTextDelta,}){
final _that = this;
switch (_that) {
case CodexAgentMessageDelta():
return agentMessageDelta(_that);case CodexReasoningSummaryTextDelta():
return reasoningSummaryTextDelta(_that);case CodexReasoningTextDelta():
return reasoningTextDelta(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CodexAgentMessageDelta value)?  agentMessageDelta,TResult? Function( CodexReasoningSummaryTextDelta value)?  reasoningSummaryTextDelta,TResult? Function( CodexReasoningTextDelta value)?  reasoningTextDelta,}){
final _that = this;
switch (_that) {
case CodexAgentMessageDelta() when agentMessageDelta != null:
return agentMessageDelta(_that);case CodexReasoningSummaryTextDelta() when reasoningSummaryTextDelta != null:
return reasoningSummaryTextDelta(_that);case CodexReasoningTextDelta() when reasoningTextDelta != null:
return reasoningTextDelta(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String delta)?  agentMessageDelta,TResult Function( String delta)?  reasoningSummaryTextDelta,TResult Function( String delta)?  reasoningTextDelta,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CodexAgentMessageDelta() when agentMessageDelta != null:
return agentMessageDelta(_that.delta);case CodexReasoningSummaryTextDelta() when reasoningSummaryTextDelta != null:
return reasoningSummaryTextDelta(_that.delta);case CodexReasoningTextDelta() when reasoningTextDelta != null:
return reasoningTextDelta(_that.delta);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String delta)  agentMessageDelta,required TResult Function( String delta)  reasoningSummaryTextDelta,required TResult Function( String delta)  reasoningTextDelta,}) {final _that = this;
switch (_that) {
case CodexAgentMessageDelta():
return agentMessageDelta(_that.delta);case CodexReasoningSummaryTextDelta():
return reasoningSummaryTextDelta(_that.delta);case CodexReasoningTextDelta():
return reasoningTextDelta(_that.delta);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String delta)?  agentMessageDelta,TResult? Function( String delta)?  reasoningSummaryTextDelta,TResult? Function( String delta)?  reasoningTextDelta,}) {final _that = this;
switch (_that) {
case CodexAgentMessageDelta() when agentMessageDelta != null:
return agentMessageDelta(_that.delta);case CodexReasoningSummaryTextDelta() when reasoningSummaryTextDelta != null:
return reasoningSummaryTextDelta(_that.delta);case CodexReasoningTextDelta() when reasoningTextDelta != null:
return reasoningTextDelta(_that.delta);case _:
  return null;

}
}

}

/// @nodoc


class CodexAgentMessageDelta implements CodexTurnEvent {
  const CodexAgentMessageDelta({required this.delta});
  

@override final  String delta;

/// Create a copy of CodexTurnEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CodexAgentMessageDeltaCopyWith<CodexAgentMessageDelta> get copyWith => _$CodexAgentMessageDeltaCopyWithImpl<CodexAgentMessageDelta>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CodexAgentMessageDelta&&(identical(other.delta, delta) || other.delta == delta));
}


@override
int get hashCode => Object.hash(runtimeType,delta);

@override
String toString() {
  return 'CodexTurnEvent.agentMessageDelta(delta: $delta)';
}


}

/// @nodoc
abstract mixin class $CodexAgentMessageDeltaCopyWith<$Res> implements $CodexTurnEventCopyWith<$Res> {
  factory $CodexAgentMessageDeltaCopyWith(CodexAgentMessageDelta value, $Res Function(CodexAgentMessageDelta) _then) = _$CodexAgentMessageDeltaCopyWithImpl;
@override @useResult
$Res call({
 String delta
});




}
/// @nodoc
class _$CodexAgentMessageDeltaCopyWithImpl<$Res>
    implements $CodexAgentMessageDeltaCopyWith<$Res> {
  _$CodexAgentMessageDeltaCopyWithImpl(this._self, this._then);

  final CodexAgentMessageDelta _self;
  final $Res Function(CodexAgentMessageDelta) _then;

/// Create a copy of CodexTurnEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? delta = null,}) {
  return _then(CodexAgentMessageDelta(
delta: null == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CodexReasoningSummaryTextDelta implements CodexTurnEvent {
  const CodexReasoningSummaryTextDelta({required this.delta});
  

@override final  String delta;

/// Create a copy of CodexTurnEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CodexReasoningSummaryTextDeltaCopyWith<CodexReasoningSummaryTextDelta> get copyWith => _$CodexReasoningSummaryTextDeltaCopyWithImpl<CodexReasoningSummaryTextDelta>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CodexReasoningSummaryTextDelta&&(identical(other.delta, delta) || other.delta == delta));
}


@override
int get hashCode => Object.hash(runtimeType,delta);

@override
String toString() {
  return 'CodexTurnEvent.reasoningSummaryTextDelta(delta: $delta)';
}


}

/// @nodoc
abstract mixin class $CodexReasoningSummaryTextDeltaCopyWith<$Res> implements $CodexTurnEventCopyWith<$Res> {
  factory $CodexReasoningSummaryTextDeltaCopyWith(CodexReasoningSummaryTextDelta value, $Res Function(CodexReasoningSummaryTextDelta) _then) = _$CodexReasoningSummaryTextDeltaCopyWithImpl;
@override @useResult
$Res call({
 String delta
});




}
/// @nodoc
class _$CodexReasoningSummaryTextDeltaCopyWithImpl<$Res>
    implements $CodexReasoningSummaryTextDeltaCopyWith<$Res> {
  _$CodexReasoningSummaryTextDeltaCopyWithImpl(this._self, this._then);

  final CodexReasoningSummaryTextDelta _self;
  final $Res Function(CodexReasoningSummaryTextDelta) _then;

/// Create a copy of CodexTurnEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? delta = null,}) {
  return _then(CodexReasoningSummaryTextDelta(
delta: null == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CodexReasoningTextDelta implements CodexTurnEvent {
  const CodexReasoningTextDelta({required this.delta});
  

@override final  String delta;

/// Create a copy of CodexTurnEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CodexReasoningTextDeltaCopyWith<CodexReasoningTextDelta> get copyWith => _$CodexReasoningTextDeltaCopyWithImpl<CodexReasoningTextDelta>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CodexReasoningTextDelta&&(identical(other.delta, delta) || other.delta == delta));
}


@override
int get hashCode => Object.hash(runtimeType,delta);

@override
String toString() {
  return 'CodexTurnEvent.reasoningTextDelta(delta: $delta)';
}


}

/// @nodoc
abstract mixin class $CodexReasoningTextDeltaCopyWith<$Res> implements $CodexTurnEventCopyWith<$Res> {
  factory $CodexReasoningTextDeltaCopyWith(CodexReasoningTextDelta value, $Res Function(CodexReasoningTextDelta) _then) = _$CodexReasoningTextDeltaCopyWithImpl;
@override @useResult
$Res call({
 String delta
});




}
/// @nodoc
class _$CodexReasoningTextDeltaCopyWithImpl<$Res>
    implements $CodexReasoningTextDeltaCopyWith<$Res> {
  _$CodexReasoningTextDeltaCopyWithImpl(this._self, this._then);

  final CodexReasoningTextDelta _self;
  final $Res Function(CodexReasoningTextDelta) _then;

/// Create a copy of CodexTurnEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? delta = null,}) {
  return _then(CodexReasoningTextDelta(
delta: null == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
