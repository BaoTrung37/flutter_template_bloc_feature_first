# Infrastructure Layer
Layer này chịu trách nhiệm triển khai (implementation) các contract được định nghĩa ở `Domain Layer` và giao tiếp với thế giới bên ngoài (API, DB, Device).

## Cấu trúc
- **Repositories**: Triển khai các interface `IRepository` từ `Domain`.
- **Data Sources**:
  - `Remote`: Gọi API (Retrofit, Dio).
  - `Local`: Lưu trữ local (Hive, SharedPreferences, SQLite).
- **DTOs (Data Transfer Objects)**: Các model dùng để parse JSON từ API. DTOs sẽ được map sang Entities của Domain.

## Nhiệm vụ
- Lấy dữ liệu raw (JSON) từ API/Local.
- Chuyển đổi (Map) DTO -> Entity.
- Xử lý các lỗi kỹ thuật (Network error, Server error) và map chúng thành Domain Failures.

## Quy tắc
- Đây là nơi duy nhất được biết về các thư viện 3rd party liên quan đến data (như Dio, Hive).
- Infrastructure phụ thuộc vào Domain (để biết interface cần implement và entity cần trả về).

