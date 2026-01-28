# Feature Structure Documentation

Đây là cấu trúc chuẩn cho một Feature trong dự án, áp dụng kiến trúc **Clean Architecture** kết hợp với **Feature-First**.

## Sơ đồ kiến trúc (Dependency Rule)

```mermaid
graph TD
    P[Presentation Layer] --> A[Application Layer]
    P --> D[Domain Layer]
    A --> D
    Data[Data Layer] --> D
    Data --> I[Infrastructure (Core)]
    
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

1.  **[Presentation](presentation/README.md)**
    *   Chứa UI và Logic hiển thị.
    *   `pages`: Các màn hình (Screens).
    *   `widgets`: Các widget tái sử dụng trong feature.
    
2.  **[Application](application/README.md)**
    *   State Management (Bloc/Cubit).
    *   `bloc`: Quản lý trạng thái và logic nghiệp vụ UI.
    
3.  **[Domain](domain/README.md)**
    *   **Lõi của Feature**. Chứa Business Logic thuần túy.
    *   `entities`: Các object nghiệp vụ (User, Product...).
    *   `repositories`: Interface (hợp đồng) giao tiếp dữ liệu.
    *   `usecases`: Các kịch bản nghiệp vụ cụ thể.
    
4.  **[Data](data/README.md)**
    *   Triển khai chi tiết việc lấy/gửi dữ liệu.
    *   `datasources`: Nguồn dữ liệu (Remote API, Local DB).
    *   `models`: Dữ liệu thô (DTO) để parse JSON.
    *   `repositories`: Implementation của Repository trong Domain.

5.  **[Core](core/README.md)**
    *   Các tiện ích (Utils, Extensions) dùng riêng cho feature này.

## Infrastructure

Infrastructure **không nằm trong feature** mà nằm ở `lib/core/infrastructure`. Các feature sẽ sử dụng Infrastructure thông qua Data Layer (Data Sources).

## Luồng dữ liệu (Data Flow)

1.  **UI** (Presentation) gửi Event -> **Bloc** (Application).
2.  **Bloc** gọi **UseCase** (Domain) hoặc **Repository** (Domain).
3.  **Repository Impl** (Data) gọi **DataSource** (Data).
4.  **DataSource** dùng **Infrastructure** (Dio, Hive) lấy data.
5.  **DataSource** trả về **Model** (Data), map sang **Entity** (Domain).
6.  **Repository** trả về **Entity** hoặc **Failure** (Domain).
7.  **Bloc** nhận kết quả, emit **State** mới.
8.  **UI** rebuild theo **State**.
