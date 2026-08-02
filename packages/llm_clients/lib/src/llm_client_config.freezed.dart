// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'llm_client_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LlmClientConfig {

 String get apiKey; String get baseUrl; String get model;
/// Create a copy of LlmClientConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LlmClientConfigCopyWith<LlmClientConfig> get copyWith => _$LlmClientConfigCopyWithImpl<LlmClientConfig>(this as LlmClientConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LlmClientConfig&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.model, model) || other.model == model));
}


@override
int get hashCode => Object.hash(runtimeType,apiKey,baseUrl,model);

@override
String toString() {
  return 'LlmClientConfig(apiKey: $apiKey, baseUrl: $baseUrl, model: $model)';
}


}

/// @nodoc
abstract mixin class $LlmClientConfigCopyWith<$Res>  {
  factory $LlmClientConfigCopyWith(LlmClientConfig value, $Res Function(LlmClientConfig) _then) = _$LlmClientConfigCopyWithImpl;
@useResult
$Res call({
 String apiKey, String baseUrl, String model
});




}
/// @nodoc
class _$LlmClientConfigCopyWithImpl<$Res>
    implements $LlmClientConfigCopyWith<$Res> {
  _$LlmClientConfigCopyWithImpl(this._self, this._then);

  final LlmClientConfig _self;
  final $Res Function(LlmClientConfig) _then;

/// Create a copy of LlmClientConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? apiKey = null,Object? baseUrl = null,Object? model = null,}) {
  return _then(_self.copyWith(
apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LlmClientConfig].
extension LlmClientConfigPatterns on LlmClientConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OpenAiConfig value)?  openAi,TResult Function( OpenAiCompatibleConfig value)?  openAiCompatible,TResult Function( AnthropicConfig value)?  anthropic,TResult Function( GeminiConfig value)?  google,TResult Function( DeepSeekConfig value)?  deepSeek,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OpenAiConfig() when openAi != null:
return openAi(_that);case OpenAiCompatibleConfig() when openAiCompatible != null:
return openAiCompatible(_that);case AnthropicConfig() when anthropic != null:
return anthropic(_that);case GeminiConfig() when google != null:
return google(_that);case DeepSeekConfig() when deepSeek != null:
return deepSeek(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OpenAiConfig value)  openAi,required TResult Function( OpenAiCompatibleConfig value)  openAiCompatible,required TResult Function( AnthropicConfig value)  anthropic,required TResult Function( GeminiConfig value)  google,required TResult Function( DeepSeekConfig value)  deepSeek,}){
final _that = this;
switch (_that) {
case OpenAiConfig():
return openAi(_that);case OpenAiCompatibleConfig():
return openAiCompatible(_that);case AnthropicConfig():
return anthropic(_that);case GeminiConfig():
return google(_that);case DeepSeekConfig():
return deepSeek(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OpenAiConfig value)?  openAi,TResult? Function( OpenAiCompatibleConfig value)?  openAiCompatible,TResult? Function( AnthropicConfig value)?  anthropic,TResult? Function( GeminiConfig value)?  google,TResult? Function( DeepSeekConfig value)?  deepSeek,}){
final _that = this;
switch (_that) {
case OpenAiConfig() when openAi != null:
return openAi(_that);case OpenAiCompatibleConfig() when openAiCompatible != null:
return openAiCompatible(_that);case AnthropicConfig() when anthropic != null:
return anthropic(_that);case GeminiConfig() when google != null:
return google(_that);case DeepSeekConfig() when deepSeek != null:
return deepSeek(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String apiKey,  String baseUrl,  String model)?  openAi,TResult Function( String apiKey,  String baseUrl,  String model)?  openAiCompatible,TResult Function( String apiKey,  String baseUrl,  String model)?  anthropic,TResult Function( String apiKey,  String baseUrl,  String model)?  google,TResult Function( String apiKey,  String baseUrl,  String model)?  deepSeek,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OpenAiConfig() when openAi != null:
return openAi(_that.apiKey,_that.baseUrl,_that.model);case OpenAiCompatibleConfig() when openAiCompatible != null:
return openAiCompatible(_that.apiKey,_that.baseUrl,_that.model);case AnthropicConfig() when anthropic != null:
return anthropic(_that.apiKey,_that.baseUrl,_that.model);case GeminiConfig() when google != null:
return google(_that.apiKey,_that.baseUrl,_that.model);case DeepSeekConfig() when deepSeek != null:
return deepSeek(_that.apiKey,_that.baseUrl,_that.model);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String apiKey,  String baseUrl,  String model)  openAi,required TResult Function( String apiKey,  String baseUrl,  String model)  openAiCompatible,required TResult Function( String apiKey,  String baseUrl,  String model)  anthropic,required TResult Function( String apiKey,  String baseUrl,  String model)  google,required TResult Function( String apiKey,  String baseUrl,  String model)  deepSeek,}) {final _that = this;
switch (_that) {
case OpenAiConfig():
return openAi(_that.apiKey,_that.baseUrl,_that.model);case OpenAiCompatibleConfig():
return openAiCompatible(_that.apiKey,_that.baseUrl,_that.model);case AnthropicConfig():
return anthropic(_that.apiKey,_that.baseUrl,_that.model);case GeminiConfig():
return google(_that.apiKey,_that.baseUrl,_that.model);case DeepSeekConfig():
return deepSeek(_that.apiKey,_that.baseUrl,_that.model);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String apiKey,  String baseUrl,  String model)?  openAi,TResult? Function( String apiKey,  String baseUrl,  String model)?  openAiCompatible,TResult? Function( String apiKey,  String baseUrl,  String model)?  anthropic,TResult? Function( String apiKey,  String baseUrl,  String model)?  google,TResult? Function( String apiKey,  String baseUrl,  String model)?  deepSeek,}) {final _that = this;
switch (_that) {
case OpenAiConfig() when openAi != null:
return openAi(_that.apiKey,_that.baseUrl,_that.model);case OpenAiCompatibleConfig() when openAiCompatible != null:
return openAiCompatible(_that.apiKey,_that.baseUrl,_that.model);case AnthropicConfig() when anthropic != null:
return anthropic(_that.apiKey,_that.baseUrl,_that.model);case GeminiConfig() when google != null:
return google(_that.apiKey,_that.baseUrl,_that.model);case DeepSeekConfig() when deepSeek != null:
return deepSeek(_that.apiKey,_that.baseUrl,_that.model);case _:
  return null;

}
}

}

