
import 'package:freezed_annotation/freezed_annotation.dart';
part 'answer.freezed.dart';

@freezed
class Answer with _$Answer{
  const factory Answer({
    required int playerNumber,
    required String answer,
  }) = _Answer;
}