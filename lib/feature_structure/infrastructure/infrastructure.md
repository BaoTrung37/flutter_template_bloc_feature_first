# Infrastructure Layer

Layer này cung cấp **công cụ kỹ thuật** và thư viện 3rd party để ứng dụng giao tiếp với thế giới bên ngoài. Infrastructure **KHÔNG biết** về business logic.

> **Câu hỏi trả lời**: "Làm thế nào để kết nối?"

## Cấu trúc

- **HTTP Client**:
  - Dio configuration
  - Interceptors (logging, auth token)
  - SSL pinning
- **Local Storage**:
  - Hive adapters
  - SharedPreferences wrapper
  - Secure storage
- **External Services**:
  - Firebase services
  - Analytics
  - Logging
- **Network Utilities**:
  - Connectivity checker
  - Network error handler

## Nhiệm vụ

- Cung cấp HTTP client đã được config sẵn.
- Cung cấp local storage adapters.
- Cung cấp external service wrappers.
- Xử lý các vấn đề kỹ thuật cấp thấp (SSL, interceptors, connectivity).

## Quy tắc

- **KHÔNG biết** về business entities (User, Product, Order, etc.).
- Chỉ biết về kỹ thuật: HTTP, JSON, Storage, Network.
- Có thể tái sử dụng cho **bất kỳ feature nào**.
- Thường nằm ở `lib/core/infrastructure`.
- Không implement Repository hay Data Source của feature cụ thể.

## Ví dụ cấu trúc

```text
lib/core/infrastructure/
├── network/
│   ├── client/
│   │   └── api_client.dart          # Dio + Retrofit client
│   ├── interceptors/
│   │   ├── auth_interceptor.dart
│   │   └── logging_interceptor.dart
│   └── connectivity/
│       └── connectivity_checker.dart
├── storage/
│   ├── hive_adapter.dart
│   └── secure_storage.dart
└── services/
    ├── firebase_service.dart
    └── analytics_service.dart
```

## Ví dụ code

```dart
// ✅ ĐÚNG: Infrastructure không biết về User
class ApiClient {
  final Dio dio;
  
  Future<Response> get(String path) => dio.get(path);
  Future<Response> post(String path, dynamic data) => dio.post(path, data: data);
}
// ❌ SAI: Infrastructure không nên biết về User entity
class ApiClient {
  Future<User> getUser(String id) => ...; // SAI!  }
}
```
