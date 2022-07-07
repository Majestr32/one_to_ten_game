// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'game_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GameSettings {
  GameInfo get info => throw _privateConstructorUsedError;
  int get playersCount => throw _privateConstructorUsedError;
  int get roundsCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameSettingsCopyWith<GameSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameSettingsCopyWith<$Res> {
  factory $GameSettingsCopyWith(
          GameSettings value, $Res Function(GameSettings) then) =
      _$GameSettingsCopyWithImpl<$Res>;
  $Res call({GameInfo info, int playersCount, int roundsCount});
}

/// @nodoc
class _$GameSettingsCopyWithImpl<$Res> implements $GameSettingsCopyWith<$Res> {
  _$GameSettingsCopyWithImpl(this._value, this._then);

  final GameSettings _value;
  // ignore: unused_field
  final $Res Function(GameSettings) _then;

  @override
  $Res call({
    Object? info = freezed,
    Object? playersCount = freezed,
    Object? roundsCount = freezed,
  }) {
    return _then(_value.copyWith(
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as GameInfo,
      playersCount: playersCount == freezed
          ? _value.playersCount
          : playersCount // ignore: cast_nullable_to_non_nullable
              as int,
      roundsCount: roundsCount == freezed
          ? _value.roundsCount
          : roundsCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_GameSettingsCopyWith<$Res>
    implements $GameSettingsCopyWith<$Res> {
  factory _$$_GameSettingsCopyWith(
          _$_GameSettings value, $Res Function(_$_GameSettings) then) =
      __$$_GameSettingsCopyWithImpl<$Res>;
  @override
  $Res call({GameInfo info, int playersCount, int roundsCount});
}

/// @nodoc
class __$$_GameSettingsCopyWithImpl<$Res>
    extends _$GameSettingsCopyWithImpl<$Res>
    implements _$$_GameSettingsCopyWith<$Res> {
  __$$_GameSettingsCopyWithImpl(
      _$_GameSettings _value, $Res Function(_$_GameSettings) _then)
      : super(_value, (v) => _then(v as _$_GameSettings));

  @override
  _$_GameSettings get _value => super._value as _$_GameSettings;

  @override
  $Res call({
    Object? info = freezed,
    Object? playersCount = freezed,
    Object? roundsCount = freezed,
  }) {
    return _then(_$_GameSettings(
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as GameInfo,
      playersCount: playersCount == freezed
          ? _value.playersCount
          : playersCount // ignore: cast_nullable_to_non_nullable
              as int,
      roundsCount: roundsCount == freezed
          ? _value.roundsCount
          : roundsCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_GameSettings implements _GameSettings {
  const _$_GameSettings(
      {required this.info, this.playersCount = 4, this.roundsCount = 3});

  @override
  final GameInfo info;
  @override
  @JsonKey()
  final int playersCount;
  @override
  @JsonKey()
  final int roundsCount;

  @override
  String toString() {
    return 'GameSettings(info: $info, playersCount: $playersCount, roundsCount: $roundsCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GameSettings &&
            const DeepCollectionEquality().equals(other.info, info) &&
            const DeepCollectionEquality()
                .equals(other.playersCount, playersCount) &&
            const DeepCollectionEquality()
                .equals(other.roundsCount, roundsCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(info),
      const DeepCollectionEquality().hash(playersCount),
      const DeepCollectionEquality().hash(roundsCount));

  @JsonKey(ignore: true)
  @override
  _$$_GameSettingsCopyWith<_$_GameSettings> get copyWith =>
      __$$_GameSettingsCopyWithImpl<_$_GameSettings>(this, _$identity);
}

abstract class _GameSettings implements GameSettings {
  const factory _GameSettings(
      {required final GameInfo info,
      final int playersCount,
      final int roundsCount}) = _$_GameSettings;

  @override
  GameInfo get info => throw _privateConstructorUsedError;
  @override
  int get playersCount => throw _privateConstructorUsedError;
  @override
  int get roundsCount => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_GameSettingsCopyWith<_$_GameSettings> get copyWith =>
      throw _privateConstructorUsedError;
}
