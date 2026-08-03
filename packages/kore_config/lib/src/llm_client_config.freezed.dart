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
LlmClientConfig _$LlmClientConfigFromJson(
  Map<String, dynamic> json
) {
        switch (json['provider']) {
                  case 'openai':
          return OpenAiConfig.fromJson(
            json
          );
                case 'openai-compatible':
          return OpenAiCompatibleConfig.fromJson(
            json
          );
                case 'anthropic':
          return AnthropicConfig.fromJson(
            json
          );
                case 'google':
          return GeminiConfig.fromJson(
            json
          );
                case 'deepseek':
          return DeepSeekConfig.fromJson(
            json
          );
                case 'acp':
          return AcpConfig.fromJson(
            json
          );
                case 'codex':
          return CodexConfig.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'provider',
  'LlmClientConfig',
  'Invalid union type "${json['provider']}"!'
);
        }
      
}

/// @nodoc
mixin _$LlmClientConfig {

@JsonKey(name: 'system_prompt') String get systemPrompt;
/// Create a copy of LlmClientConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LlmClientConfigCopyWith<LlmClientConfig> get copyWith => _$LlmClientConfigCopyWithImpl<LlmClientConfig>(this as LlmClientConfig, _$identity);

  /// Serializes this LlmClientConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LlmClientConfig&&(identical(other.systemPrompt, systemPrompt) || other.systemPrompt == systemPrompt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,systemPrompt);

@override
String toString() {
  return 'LlmClientConfig(systemPrompt: $systemPrompt)';
}


}

