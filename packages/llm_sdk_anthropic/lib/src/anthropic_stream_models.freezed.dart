// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'anthropic_stream_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
AnthropicStreamEvent _$AnthropicStreamEventFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'content_block_delta':
          return AnthropicContentBlockDeltaEvent.fromJson(
            json
          );
        
          default:
            return AnthropicUnknownEvent.fromJson(
  json
);
        }
      
}

/// @nodoc
mixin _$AnthropicStreamEvent {



  /// Serializes this AnthropicStreamEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnthropicStreamEvent);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AnthropicStreamEvent()';
}


}

/// @nodoc
class $AnthropicStreamEventCopyWith<$Res>  {
$AnthropicStreamEventCopyWith(AnthropicStreamEvent _, $Res Function(AnthropicStreamEvent) __);
}


/// Adds pattern-matching-related methods to [AnthropicStreamEvent].
extension AnthropicStreamEventPatterns on AnthropicStreamEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AnthropicContentBlockDeltaEvent value)?  contentBlockDelta,TResult Function( AnthropicUnknownEvent value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AnthropicContentBlockDeltaEvent() when contentBlockDelta != null:
return contentBlockDelta(_that);case AnthropicUnknownEvent() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AnthropicContentBlockDeltaEvent value)  contentBlockDelta,required TResult Function( AnthropicUnknownEvent value)  unknown,}){
final _that = this;
switch (_that) {
case AnthropicContentBlockDeltaEvent():
return contentBlockDelta(_that);case AnthropicUnknownEvent():
return unknown(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AnthropicContentBlockDeltaEvent value)?  contentBlockDelta,TResult? Function( AnthropicUnknownEvent value)?  unknown,}){
final _that = this;
switch (_that) {
case AnthropicContentBlockDeltaEvent() when contentBlockDelta != null:
return contentBlockDelta(_that);case AnthropicUnknownEvent() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( AnthropicDelta delta)?  contentBlockDelta,TResult Function()?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AnthropicContentBlockDeltaEvent() when contentBlockDelta != null:
return contentBlockDelta(_that.delta);case AnthropicUnknownEvent() when unknown != null:
return unknown();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( AnthropicDelta delta)  contentBlockDelta,required TResult Function()  unknown,}) {final _that = this;
switch (_that) {
case AnthropicContentBlockDeltaEvent():
return contentBlockDelta(_that.delta);case AnthropicUnknownEvent():
return unknown();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( AnthropicDelta delta)?  contentBlockDelta,TResult? Function()?  unknown,}) {final _that = this;
switch (_that) {
case AnthropicContentBlockDeltaEvent() when contentBlockDelta != null:
return contentBlockDelta(_that.delta);case AnthropicUnknownEvent() when unknown != null:
return unknown();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class AnthropicContentBlockDeltaEvent implements AnthropicStreamEvent {
  const AnthropicContentBlockDeltaEvent({required this.delta, final  String? $type}): $type = $type ?? 'content_block_delta';
  factory AnthropicContentBlockDeltaEvent.fromJson(Map<String, dynamic> json) => _$AnthropicContentBlockDeltaEventFromJson(json);

 final  AnthropicDelta delta;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of AnthropicStreamEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnthropicContentBlockDeltaEventCopyWith<AnthropicContentBlockDeltaEvent> get copyWith => _$AnthropicContentBlockDeltaEventCopyWithImpl<AnthropicContentBlockDeltaEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnthropicContentBlockDeltaEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnthropicContentBlockDeltaEvent&&(identical(other.delta, delta) || other.delta == delta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,delta);

@override
String toString() {
  return 'AnthropicStreamEvent.contentBlockDelta(delta: $delta)';
}


}

/// @nodoc
abstract mixin class $AnthropicContentBlockDeltaEventCopyWith<$Res> implements $AnthropicStreamEventCopyWith<$Res> {
  factory $AnthropicContentBlockDeltaEventCopyWith(AnthropicContentBlockDeltaEvent value, $Res Function(AnthropicContentBlockDeltaEvent) _then) = _$AnthropicContentBlockDeltaEventCopyWithImpl;
@useResult
$Res call({
 AnthropicDelta delta
});


$AnthropicDeltaCopyWith<$Res> get delta;

}
/// @nodoc
class _$AnthropicContentBlockDeltaEventCopyWithImpl<$Res>
    implements $AnthropicContentBlockDeltaEventCopyWith<$Res> {
  _$AnthropicContentBlockDeltaEventCopyWithImpl(this._self, this._then);

  final AnthropicContentBlockDeltaEvent _self;
  final $Res Function(AnthropicContentBlockDeltaEvent) _then;

/// Create a copy of AnthropicStreamEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? delta = null,}) {
  return _then(AnthropicContentBlockDeltaEvent(
delta: null == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as AnthropicDelta,
  ));
}

/// Create a copy of AnthropicStreamEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnthropicDeltaCopyWith<$Res> get delta {
  
  return $AnthropicDeltaCopyWith<$Res>(_self.delta, (value) {
    return _then(_self.copyWith(delta: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class AnthropicUnknownEvent implements AnthropicStreamEvent {
  const AnthropicUnknownEvent({final  String? $type}): $type = $type ?? 'unknown';
  factory AnthropicUnknownEvent.fromJson(Map<String, dynamic> json) => _$AnthropicUnknownEventFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$AnthropicUnknownEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnthropicUnknownEvent);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AnthropicStreamEvent.unknown()';
}


}




AnthropicDelta _$AnthropicDeltaFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'text_delta':
          return AnthropicTextDelta.fromJson(
            json
          );
                case 'thinking_delta':
          return AnthropicThinkingDelta.fromJson(
            json
          );
        
          default:
            return AnthropicUnknownDelta.fromJson(
  json
);
        }
      
}

/// @nodoc
mixin _$AnthropicDelta {



  /// Serializes this AnthropicDelta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnthropicDelta);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AnthropicDelta()';
}


}

/// @nodoc
class $AnthropicDeltaCopyWith<$Res>  {
$AnthropicDeltaCopyWith(AnthropicDelta _, $Res Function(AnthropicDelta) __);
}


/// Adds pattern-matching-related methods to [AnthropicDelta].
extension AnthropicDeltaPatterns on AnthropicDelta {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AnthropicTextDelta value)?  text,TResult Function( AnthropicThinkingDelta value)?  thinking,TResult Function( AnthropicUnknownDelta value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AnthropicTextDelta() when text != null:
return text(_that);case AnthropicThinkingDelta() when thinking != null:
return thinking(_that);case AnthropicUnknownDelta() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AnthropicTextDelta value)  text,required TResult Function( AnthropicThinkingDelta value)  thinking,required TResult Function( AnthropicUnknownDelta value)  unknown,}){
final _that = this;
switch (_that) {
case AnthropicTextDelta():
return text(_that);case AnthropicThinkingDelta():
return thinking(_that);case AnthropicUnknownDelta():
return unknown(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AnthropicTextDelta value)?  text,TResult? Function( AnthropicThinkingDelta value)?  thinking,TResult? Function( AnthropicUnknownDelta value)?  unknown,}){
final _that = this;
switch (_that) {
case AnthropicTextDelta() when text != null:
return text(_that);case AnthropicThinkingDelta() when thinking != null:
return thinking(_that);case AnthropicUnknownDelta() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String text)?  text,TResult Function( String thinking)?  thinking,TResult Function()?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AnthropicTextDelta() when text != null:
return text(_that.text);case AnthropicThinkingDelta() when thinking != null:
return thinking(_that.thinking);case AnthropicUnknownDelta() when unknown != null:
return unknown();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String text)  text,required TResult Function( String thinking)  thinking,required TResult Function()  unknown,}) {final _that = this;
switch (_that) {
case AnthropicTextDelta():
return text(_that.text);case AnthropicThinkingDelta():
return thinking(_that.thinking);case AnthropicUnknownDelta():
return unknown();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String text)?  text,TResult? Function( String thinking)?  thinking,TResult? Function()?  unknown,}) {final _that = this;
switch (_that) {
case AnthropicTextDelta() when text != null:
return text(_that.text);case AnthropicThinkingDelta() when thinking != null:
return thinking(_that.thinking);case AnthropicUnknownDelta() when unknown != null:
return unknown();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class AnthropicTextDelta implements AnthropicDelta {
  const AnthropicTextDelta({required this.text, final  String? $type}): $type = $type ?? 'text_delta';
  factory AnthropicTextDelta.fromJson(Map<String, dynamic> json) => _$AnthropicTextDeltaFromJson(json);

 final  String text;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of AnthropicDelta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnthropicTextDeltaCopyWith<AnthropicTextDelta> get copyWith => _$AnthropicTextDeltaCopyWithImpl<AnthropicTextDelta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnthropicTextDeltaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnthropicTextDelta&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'AnthropicDelta.text(text: $text)';
}


}

/// @nodoc
abstract mixin class $AnthropicTextDeltaCopyWith<$Res> implements $AnthropicDeltaCopyWith<$Res> {
  factory $AnthropicTextDeltaCopyWith(AnthropicTextDelta value, $Res Function(AnthropicTextDelta) _then) = _$AnthropicTextDeltaCopyWithImpl;
@useResult
$Res call({
 String text
});




}
/// @nodoc
class _$AnthropicTextDeltaCopyWithImpl<$Res>
    implements $AnthropicTextDeltaCopyWith<$Res> {
  _$AnthropicTextDeltaCopyWithImpl(this._self, this._then);

  final AnthropicTextDelta _self;
  final $Res Function(AnthropicTextDelta) _then;

/// Create a copy of AnthropicDelta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(AnthropicTextDelta(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class AnthropicThinkingDelta implements AnthropicDelta {
  const AnthropicThinkingDelta({required this.thinking, final  String? $type}): $type = $type ?? 'thinking_delta';
  factory AnthropicThinkingDelta.fromJson(Map<String, dynamic> json) => _$AnthropicThinkingDeltaFromJson(json);

 final  String thinking;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of AnthropicDelta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnthropicThinkingDeltaCopyWith<AnthropicThinkingDelta> get copyWith => _$AnthropicThinkingDeltaCopyWithImpl<AnthropicThinkingDelta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnthropicThinkingDeltaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnthropicThinkingDelta&&(identical(other.thinking, thinking) || other.thinking == thinking));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,thinking);

