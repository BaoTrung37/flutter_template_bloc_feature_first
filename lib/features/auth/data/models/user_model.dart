// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:example_flutter_app/shared_domain/lib/src/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  UserModel({required this.userId, required this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  final int userId;
  final String name;
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserEntity toEntity() => UserEntity(id: userId, name: name);
}
