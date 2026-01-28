# Feature Structure Documentation

Đây là cấu trúc chuẩn cho một Feature trong dự án, áp dụng kiến trúc **Clean Architecture** kết hợp với **Feature-First**.

## Sơ đồ kiến trúc (Dependency Rule)

```mermaid
graph TD
    P[Presentation Layer] --> A[Application Layer]
    P --> D[Domain Layer]
    A --> D
    Data[Data Layer] --> D
    Data --> I[Infrastructure Core]
    
    subgraph Feature
    P
    A
    D
    Data
    end
    
    subgraph Core
    I
    end
```

> **Nguyên tắc quan trọng**: `Domain Layer` ở trung tâm và không được phụ thuộc vào bất kỳ layer nào khác.

## Các thành phần

Mỗi feature được chia thành các layer rõ ràng:

1.  **[Presentation](presentation/presentation.md)**
    *   Chứa UI (Pages, Widgets).
    *   Nhận input từ user và hiển thị data.
    
2.  **[Application](application/application.md)**
    *   State Management (Bloc/Cubit).
    *   Điều phối logic giữa UI và Domain.
    
3.  **[Domain](domain/domain.md)**
    *   **Lõi của Feature**.
    *   Chứa Entities, Value Objects, Failures.
    *   Định nghĩa Repository Interfaces (Contracts).
    
4.  **[Data](data/data.md)**
    *   Quản lý dữ liệu nghiệp vụ (business data).
    *   Repository Implementations.
    *   Data Sources, DTOs, Mappers.
    *   Sử dụng Infrastructure để lấy/gửi dữ liệu.

5.  **[Core](core/core.md)**
    *   Các tiện ích (Utils, Extensions) dùng riêng cho feature này.

## Infrastructure (Core)

Infrastructure không nằm trong feature mà nằm ở `lib/core/infrastructure`:

- **[Infrastructure](../../core/infrastructure/)** (Core)
  - Công cụ kỹ thuật (HTTP client, Storage adapters).
  - Không biết về business logic.
  - Có thể tái sử dụng cho mọi feature.

## Luồng dữ liệu (Data Flow)

1.  **UI** gửi Event -> **Application** (Bloc).
2.  **Bloc** gọi **Domain** (UseCase/Repository Interface).
3.  **Data** (Repository Impl) sử dụng **Infrastructure** (ApiClient, Hive) để lấy data.
4.  **Data** parse JSON -> DTO, map DTO -> **Entity**.
5.  **Data** xử lý errors, trả về **Entity** hoặc **Failure** cho **Bloc**.
6.  **Bloc** nhận kết quả, emit **State** mới.
7.  **UI** rebuild theo **State**.
