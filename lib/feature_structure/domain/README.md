# Domain Layer

Layer này là **lõi của feature**, chứa toàn bộ Business Logic, quy tắc nghiệp vụ và định nghĩa dữ liệu. Nó hoàn toàn độc lập với UI, Database, API hay Framework.

## Cấu trúc thư mục

- **`entities/`**:
  - Chứa các Business Objects (ví dụ: `User`, `Product`).
  - Là dữ liệu thuần túy được sử dụng trong app.
  - Thường sử dụng `equatable` hoặc `freezed`.

- **`repositories/`**:
  - Chứa các **Interfaces** (Abstract Classes) định nghĩa các phương thức lấy/lưu dữ liệu.
  - Ví dụ: `IAuthRepository`, `IProductRepository`.
  - Giúp tách biệt Domain khỏi Data Layer (Dependency Inversion).

- **`usecases/`**:
  - Chứa các Business Logic cụ thể cho từng hành động của User.
  - Ví dụ: `LoginUseCase`, `GetProductDetailUseCase`.
  - Mỗi UseCase thường chỉ làm một nhiệm vụ duy nhất.

## Nhiệm vụ

- Định nghĩa **"Cái gì"** (What) hệ thống làm, không quan tâm **"Làm như thế nào"** (How).
- Chứa các quy tắc validation, tính toán nghiệp vụ.

## Quy tắc (Bắt buộc)

- **Pure Dart**: Không được import bất kỳ gói nào liên quan đến Flutter (material, cupertino, ui...), database, http...
- **Zero Dependencies**: Không được phụ thuộc vào Data, Presentation, Application hay Infrastructure.
- **Exceptions**: Không ném Exception, mà trả về object `Failure` (thường dùng `Either<Failure, Success>`).

## Ví dụ

```dart
// entities/user.dart
class User {
  final String id;
  final String name;
  User({required this.id, required this.name});
}

// repositories/i_user_repository.dart
abstract class IUserRepository {
  Future<Either<Failure, User>> getUser(String id);
}

// usecases/get_user_usecase.dart
class GetUserUseCase {
  final IUserRepository repository;
  GetUserUseCase(this.repository);

  Future<Either<Failure, User>> call(String id) {
    return repository.getUser(id);
  }
}
```
