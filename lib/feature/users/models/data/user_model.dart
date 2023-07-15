import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class UserModel {
  UserModel({
    required this.email,
    required this.fullname,
    this.id,
    this.password,
  });

  /// from json converter
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  final int? id ;
  final String email;
  final String fullname;
  final String? password;

  /// to json converter
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
