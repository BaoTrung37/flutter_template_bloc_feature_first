import 'package:dartz/dartz.dart';
import 'package:example_flutter_app/features/auth/data/models/user_model.dart';
import 'package:example_flutter_app/features/auth/domain/repository/authentication_repository.dart';
import 'package:example_flutter_app/shared_domain/lib/src/entities/user_entity.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  @override
  Future<Either<void, UserEntity>> login() async {
    final userModel = UserModel(userId: 0, name: 'name');
    return Future.value(Right(userModel.toEntity()));
  }
}
