# Data Layer

Layer này quản lý **dữ liệu nghiệp vụ** bằng cách sử dụng các công cụ từ Infrastructure. Data Layer **HIỂU** về business logic.

> **Câu hỏi trả lời**: "Lấy dữ liệu gì?"

## Cấu trúc

- **Repository Implementations**:
  - Implement các interface `IRepository` từ Domain.
  - Điều phối giữa Remote và Local data sources.
  - Quyết định cache strategy, data sync logic.
- **Data Sources**:
  - `Remote`: Sử dụng Infrastructure (ApiClient) để gọi API endpoints cụ thể.
  - `Local`: Sử dụng Infrastructure (Hive, SharedPreferences) để lưu/đọc dữ liệu.
- **DTOs (Data Transfer Objects)**:
  - Models để parse JSON từ API.
  - Models để lưu trữ vào database local.
- **Mappers**:
  - Chuyển đổi giữa DTO ↔ Entity.
  - Logic mapping giữa các data models.

## Nhiệm vụ

- Implement Repository interfaces từ Domain.
- Sử dụng Infrastructure để lấy/gửi dữ liệu nghiệp vụ.
- Parse JSON thành DTOs.
- Chuyển đổi DTOs sang Entities (và ngược lại).
- Xử lý business data logic (caching, syncing, offline-first).
- Map technical errors thành Domain Failures.

## Quy tắc

- Data Layer **BIẾT** về business entities (User, Product, Order, etc.).
- Data Layer **phụ thuộc** vào Domain (để biết interfaces và entities).
- Data Layer **phụ thuộc** vào Infrastructure (để sử dụng HTTP client, storage).
- Nằm trong từng feature: `lib/features/{feature_name}/data`.
- Chứa business logic liên quan đến data (caching strategy, sync logic).

## Ví dụ cấu trúc

```text
features/auth/data/
├── repositories/
│   └── auth_repository_impl.dart    # Implement IAuthRepository
├── datasources/
│   ├── remote/
│   │   └── auth_remote_datasource.dart  # Sử dụng ApiClient
│   └── local/
│       └── auth_local_datasource.dart   # Sử dụng Hive
├── dtos/
│   └── user_dto.dart
└── mappers/
    └── user_mapper.dart
```

## Ví dụ code

```dart
// ✅ ĐÚNG: Data Layer biết về User và sử dụng Infrastructure
class AuthRemoteDataSource {
  final ApiClient apiClient; // Từ Infrastructure
  
  Future<UserDto> login(String email, String password) async {
    final response = await apiClient.post('/auth/login', {
      'email': email,
      'password': password,
    });
    return UserDto.fromJson(response.data);
  }
}

// ✅ ĐÚNG: Repository implement interface từ Domain
class AuthRepositoryImpl implements IAuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  
  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final userDto = await remoteDataSource.login(email, password);
      final user = UserMapper.toEntity(userDto);
      await localDataSource.cacheUser(user); // Business logic: caching
      return Right(user);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
```