@override
String toString() {
  return 'AnthropicDelta.thinking(thinking: $thinking)';
}


}

/// @nodoc
abstract mixin class $AnthropicThinkingDeltaCopyWith<$Res> implements $AnthropicDeltaCopyWith<$Res> {
  factory $AnthropicThinkingDeltaCopyWith(AnthropicThinkingDelta value, $Res Function(AnthropicThinkingDelta) _then) = _$AnthropicThinkingDeltaCopyWithImpl;
@useResult
$Res call({
 String thinking
});




}
/// @nodoc
class _$AnthropicThinkingDeltaCopyWithImpl<$Res>
    implements $AnthropicThinkingDeltaCopyWith<$Res> {
  _$AnthropicThinkingDeltaCopyWithImpl(this._self, this._then);

  final AnthropicThinkingDelta _self;
  final $Res Function(AnthropicThinkingDelta) _then;

/// Create a copy of AnthropicDelta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? thinking = null,}) {
  return _then(AnthropicThinkingDelta(
thinking: null == thinking ? _self.thinking : thinking // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class AnthropicUnknownDelta implements AnthropicDelta {
  const AnthropicUnknownDelta({final  String? $type}): $type = $type ?? 'unknown';
  factory AnthropicUnknownDelta.fromJson(Map<String, dynamic> json) => _$AnthropicUnknownDeltaFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$AnthropicUnknownDeltaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnthropicUnknownDelta);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AnthropicDelta.unknown()';
}


}




// dart format on
