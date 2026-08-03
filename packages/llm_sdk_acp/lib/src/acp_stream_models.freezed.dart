// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'acp_stream_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
AcpSessionUpdate _$AcpSessionUpdateFromJson(
  Map<String, dynamic> json
) {
        switch (json['sessionUpdate']) {
                  case 'agent_message_chunk':
          return AcpAgentMessageChunk.fromJson(
            json
          );
                case 'agent_thought_chunk':
          return AcpAgentThoughtChunk.fromJson(
            json
          );
        
          default:
            return AcpUnknownUpdate.fromJson(
  json
);
        }
      
}

/// @nodoc
mixin _$AcpSessionUpdate {



  /// Serializes this AcpSessionUpdate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AcpSessionUpdate);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AcpSessionUpdate()';
}


}

/// @nodoc
class $AcpSessionUpdateCopyWith<$Res>  {
$AcpSessionUpdateCopyWith(AcpSessionUpdate _, $Res Function(AcpSessionUpdate) __);
}


/// Adds pattern-matching-related methods to [AcpSessionUpdate].
extension AcpSessionUpdatePatterns on AcpSessionUpdate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AcpAgentMessageChunk value)?  agentMessageChunk,TResult Function( AcpAgentThoughtChunk value)?  agentThoughtChunk,TResult Function( AcpUnknownUpdate value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AcpAgentMessageChunk() when agentMessageChunk != null:
return agentMessageChunk(_that);case AcpAgentThoughtChunk() when agentThoughtChunk != null:
return agentThoughtChunk(_that);case AcpUnknownUpdate() when unknown != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AcpAgentMessageChunk value)  agentMessageChunk,required TResult Function( AcpAgentThoughtChunk value)  agentThoughtChunk,required TResult Function( AcpUnknownUpdate value)  unknown,}){
final _that = this;
switch (_that) {
case AcpAgentMessageChunk():
return agentMessageChunk(_that);case AcpAgentThoughtChunk():
return agentThoughtChunk(_that);case AcpUnknownUpdate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AcpAgentMessageChunk value)?  agentMessageChunk,TResult? Function( AcpAgentThoughtChunk value)?  agentThoughtChunk,TResult? Function( AcpUnknownUpdate value)?  unknown,}){
final _that = this;
switch (_that) {
case AcpAgentMessageChunk() when agentMessageChunk != null:
return agentMessageChunk(_that);case AcpAgentThoughtChunk() when agentThoughtChunk != null:
return agentThoughtChunk(_that);case AcpUnknownUpdate() when unknown != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( AcpContentBlock content)?  agentMessageChunk,TResult Function( AcpContentBlock content)?  agentThoughtChunk,TResult Function()?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AcpAgentMessageChunk() when agentMessageChunk != null:
return agentMessageChunk(_that.content);case AcpAgentThoughtChunk() when agentThoughtChunk != null:
return agentThoughtChunk(_that.content);case AcpUnknownUpdate() when unknown != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( AcpContentBlock content)  agentMessageChunk,required TResult Function( AcpContentBlock content)  agentThoughtChunk,required TResult Function()  unknown,}) {final _that = this;
switch (_that) {
case AcpAgentMessageChunk():
return agentMessageChunk(_that.content);case AcpAgentThoughtChunk():
return agentThoughtChunk(_that.content);case AcpUnknownUpdate():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( AcpContentBlock content)?  agentMessageChunk,TResult? Function( AcpContentBlock content)?  agentThoughtChunk,TResult? Function()?  unknown,}) {final _that = this;
switch (_that) {
case AcpAgentMessageChunk() when agentMessageChunk != null:
return agentMessageChunk(_that.content);case AcpAgentThoughtChunk() when agentThoughtChunk != null:
return agentThoughtChunk(_that.content);case AcpUnknownUpdate() when unknown != null:
return unknown();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class AcpAgentMessageChunk implements AcpSessionUpdate {
  const AcpAgentMessageChunk({required this.content, final  String? $type}): $type = $type ?? 'agent_message_chunk';
  factory AcpAgentMessageChunk.fromJson(Map<String, dynamic> json) => _$AcpAgentMessageChunkFromJson(json);

 final  AcpContentBlock content;

@JsonKey(name: 'sessionUpdate')
final String $type;


/// Create a copy of AcpSessionUpdate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AcpAgentMessageChunkCopyWith<AcpAgentMessageChunk> get copyWith => _$AcpAgentMessageChunkCopyWithImpl<AcpAgentMessageChunk>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AcpAgentMessageChunkToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AcpAgentMessageChunk&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content);

@override
String toString() {
  return 'AcpSessionUpdate.agentMessageChunk(content: $content)';
}


}

/// @nodoc
abstract mixin class $AcpAgentMessageChunkCopyWith<$Res> implements $AcpSessionUpdateCopyWith<$Res> {
  factory $AcpAgentMessageChunkCopyWith(AcpAgentMessageChunk value, $Res Function(AcpAgentMessageChunk) _then) = _$AcpAgentMessageChunkCopyWithImpl;
@useResult
$Res call({
 AcpContentBlock content
});


$AcpContentBlockCopyWith<$Res> get content;

}
/// @nodoc
class _$AcpAgentMessageChunkCopyWithImpl<$Res>
    implements $AcpAgentMessageChunkCopyWith<$Res> {
  _$AcpAgentMessageChunkCopyWithImpl(this._self, this._then);

  final AcpAgentMessageChunk _self;
  final $Res Function(AcpAgentMessageChunk) _then;

/// Create a copy of AcpSessionUpdate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? content = null,}) {
  return _then(AcpAgentMessageChunk(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as AcpContentBlock,
  ));
}

/// Create a copy of AcpSessionUpdate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AcpContentBlockCopyWith<$Res> get content {
  
  return $AcpContentBlockCopyWith<$Res>(_self.content, (value) {
    return _then(_self.copyWith(content: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class AcpAgentThoughtChunk implements AcpSessionUpdate {
  const AcpAgentThoughtChunk({required this.content, final  String? $type}): $type = $type ?? 'agent_thought_chunk';
  factory AcpAgentThoughtChunk.fromJson(Map<String, dynamic> json) => _$AcpAgentThoughtChunkFromJson(json);

 final  AcpContentBlock content;

@JsonKey(name: 'sessionUpdate')
final String $type;


/// Create a copy of AcpSessionUpdate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AcpAgentThoughtChunkCopyWith<AcpAgentThoughtChunk> get copyWith => _$AcpAgentThoughtChunkCopyWithImpl<AcpAgentThoughtChunk>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AcpAgentThoughtChunkToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AcpAgentThoughtChunk&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content);

@override
String toString() {
  return 'AcpSessionUpdate.agentThoughtChunk(content: $content)';
}


}

/// @nodoc
abstract mixin class $AcpAgentThoughtChunkCopyWith<$Res> implements $AcpSessionUpdateCopyWith<$Res> {
  factory $AcpAgentThoughtChunkCopyWith(AcpAgentThoughtChunk value, $Res Function(AcpAgentThoughtChunk) _then) = _$AcpAgentThoughtChunkCopyWithImpl;
@useResult
$Res call({
 AcpContentBlock content
});


$AcpContentBlockCopyWith<$Res> get content;

}
/// @nodoc
class _$AcpAgentThoughtChunkCopyWithImpl<$Res>
    implements $AcpAgentThoughtChunkCopyWith<$Res> {
  _$AcpAgentThoughtChunkCopyWithImpl(this._self, this._then);

  final AcpAgentThoughtChunk _self;
  final $Res Function(AcpAgentThoughtChunk) _then;

/// Create a copy of AcpSessionUpdate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? content = null,}) {
  return _then(AcpAgentThoughtChunk(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as AcpContentBlock,
  ));
}

/// Create a copy of AcpSessionUpdate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AcpContentBlockCopyWith<$Res> get content {
  
  return $AcpContentBlockCopyWith<$Res>(_self.content, (value) {
    return _then(_self.copyWith(content: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class AcpUnknownUpdate implements AcpSessionUpdate {
  const AcpUnknownUpdate({final  String? $type}): $type = $type ?? 'unknown';
  factory AcpUnknownUpdate.fromJson(Map<String, dynamic> json) => _$AcpUnknownUpdateFromJson(json);



@JsonKey(name: 'sessionUpdate')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$AcpUnknownUpdateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AcpUnknownUpdate);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AcpSessionUpdate.unknown()';
}


}




AcpContentBlock _$AcpContentBlockFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'text':
          return AcpTextContent.fromJson(
            json
          );
        
          default:
            return AcpUnknownContent.fromJson(
  json
);
        }
      
}

/// @nodoc
mixin _$AcpContentBlock {



  /// Serializes this AcpContentBlock to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AcpContentBlock);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AcpContentBlock()';
}


}

/// @nodoc
class $AcpContentBlockCopyWith<$Res>  {
$AcpContentBlockCopyWith(AcpContentBlock _, $Res Function(AcpContentBlock) __);
}


/// Adds pattern-matching-related methods to [AcpContentBlock].
extension AcpContentBlockPatterns on AcpContentBlock {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AcpTextContent value)?  text,TResult Function( AcpUnknownContent value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AcpTextContent() when text != null:
return text(_that);case AcpUnknownContent() when unknown != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AcpTextContent value)  text,required TResult Function( AcpUnknownContent value)  unknown,}){
final _that = this;
switch (_that) {
case AcpTextContent():
return text(_that);case AcpUnknownContent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AcpTextContent value)?  text,TResult? Function( AcpUnknownContent value)?  unknown,}){
final _that = this;
switch (_that) {
case AcpTextContent() when text != null:
return text(_that);case AcpUnknownContent() when unknown != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String text)?  text,TResult Function()?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AcpTextContent() when text != null:
return text(_that.text);case AcpUnknownContent() when unknown != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String text)  text,required TResult Function()  unknown,}) {final _that = this;
switch (_that) {
case AcpTextContent():
return text(_that.text);case AcpUnknownContent():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String text)?  text,TResult? Function()?  unknown,}) {final _that = this;
switch (_that) {
case AcpTextContent() when text != null:
return text(_that.text);case AcpUnknownContent() when unknown != null:
return unknown();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class AcpTextContent implements AcpContentBlock {
  const AcpTextContent({required this.text, final  String? $type}): $type = $type ?? 'text';
  factory AcpTextContent.fromJson(Map<String, dynamic> json) => _$AcpTextContentFromJson(json);

 final  String text;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of AcpContentBlock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AcpTextContentCopyWith<AcpTextContent> get copyWith => _$AcpTextContentCopyWithImpl<AcpTextContent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AcpTextContentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AcpTextContent&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'AcpContentBlock.text(text: $text)';
}


}

/// @nodoc
abstract mixin class $AcpTextContentCopyWith<$Res> implements $AcpContentBlockCopyWith<$Res> {
  factory $AcpTextContentCopyWith(AcpTextContent value, $Res Function(AcpTextContent) _then) = _$AcpTextContentCopyWithImpl;
@useResult
$Res call({
 String text
});




}
/// @nodoc
class _$AcpTextContentCopyWithImpl<$Res>
    implements $AcpTextContentCopyWith<$Res> {
  _$AcpTextContentCopyWithImpl(this._self, this._then);

  final AcpTextContent _self;
  final $Res Function(AcpTextContent) _then;

/// Create a copy of AcpContentBlock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(AcpTextContent(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class AcpUnknownContent implements AcpContentBlock {
  const AcpUnknownContent({final  String? $type}): $type = $type ?? 'unknown';
  factory AcpUnknownContent.fromJson(Map<String, dynamic> json) => _$AcpUnknownContentFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$AcpUnknownContentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AcpUnknownContent);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AcpContentBlock.unknown()';
}


}




// dart format on