/// @nodoc
abstract mixin class $LlmClientConfigCopyWith<$Res>  {
  factory $LlmClientConfigCopyWith(LlmClientConfig value, $Res Function(LlmClientConfig) _then) = _$LlmClientConfigCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'system_prompt') String systemPrompt
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
@pragma('vm:prefer-inline') @override $Res call({Object? systemPrompt = null,}) {
  return _then(_self.copyWith(
systemPrompt: null == systemPrompt ? _self.systemPrompt : systemPrompt // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OpenAiConfig value)?  openAi,TResult Function( OpenAiCompatibleConfig value)?  openAiCompatible,TResult Function( AnthropicConfig value)?  anthropic,TResult Function( GeminiConfig value)?  google,TResult Function( DeepSeekConfig value)?  deepSeek,TResult Function( AcpConfig value)?  acp,TResult Function( CodexConfig value)?  codex,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OpenAiConfig() when openAi != null:
return openAi(_that);case OpenAiCompatibleConfig() when openAiCompatible != null:
return openAiCompatible(_that);case AnthropicConfig() when anthropic != null:
return anthropic(_that);case GeminiConfig() when google != null:
return google(_that);case DeepSeekConfig() when deepSeek != null:
return deepSeek(_that);case AcpConfig() when acp != null:
return acp(_that);case CodexConfig() when codex != null:
return codex(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OpenAiConfig value)  openAi,required TResult Function( OpenAiCompatibleConfig value)  openAiCompatible,required TResult Function( AnthropicConfig value)  anthropic,required TResult Function( GeminiConfig value)  google,required TResult Function( DeepSeekConfig value)  deepSeek,required TResult Function( AcpConfig value)  acp,required TResult Function( CodexConfig value)  codex,}){
final _that = this;
switch (_that) {
case OpenAiConfig():
return openAi(_that);case OpenAiCompatibleConfig():
return openAiCompatible(_that);case AnthropicConfig():
return anthropic(_that);case GeminiConfig():
return google(_that);case DeepSeekConfig():
return deepSeek(_that);case AcpConfig():
return acp(_that);case CodexConfig():
return codex(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OpenAiConfig value)?  openAi,TResult? Function( OpenAiCompatibleConfig value)?  openAiCompatible,TResult? Function( AnthropicConfig value)?  anthropic,TResult? Function( GeminiConfig value)?  google,TResult? Function( DeepSeekConfig value)?  deepSeek,TResult? Function( AcpConfig value)?  acp,TResult? Function( CodexConfig value)?  codex,}){
final _that = this;
switch (_that) {
case OpenAiConfig() when openAi != null:
return openAi(_that);case OpenAiCompatibleConfig() when openAiCompatible != null:
return openAiCompatible(_that);case AnthropicConfig() when anthropic != null:
return anthropic(_that);case GeminiConfig() when google != null:
return google(_that);case DeepSeekConfig() when deepSeek != null:
return deepSeek(_that);case AcpConfig() when acp != null:
return acp(_that);case CodexConfig() when codex != null:
return codex(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function(@JsonKey(name: 'api_key')  String apiKey, @JsonKey(name: 'base_url')  String baseUrl,  String model, @JsonKey(name: 'system_prompt')  String systemPrompt)?  openAi,TResult Function(@JsonKey(name: 'api_key')  String apiKey, @JsonKey(name: 'base_url')  String baseUrl,  String model, @JsonKey(name: 'system_prompt')  String systemPrompt)?  openAiCompatible,TResult Function(@JsonKey(name: 'api_key')  String apiKey, @JsonKey(name: 'base_url')  String baseUrl,  String model,  bool thinking, @JsonKey(name: 'system_prompt')  String systemPrompt)?  anthropic,TResult Function(@JsonKey(name: 'api_key')  String apiKey, @JsonKey(name: 'base_url')  String baseUrl,  String model,  bool thinking, @JsonKey(name: 'system_prompt')  String systemPrompt)?  google,TResult Function(@JsonKey(name: 'api_key')  String apiKey, @JsonKey(name: 'base_url')  String baseUrl,  String model,  bool thinking, @JsonKey(name: 'system_prompt')  String systemPrompt)?  deepSeek,TResult Function( String command, @JsonKey(name: 'system_prompt')  String systemPrompt)?  acp,TResult Function( String command,  String model,  bool thinking, @JsonKey(name: 'system_prompt')  String systemPrompt)?  codex,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OpenAiConfig() when openAi != null:
return openAi(_that.apiKey,_that.baseUrl,_that.model,_that.systemPrompt);case OpenAiCompatibleConfig() when openAiCompatible != null:
return openAiCompatible(_that.apiKey,_that.baseUrl,_that.model,_that.systemPrompt);case AnthropicConfig() when anthropic != null:
return anthropic(_that.apiKey,_that.baseUrl,_that.model,_that.thinking,_that.systemPrompt);case GeminiConfig() when google != null:
return google(_that.apiKey,_that.baseUrl,_that.model,_that.thinking,_that.systemPrompt);case DeepSeekConfig() when deepSeek != null:
return deepSeek(_that.apiKey,_that.baseUrl,_that.model,_that.thinking,_that.systemPrompt);case AcpConfig() when acp != null:
return acp(_that.command,_that.systemPrompt);case CodexConfig() when codex != null:
return codex(_that.command,_that.model,_that.thinking,_that.systemPrompt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function(@JsonKey(name: 'api_key')  String apiKey, @JsonKey(name: 'base_url')  String baseUrl,  String model, @JsonKey(name: 'system_prompt')  String systemPrompt)  openAi,required TResult Function(@JsonKey(name: 'api_key')  String apiKey, @JsonKey(name: 'base_url')  String baseUrl,  String model, @JsonKey(name: 'system_prompt')  String systemPrompt)  openAiCompatible,required TResult Function(@JsonKey(name: 'api_key')  String apiKey, @JsonKey(name: 'base_url')  String baseUrl,  String model,  bool thinking, @JsonKey(name: 'system_prompt')  String systemPrompt)  anthropic,required TResult Function(@JsonKey(name: 'api_key')  String apiKey, @JsonKey(name: 'base_url')  String baseUrl,  String model,  bool thinking, @JsonKey(name: 'system_prompt')  String systemPrompt)  google,required TResult Function(@JsonKey(name: 'api_key')  String apiKey, @JsonKey(name: 'base_url')  String baseUrl,  String model,  bool thinking, @JsonKey(name: 'system_prompt')  String systemPrompt)  deepSeek,required TResult Function( String command, @JsonKey(name: 'system_prompt')  String systemPrompt)  acp,required TResult Function( String command,  String model,  bool thinking, @JsonKey(name: 'system_prompt')  String systemPrompt)  codex,}) {final _that = this;
switch (_that) {
case OpenAiConfig():
return openAi(_that.apiKey,_that.baseUrl,_that.model,_that.systemPrompt);case OpenAiCompatibleConfig():
return openAiCompatible(_that.apiKey,_that.baseUrl,_that.model,_that.systemPrompt);case AnthropicConfig():
return anthropic(_that.apiKey,_that.baseUrl,_that.model,_that.thinking,_that.systemPrompt);case GeminiConfig():
return google(_that.apiKey,_that.baseUrl,_that.model,_that.thinking,_that.systemPrompt);case DeepSeekConfig():
return deepSeek(_that.apiKey,_that.baseUrl,_that.model,_that.thinking,_that.systemPrompt);case AcpConfig():
return acp(_that.command,_that.systemPrompt);case CodexConfig():
return codex(_that.command,_that.model,_that.thinking,_that.systemPrompt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function(@JsonKey(name: 'api_key')  String apiKey, @JsonKey(name: 'base_url')  String baseUrl,  String model, @JsonKey(name: 'system_prompt')  String systemPrompt)?  openAi,TResult? Function(@JsonKey(name: 'api_key')  String apiKey, @JsonKey(name: 'base_url')  String baseUrl,  String model, @JsonKey(name: 'system_prompt')  String systemPrompt)?  openAiCompatible,TResult? Function(@JsonKey(name: 'api_key')  String apiKey, @JsonKey(name: 'base_url')  String baseUrl,  String model,  bool thinking, @JsonKey(name: 'system_prompt')  String systemPrompt)?  anthropic,TResult? Function(@JsonKey(name: 'api_key')  String apiKey, @JsonKey(name: 'base_url')  String baseUrl,  String model,  bool thinking, @JsonKey(name: 'system_prompt')  String systemPrompt)?  google,TResult? Function(@JsonKey(name: 'api_key')  String apiKey, @JsonKey(name: 'base_url')  String baseUrl,  String model,  bool thinking, @JsonKey(name: 'system_prompt')  String systemPrompt)?  deepSeek,TResult? Function( String command, @JsonKey(name: 'system_prompt')  String systemPrompt)?  acp,TResult? Function( String command,  String model,  bool thinking, @JsonKey(name: 'system_prompt')  String systemPrompt)?  codex,}) {final _that = this;
switch (_that) {
case OpenAiConfig() when openAi != null:
return openAi(_that.apiKey,_that.baseUrl,_that.model,_that.systemPrompt);case OpenAiCompatibleConfig() when openAiCompatible != null:
return openAiCompatible(_that.apiKey,_that.baseUrl,_that.model,_that.systemPrompt);case AnthropicConfig() when anthropic != null:
return anthropic(_that.apiKey,_that.baseUrl,_that.model,_that.thinking,_that.systemPrompt);case GeminiConfig() when google != null:
return google(_that.apiKey,_that.baseUrl,_that.model,_that.thinking,_that.systemPrompt);case DeepSeekConfig() when deepSeek != null:
return deepSeek(_that.apiKey,_that.baseUrl,_that.model,_that.thinking,_that.systemPrompt);case AcpConfig() when acp != null:
return acp(_that.command,_that.systemPrompt);case CodexConfig() when codex != null:
return codex(_that.command,_that.model,_that.thinking,_that.systemPrompt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class OpenAiConfig extends LlmClientConfig {
  const OpenAiConfig({@JsonKey(name: 'api_key') required this.apiKey, @JsonKey(name: 'base_url') this.baseUrl = 'https://api.openai.com/v1', this.model = 'gpt-5-mini', @JsonKey(name: 'system_prompt') this.systemPrompt = '', final  String? $type}): $type = $type ?? 'openai',super._();
  factory OpenAiConfig.fromJson(Map<String, dynamic> json) => _$OpenAiConfigFromJson(json);

@JsonKey(name: 'api_key') final  String apiKey;
@JsonKey(name: 'base_url') final  String baseUrl;
@JsonKey() final  String model;
@override@JsonKey(name: 'system_prompt') final  String systemPrompt;

@JsonKey(name: 'provider')
final String $type;


/// Create a copy of LlmClientConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenAiConfigCopyWith<OpenAiConfig> get copyWith => _$OpenAiConfigCopyWithImpl<OpenAiConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OpenAiConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenAiConfig&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.model, model) || other.model == model)&&(identical(other.systemPrompt, systemPrompt) || other.systemPrompt == systemPrompt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,apiKey,baseUrl,model,systemPrompt);

@override
String toString() {
  return 'LlmClientConfig.openAi(apiKey: $apiKey, baseUrl: $baseUrl, model: $model, systemPrompt: $systemPrompt)';
}


}

/// @nodoc
abstract mixin class $OpenAiConfigCopyWith<$Res> implements $LlmClientConfigCopyWith<$Res> {
  factory $OpenAiConfigCopyWith(OpenAiConfig value, $Res Function(OpenAiConfig) _then) = _$OpenAiConfigCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'api_key') String apiKey,@JsonKey(name: 'base_url') String baseUrl, String model,@JsonKey(name: 'system_prompt') String systemPrompt
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
@override @pragma('vm:prefer-inline') $Res call({Object? apiKey = null,Object? baseUrl = null,Object? model = null,Object? systemPrompt = null,}) {
  return _then(OpenAiConfig(
apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,systemPrompt: null == systemPrompt ? _self.systemPrompt : systemPrompt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class OpenAiCompatibleConfig extends LlmClientConfig {
  const OpenAiCompatibleConfig({@JsonKey(name: 'api_key') this.apiKey = '', @JsonKey(name: 'base_url') this.baseUrl = '', this.model = '', @JsonKey(name: 'system_prompt') this.systemPrompt = '', final  String? $type}): $type = $type ?? 'openai-compatible',super._();
  factory OpenAiCompatibleConfig.fromJson(Map<String, dynamic> json) => _$OpenAiCompatibleConfigFromJson(json);

@JsonKey(name: 'api_key') final  String apiKey;
@JsonKey(name: 'base_url') final  String baseUrl;
@JsonKey() final  String model;
@override@JsonKey(name: 'system_prompt') final  String systemPrompt;

@JsonKey(name: 'provider')
final String $type;


/// Create a copy of LlmClientConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenAiCompatibleConfigCopyWith<OpenAiCompatibleConfig> get copyWith => _$OpenAiCompatibleConfigCopyWithImpl<OpenAiCompatibleConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OpenAiCompatibleConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenAiCompatibleConfig&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.model, model) || other.model == model)&&(identical(other.systemPrompt, systemPrompt) || other.systemPrompt == systemPrompt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,apiKey,baseUrl,model,systemPrompt);

@override
String toString() {
  return 'LlmClientConfig.openAiCompatible(apiKey: $apiKey, baseUrl: $baseUrl, model: $model, systemPrompt: $systemPrompt)';
}


}

/// @nodoc
abstract mixin class $OpenAiCompatibleConfigCopyWith<$Res> implements $LlmClientConfigCopyWith<$Res> {
  factory $OpenAiCompatibleConfigCopyWith(OpenAiCompatibleConfig value, $Res Function(OpenAiCompatibleConfig) _then) = _$OpenAiCompatibleConfigCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'api_key') String apiKey,@JsonKey(name: 'base_url') String baseUrl, String model,@JsonKey(name: 'system_prompt') String systemPrompt
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
@override @pragma('vm:prefer-inline') $Res call({Object? apiKey = null,Object? baseUrl = null,Object? model = null,Object? systemPrompt = null,}) {
  return _then(OpenAiCompatibleConfig(
apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,systemPrompt: null == systemPrompt ? _self.systemPrompt : systemPrompt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class AnthropicConfig extends LlmClientConfig {
  const AnthropicConfig({@JsonKey(name: 'api_key') required this.apiKey, @JsonKey(name: 'base_url') this.baseUrl = 'https://api.anthropic.com', this.model = 'claude-sonnet-5', this.thinking = true, @JsonKey(name: 'system_prompt') this.systemPrompt = '', final  String? $type}): $type = $type ?? 'anthropic',super._();
  factory AnthropicConfig.fromJson(Map<String, dynamic> json) => _$AnthropicConfigFromJson(json);

@JsonKey(name: 'api_key') final  String apiKey;
@JsonKey(name: 'base_url') final  String baseUrl;
@JsonKey() final  String model;
/// Whether to request thinking and stream it back.
@JsonKey() final  bool thinking;
@override@JsonKey(name: 'system_prompt') final  String systemPrompt;

@JsonKey(name: 'provider')
final String $type;


/// Create a copy of LlmClientConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnthropicConfigCopyWith<AnthropicConfig> get copyWith => _$AnthropicConfigCopyWithImpl<AnthropicConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnthropicConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnthropicConfig&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.model, model) || other.model == model)&&(identical(other.thinking, thinking) || other.thinking == thinking)&&(identical(other.systemPrompt, systemPrompt) || other.systemPrompt == systemPrompt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,apiKey,baseUrl,model,thinking,systemPrompt);

@override
String toString() {
  return 'LlmClientConfig.anthropic(apiKey: $apiKey, baseUrl: $baseUrl, model: $model, thinking: $thinking, systemPrompt: $systemPrompt)';
}


}

/// @nodoc
abstract mixin class $AnthropicConfigCopyWith<$Res> implements $LlmClientConfigCopyWith<$Res> {
  factory $AnthropicConfigCopyWith(AnthropicConfig value, $Res Function(AnthropicConfig) _then) = _$AnthropicConfigCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'api_key') String apiKey,@JsonKey(name: 'base_url') String baseUrl, String model, bool thinking,@JsonKey(name: 'system_prompt') String systemPrompt
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
@override @pragma('vm:prefer-inline') $Res call({Object? apiKey = null,Object? baseUrl = null,Object? model = null,Object? thinking = null,Object? systemPrompt = null,}) {
  return _then(AnthropicConfig(
apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,thinking: null == thinking ? _self.thinking : thinking // ignore: cast_nullable_to_non_nullable
as bool,systemPrompt: null == systemPrompt ? _self.systemPrompt : systemPrompt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class GeminiConfig extends LlmClientConfig {
  const GeminiConfig({@JsonKey(name: 'api_key') required this.apiKey, @JsonKey(name: 'base_url') this.baseUrl = 'https://generativelanguage.googleapis.com', this.model = 'gemini-2.5-flash', this.thinking = true, @JsonKey(name: 'system_prompt') this.systemPrompt = '', final  String? $type}): $type = $type ?? 'google',super._();
  factory GeminiConfig.fromJson(Map<String, dynamic> json) => _$GeminiConfigFromJson(json);

@JsonKey(name: 'api_key') final  String apiKey;
@JsonKey(name: 'base_url') final  String baseUrl;
@JsonKey() final  String model;
/// Whether to request the model's thoughts in the response.
@JsonKey() final  bool thinking;
@override@JsonKey(name: 'system_prompt') final  String systemPrompt;

@JsonKey(name: 'provider')
final String $type;


/// Create a copy of LlmClientConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeminiConfigCopyWith<GeminiConfig> get copyWith => _$GeminiConfigCopyWithImpl<GeminiConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GeminiConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeminiConfig&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.model, model) || other.model == model)&&(identical(other.thinking, thinking) || other.thinking == thinking)&&(identical(other.systemPrompt, systemPrompt) || other.systemPrompt == systemPrompt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,apiKey,baseUrl,model,thinking,systemPrompt);

@override
String toString() {
  return 'LlmClientConfig.google(apiKey: $apiKey, baseUrl: $baseUrl, model: $model, thinking: $thinking, systemPrompt: $systemPrompt)';
}


}

/// @nodoc
abstract mixin class $GeminiConfigCopyWith<$Res> implements $LlmClientConfigCopyWith<$Res> {
  factory $GeminiConfigCopyWith(GeminiConfig value, $Res Function(GeminiConfig) _then) = _$GeminiConfigCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'api_key') String apiKey,@JsonKey(name: 'base_url') String baseUrl, String model, bool thinking,@JsonKey(name: 'system_prompt') String systemPrompt
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
@override @pragma('vm:prefer-inline') $Res call({Object? apiKey = null,Object? baseUrl = null,Object? model = null,Object? thinking = null,Object? systemPrompt = null,}) {
  return _then(GeminiConfig(
apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,thinking: null == thinking ? _self.thinking : thinking // ignore: cast_nullable_to_non_nullable
as bool,systemPrompt: null == systemPrompt ? _self.systemPrompt : systemPrompt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class DeepSeekConfig extends LlmClientConfig {
  const DeepSeekConfig({@JsonKey(name: 'api_key') required this.apiKey, @JsonKey(name: 'base_url') this.baseUrl = 'https://api.deepseek.com', this.model = 'deepseek-chat', this.thinking = true, @JsonKey(name: 'system_prompt') this.systemPrompt = '', final  String? $type}): $type = $type ?? 'deepseek',super._();
  factory DeepSeekConfig.fromJson(Map<String, dynamic> json) => _$DeepSeekConfigFromJson(json);

@JsonKey(name: 'api_key') final  String apiKey;
@JsonKey(name: 'base_url') final  String baseUrl;
@JsonKey() final  String model;
/// Whether to surface `reasoning_content` (reasoning models only; the
/// API has no request parameter, so this filters the response stream).
@JsonKey() final  bool thinking;
@override@JsonKey(name: 'system_prompt') final  String systemPrompt;

@JsonKey(name: 'provider')
final String $type;


/// Create a copy of LlmClientConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeepSeekConfigCopyWith<DeepSeekConfig> get copyWith => _$DeepSeekConfigCopyWithImpl<DeepSeekConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeepSeekConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeepSeekConfig&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.model, model) || other.model == model)&&(identical(other.thinking, thinking) || other.thinking == thinking)&&(identical(other.systemPrompt, systemPrompt) || other.systemPrompt == systemPrompt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,apiKey,baseUrl,model,thinking,systemPrompt);

@override
String toString() {
  return 'LlmClientConfig.deepSeek(apiKey: $apiKey, baseUrl: $baseUrl, model: $model, thinking: $thinking, systemPrompt: $systemPrompt)';
}


}

/// @nodoc
abstract mixin class $DeepSeekConfigCopyWith<$Res> implements $LlmClientConfigCopyWith<$Res> {
  factory $DeepSeekConfigCopyWith(DeepSeekConfig value, $Res Function(DeepSeekConfig) _then) = _$DeepSeekConfigCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'api_key') String apiKey,@JsonKey(name: 'base_url') String baseUrl, String model, bool thinking,@JsonKey(name: 'system_prompt') String systemPrompt
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
@override @pragma('vm:prefer-inline') $Res call({Object? apiKey = null,Object? baseUrl = null,Object? model = null,Object? thinking = null,Object? systemPrompt = null,}) {
  return _then(DeepSeekConfig(
apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,thinking: null == thinking ? _self.thinking : thinking // ignore: cast_nullable_to_non_nullable
as bool,systemPrompt: null == systemPrompt ? _self.systemPrompt : systemPrompt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class AcpConfig extends LlmClientConfig {
  const AcpConfig({this.command = '', @JsonKey(name: 'system_prompt') this.systemPrompt = '', final  String? $type}): $type = $type ?? 'acp',super._();
  factory AcpConfig.fromJson(Map<String, dynamic> json) => _$AcpConfigFromJson(json);

@JsonKey() final  String command;
@override@JsonKey(name: 'system_prompt') final  String systemPrompt;

@JsonKey(name: 'provider')
final String $type;


/// Create a copy of LlmClientConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AcpConfigCopyWith<AcpConfig> get copyWith => _$AcpConfigCopyWithImpl<AcpConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AcpConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AcpConfig&&(identical(other.command, command) || other.command == command)&&(identical(other.systemPrompt, systemPrompt) || other.systemPrompt == systemPrompt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,command,systemPrompt);

@override
String toString() {
  return 'LlmClientConfig.acp(command: $command, systemPrompt: $systemPrompt)';
}


}

/// @nodoc
abstract mixin class $AcpConfigCopyWith<$Res> implements $LlmClientConfigCopyWith<$Res> {
  factory $AcpConfigCopyWith(AcpConfig value, $Res Function(AcpConfig) _then) = _$AcpConfigCopyWithImpl;
@override @useResult
$Res call({
 String command,@JsonKey(name: 'system_prompt') String systemPrompt
});




}
/// @nodoc
class _$AcpConfigCopyWithImpl<$Res>
    implements $AcpConfigCopyWith<$Res> {
  _$AcpConfigCopyWithImpl(this._self, this._then);

  final AcpConfig _self;
  final $Res Function(AcpConfig) _then;

/// Create a copy of LlmClientConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? command = null,Object? systemPrompt = null,}) {
  return _then(AcpConfig(
command: null == command ? _self.command : command // ignore: cast_nullable_to_non_nullable
as String,systemPrompt: null == systemPrompt ? _self.systemPrompt : systemPrompt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class CodexConfig extends LlmClientConfig {
  const CodexConfig({this.command = 'codex app-server', this.model = '', this.thinking = true, @JsonKey(name: 'system_prompt') this.systemPrompt = '', final  String? $type}): $type = $type ?? 'codex',super._();
  factory CodexConfig.fromJson(Map<String, dynamic> json) => _$CodexConfigFromJson(json);

@JsonKey() final  String command;
@JsonKey() final  String model;
/// Whether to stream reasoning summaries back (Codex models always
/// reason; this only controls whether the reasoning is shown).
@JsonKey() final  bool thinking;
@override@JsonKey(name: 'system_prompt') final  String systemPrompt;

@JsonKey(name: 'provider')
final String $type;


/// Create a copy of LlmClientConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CodexConfigCopyWith<CodexConfig> get copyWith => _$CodexConfigCopyWithImpl<CodexConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CodexConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CodexConfig&&(identical(other.command, command) || other.command == command)&&(identical(other.model, model) || other.model == model)&&(identical(other.thinking, thinking) || other.thinking == thinking)&&(identical(other.systemPrompt, systemPrompt) || other.systemPrompt == systemPrompt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,command,model,thinking,systemPrompt);

@override
String toString() {
  return 'LlmClientConfig.codex(command: $command, model: $model, thinking: $thinking, systemPrompt: $systemPrompt)';
}


}

/// @nodoc
abstract mixin class $CodexConfigCopyWith<$Res> implements $LlmClientConfigCopyWith<$Res> {
  factory $CodexConfigCopyWith(CodexConfig value, $Res Function(CodexConfig) _then) = _$CodexConfigCopyWithImpl;
@override @useResult
$Res call({
 String command, String model, bool thinking,@JsonKey(name: 'system_prompt') String systemPrompt
});




}
/// @nodoc
class _$CodexConfigCopyWithImpl<$Res>
    implements $CodexConfigCopyWith<$Res> {
  _$CodexConfigCopyWithImpl(this._self, this._then);

  final CodexConfig _self;
  final $Res Function(CodexConfig) _then;

/// Create a copy of LlmClientConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? command = null,Object? model = null,Object? thinking = null,Object? systemPrompt = null,}) {
  return _then(CodexConfig(
command: null == command ? _self.command : command // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,thinking: null == thinking ? _self.thinking : thinking // ignore: cast_nullable_to_non_nullable
as bool,systemPrompt: null == systemPrompt ? _self.systemPrompt : systemPrompt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