/// @nodoc


class OpenAiConfig extends LlmClientConfig {
  const OpenAiConfig({required this.apiKey, this.baseUrl = 'https://api.openai.com/v1', this.model = 'gpt-5-mini'}): super._();
  

@override final  String apiKey;
@override@JsonKey() final  String baseUrl;
@override@JsonKey() final  String model;

/// Create a copy of LlmClientConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenAiConfigCopyWith<OpenAiConfig> get copyWith => _$OpenAiConfigCopyWithImpl<OpenAiConfig>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenAiConfig&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.model, model) || other.model == model));
}


@override
int get hashCode => Object.hash(runtimeType,apiKey,baseUrl,model);

@override
String toString() {
  return 'LlmClientConfig.openAi(apiKey: $apiKey, baseUrl: $baseUrl, model: $model)';
}


}

/// @nodoc
abstract mixin class $OpenAiConfigCopyWith<$Res> implements $LlmClientConfigCopyWith<$Res> {
  factory $OpenAiConfigCopyWith(OpenAiConfig value, $Res Function(OpenAiConfig) _then) = _$OpenAiConfigCopyWithImpl;
@override @useResult
$Res call({
 String apiKey, String baseUrl, String model
});




}
/// @nodoc
class _$OpenAiConfigCopyWithImpl<$Res>
    implements $OpenAiConfigCopyWith<$Res> {
  _$OpenAiConfigCopyWithImpl(this._self, this._then);

  final OpenAiConfig _self;
  final $Res Function(OpenAiConfig) _then;

/// Create a copy of LlmClientConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? apiKey = null,Object? baseUrl = null,Object? model = null,}) {
  return _then(OpenAiConfig(
apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class OpenAiCompatibleConfig extends LlmClientConfig {
  const OpenAiCompatibleConfig({this.apiKey = '', this.baseUrl = '', this.model = ''}): super._();
  

@override@JsonKey() final  String apiKey;
@override@JsonKey() final  String baseUrl;
@override@JsonKey() final  String model;

/// Create a copy of LlmClientConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenAiCompatibleConfigCopyWith<OpenAiCompatibleConfig> get copyWith => _$OpenAiCompatibleConfigCopyWithImpl<OpenAiCompatibleConfig>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenAiCompatibleConfig&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.model, model) || other.model == model));
}


@override
int get hashCode => Object.hash(runtimeType,apiKey,baseUrl,model);

@override
String toString() {
  return 'LlmClientConfig.openAiCompatible(apiKey: $apiKey, baseUrl: $baseUrl, model: $model)';
}


}

/// @nodoc
abstract mixin class $OpenAiCompatibleConfigCopyWith<$Res> implements $LlmClientConfigCopyWith<$Res> {
  factory $OpenAiCompatibleConfigCopyWith(OpenAiCompatibleConfig value, $Res Function(OpenAiCompatibleConfig) _then) = _$OpenAiCompatibleConfigCopyWithImpl;
@override @useResult
$Res call({
 String apiKey, String baseUrl, String model
});




}
/// @nodoc
class _$OpenAiCompatibleConfigCopyWithImpl<$Res>
    implements $OpenAiCompatibleConfigCopyWith<$Res> {
  _$OpenAiCompatibleConfigCopyWithImpl(this._self, this._then);

  final OpenAiCompatibleConfig _self;
  final $Res Function(OpenAiCompatibleConfig) _then;

/// Create a copy of LlmClientConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? apiKey = null,Object? baseUrl = null,Object? model = null,}) {
  return _then(OpenAiCompatibleConfig(
apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AnthropicConfig extends LlmClientConfig {
  const AnthropicConfig({required this.apiKey, this.baseUrl = 'https://api.anthropic.com', this.model = 'claude-sonnet-5'}): super._();
  

@override final  String apiKey;
@override@JsonKey() final  String baseUrl;
@override@JsonKey() final  String model;

/// Create a copy of LlmClientConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnthropicConfigCopyWith<AnthropicConfig> get copyWith => _$AnthropicConfigCopyWithImpl<AnthropicConfig>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnthropicConfig&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.model, model) || other.model == model));
}


@override
int get hashCode => Object.hash(runtimeType,apiKey,baseUrl,model);

@override
String toString() {
  return 'LlmClientConfig.anthropic(apiKey: $apiKey, baseUrl: $baseUrl, model: $model)';
}


}

/// @nodoc
abstract mixin class $AnthropicConfigCopyWith<$Res> implements $LlmClientConfigCopyWith<$Res> {
  factory $AnthropicConfigCopyWith(AnthropicConfig value, $Res Function(AnthropicConfig) _then) = _$AnthropicConfigCopyWithImpl;
@override @useResult
$Res call({
 String apiKey, String baseUrl, String model
});




}
/// @nodoc
class _$AnthropicConfigCopyWithImpl<$Res>
    implements $AnthropicConfigCopyWith<$Res> {
  _$AnthropicConfigCopyWithImpl(this._self, this._then);

  final AnthropicConfig _self;
  final $Res Function(AnthropicConfig) _then;

/// Create a copy of LlmClientConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? apiKey = null,Object? baseUrl = null,Object? model = null,}) {
  return _then(AnthropicConfig(
apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class GeminiConfig extends LlmClientConfig {
  const GeminiConfig({required this.apiKey, this.baseUrl = 'https://generativelanguage.googleapis.com', this.model = 'gemini-2.5-flash'}): super._();
  

@override final  String apiKey;
@override@JsonKey() final  String baseUrl;
@override@JsonKey() final  String model;

/// Create a copy of LlmClientConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeminiConfigCopyWith<GeminiConfig> get copyWith => _$GeminiConfigCopyWithImpl<GeminiConfig>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeminiConfig&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.model, model) || other.model == model));
}


@override
int get hashCode => Object.hash(runtimeType,apiKey,baseUrl,model);

@override
String toString() {
  return 'LlmClientConfig.google(apiKey: $apiKey, baseUrl: $baseUrl, model: $model)';
}


}

/// @nodoc
abstract mixin class $GeminiConfigCopyWith<$Res> implements $LlmClientConfigCopyWith<$Res> {
  factory $GeminiConfigCopyWith(GeminiConfig value, $Res Function(GeminiConfig) _then) = _$GeminiConfigCopyWithImpl;
@override @useResult
$Res call({
 String apiKey, String baseUrl, String model
});




}
/// @nodoc
class _$GeminiConfigCopyWithImpl<$Res>
    implements $GeminiConfigCopyWith<$Res> {
  _$GeminiConfigCopyWithImpl(this._self, this._then);

  final GeminiConfig _self;
  final $Res Function(GeminiConfig) _then;

/// Create a copy of LlmClientConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? apiKey = null,Object? baseUrl = null,Object? model = null,}) {
  return _then(GeminiConfig(
apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class DeepSeekConfig extends LlmClientConfig {
  const DeepSeekConfig({required this.apiKey, this.baseUrl = 'https://api.deepseek.com', this.model = 'deepseek-chat'}): super._();
  

@override final  String apiKey;
@override@JsonKey() final  String baseUrl;
@override@JsonKey() final  String model;

/// Create a copy of LlmClientConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeepSeekConfigCopyWith<DeepSeekConfig> get copyWith => _$DeepSeekConfigCopyWithImpl<DeepSeekConfig>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeepSeekConfig&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.model, model) || other.model == model));
}


@override
int get hashCode => Object.hash(runtimeType,apiKey,baseUrl,model);

@override
String toString() {
  return 'LlmClientConfig.deepSeek(apiKey: $apiKey, baseUrl: $baseUrl, model: $model)';
}


}

/// @nodoc
abstract mixin class $DeepSeekConfigCopyWith<$Res> implements $LlmClientConfigCopyWith<$Res> {
  factory $DeepSeekConfigCopyWith(DeepSeekConfig value, $Res Function(DeepSeekConfig) _then) = _$DeepSeekConfigCopyWithImpl;
@override @useResult
$Res call({
 String apiKey, String baseUrl, String model
});




}
/// @nodoc
class _$DeepSeekConfigCopyWithImpl<$Res>
    implements $DeepSeekConfigCopyWith<$Res> {
  _$DeepSeekConfigCopyWithImpl(this._self, this._then);

  final DeepSeekConfig _self;
  final $Res Function(DeepSeekConfig) _then;

/// Create a copy of LlmClientConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? apiKey = null,Object? baseUrl = null,Object? model = null,}) {
  return _then(DeepSeekConfig(
apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
