// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'sub_question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SubQuestion _$SubQuestionFromJson(Map<String, dynamic> json) {
  return _SubQuestion.fromJson(json);
}

/// @nodoc
class _$SubQuestionTearOff {
  const _$SubQuestionTearOff();

  _SubQuestion call(
      {required String id,
      required int qNo,
      int? mainQNo,
      required String title,
      required String description,
      required String answer,
      required DateTime dateTime,
      @JsonKey(nullable: true, defaultValue: false) bool? isExpanable}) {
    return _SubQuestion(
      id: id,
      qNo: qNo,
      mainQNo: mainQNo,
      title: title,
      description: description,
      answer: answer,
      dateTime: dateTime,
      isExpanable: isExpanable,
    );
  }

  SubQuestion fromJson(Map<String, Object?> json) {
    return SubQuestion.fromJson(json);
  }
}

/// @nodoc
const $SubQuestion = _$SubQuestionTearOff();

/// @nodoc
mixin _$SubQuestion {
  String get id => throw _privateConstructorUsedError;
  int get qNo => throw _privateConstructorUsedError;
  int? get mainQNo => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get answer => throw _privateConstructorUsedError;
  DateTime get dateTime => throw _privateConstructorUsedError;
  @JsonKey(nullable: true, defaultValue: false)
  bool? get isExpanable => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SubQuestionCopyWith<SubQuestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubQuestionCopyWith<$Res> {
  factory $SubQuestionCopyWith(
          SubQuestion value, $Res Function(SubQuestion) then) =
      _$SubQuestionCopyWithImpl<$Res>;
  $Res call(
      {String id,
      int qNo,
      int? mainQNo,
      String title,
      String description,
      String answer,
      DateTime dateTime,
      @JsonKey(nullable: true, defaultValue: false) bool? isExpanable});
}

/// @nodoc
class _$SubQuestionCopyWithImpl<$Res> implements $SubQuestionCopyWith<$Res> {
  _$SubQuestionCopyWithImpl(this._value, this._then);

  final SubQuestion _value;
  // ignore: unused_field
  final $Res Function(SubQuestion) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? qNo = freezed,
    Object? mainQNo = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? answer = freezed,
    Object? dateTime = freezed,
    Object? isExpanable = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      qNo: qNo == freezed
          ? _value.qNo
          : qNo // ignore: cast_nullable_to_non_nullable
              as int,
      mainQNo: mainQNo == freezed
          ? _value.mainQNo
          : mainQNo // ignore: cast_nullable_to_non_nullable
              as int?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      answer: answer == freezed
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: dateTime == freezed
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isExpanable: isExpanable == freezed
          ? _value.isExpanable
          : isExpanable // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
abstract class _$SubQuestionCopyWith<$Res>
    implements $SubQuestionCopyWith<$Res> {
  factory _$SubQuestionCopyWith(
          _SubQuestion value, $Res Function(_SubQuestion) then) =
      __$SubQuestionCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      int qNo,
      int? mainQNo,
      String title,
      String description,
      String answer,
      DateTime dateTime,
      @JsonKey(nullable: true, defaultValue: false) bool? isExpanable});
}

/// @nodoc
class __$SubQuestionCopyWithImpl<$Res> extends _$SubQuestionCopyWithImpl<$Res>
    implements _$SubQuestionCopyWith<$Res> {
  __$SubQuestionCopyWithImpl(
      _SubQuestion _value, $Res Function(_SubQuestion) _then)
      : super(_value, (v) => _then(v as _SubQuestion));

  @override
  _SubQuestion get _value => super._value as _SubQuestion;

  @override
  $Res call({
    Object? id = freezed,
    Object? qNo = freezed,
    Object? mainQNo = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? answer = freezed,
    Object? dateTime = freezed,
    Object? isExpanable = freezed,
  }) {
    return _then(_SubQuestion(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      qNo: qNo == freezed
          ? _value.qNo
          : qNo // ignore: cast_nullable_to_non_nullable
              as int,
      mainQNo: mainQNo == freezed
          ? _value.mainQNo
          : mainQNo // ignore: cast_nullable_to_non_nullable
              as int?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      answer: answer == freezed
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: dateTime == freezed
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isExpanable: isExpanable == freezed
          ? _value.isExpanable
          : isExpanable // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SubQuestion implements _SubQuestion {
  _$_SubQuestion(
      {required this.id,
      required this.qNo,
      this.mainQNo,
      required this.title,
      required this.description,
      required this.answer,
      required this.dateTime,
      @JsonKey(nullable: true, defaultValue: false) this.isExpanable});

  factory _$_SubQuestion.fromJson(Map<String, dynamic> json) =>
      _$$_SubQuestionFromJson(json);

  @override
  final String id;
  @override
  final int qNo;
  @override
  final int? mainQNo;
  @override
  final String title;
  @override
  final String description;
  @override
  final String answer;
  @override
  final DateTime dateTime;
  @override
  @JsonKey(nullable: true, defaultValue: false)
  final bool? isExpanable;

  @override
  String toString() {
    return 'SubQuestion(id: $id, qNo: $qNo, mainQNo: $mainQNo, title: $title, description: $description, answer: $answer, dateTime: $dateTime, isExpanable: $isExpanable)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SubQuestion &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.qNo, qNo) &&
            const DeepCollectionEquality().equals(other.mainQNo, mainQNo) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.answer, answer) &&
            const DeepCollectionEquality().equals(other.dateTime, dateTime) &&
            const DeepCollectionEquality()
                .equals(other.isExpanable, isExpanable));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(qNo),
      const DeepCollectionEquality().hash(mainQNo),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(answer),
      const DeepCollectionEquality().hash(dateTime),
      const DeepCollectionEquality().hash(isExpanable));

  @JsonKey(ignore: true)
  @override
  _$SubQuestionCopyWith<_SubQuestion> get copyWith =>
      __$SubQuestionCopyWithImpl<_SubQuestion>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SubQuestionToJson(this);
  }
}

abstract class _SubQuestion implements SubQuestion {
  factory _SubQuestion(
          {required String id,
          required int qNo,
          int? mainQNo,
          required String title,
          required String description,
          required String answer,
          required DateTime dateTime,
          @JsonKey(nullable: true, defaultValue: false) bool? isExpanable}) =
      _$_SubQuestion;

  factory _SubQuestion.fromJson(Map<String, dynamic> json) =
      _$_SubQuestion.fromJson;

  @override
  String get id;
  @override
  int get qNo;
  @override
  int? get mainQNo;
  @override
  String get title;
  @override
  String get description;
  @override
  String get answer;
  @override
  DateTime get dateTime;
  @override
  @JsonKey(nullable: true, defaultValue: false)
  bool? get isExpanable;
  @override
  @JsonKey(ignore: true)
  _$SubQuestionCopyWith<_SubQuestion> get copyWith =>
      throw _privateConstructorUsedError;
}
