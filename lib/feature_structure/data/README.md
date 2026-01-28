# Data Layer

Layer này quản lý **dữ liệu nghiệp vụ** bằng cách sử dụng các công cụ từ Infrastructure. Data Layer **HIỂU** về business logic.

> **Câu hỏi trả lời**: "Lấy dữ liệu gì?"

## Cấu trúc thư mục

- **`repositories/`**:
  - Chứa các class implement interfaces `IRepository` từ Domain Layer.
  - Là nơi duy nhất Domain Layer tương tác gián tiếp để lấy dữ liệu.
  - Xử lý logic chọn nguồn dữ liệu (Remote hay Local), caching, parsing lỗi.

- **`datasources/`**:
  - `remote/`: Chứa các class gọi API (dùng Dio/Retrofit/Http).
  - `local/`: Chứa các class truy xuất Database, SharedPreferences, File.
  - Các class ở đây thường throw Exception, không return Failure/Either.

- **`models/`** (DTOs - Data Transfer Objects):
  - Chứa các class ánh xạ dữ liệu thô (JSON, Table).
  - Có các hàm `fromJson`, `toJson`, `toEntity`, `fromEntity`.
  - Ví dụ: `UserModel`, `ProductModel`.

## Nhiệm vụ

- Implement Repository interfaces từ Domain.
- Sử dụng Infrastructure (từ `lib/core/infrastructure`) để thực hiện request.
- Parse JSON thành Models.
- Chuyển đổi Models sang Entities để trả về cho Domain.
- Map technical errors (Exception) thành Domain Failures.

## Quy tắc

- Data Layer **BIẾT** về business entities (User, Product...).
- Data Layer **phụ thuộc** vào Domain (để biết interfaces và entities).
- Data Layer **phụ thuộc** vào Infrastructure (để sử dụng HTTP client, storage).
- Các class trong `models` không được sử dụng trong Domain Layer.

## Ví dụ

```dart
// datasources/remote/user_remote_datasource.dart
class UserRemoteDataSource {
  final ApiClient apiClient;
  Future<UserModel> getUser(String id) async { ... }
}

// repositories/user_repository_impl.dart
class UserRepositoryImpl implements IUserRepository {
  final UserRemoteDataSource remote;
  @override
  Future<Either<Failure, User>> getUser(String id) async {
    try {
      final model = await remote.getUser(id);
      return Right(model.toEntity());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
```
