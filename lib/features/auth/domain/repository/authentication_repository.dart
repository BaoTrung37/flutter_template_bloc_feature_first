import 'package:dartz/dartz.dart';
import 'package:example_flutter_app/shared_domain/lib/src/entities/user_entity.dart';

abstract class IAuthenticationRepository {
  Future<Either<void, UserEntity>> login();
}
