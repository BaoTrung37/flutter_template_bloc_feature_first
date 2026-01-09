# Domain Layer
Layer này là lõi của feature, chứa các business rules và định nghĩa dữ liệu (Entities) độc lập với framework.

## Cấu trúc
- **Entities**: Business objects (ví dụ: `User`, `Product`). Thường dùng `freezed` hoặc `equatable`.
- **Repository Contracts (Interfaces)**: Các abstract class định nghĩa cách truy xuất dữ liệu (ví dụ: `IAuthRepository`).
- **Failures**: Định nghĩa các lỗi business (ví dụ: `InvalidPasswordFailure`).
- **Value Objects**: (Optional) Các object nhỏ có validation logic sẵn (ví dụ: `EmailAddress`).
- **UseCases**: (Optional) Mỗi use case đại diện cho một hành động business cụ thể.

## Nhiệm vụ
- Định nghĩa _"Cái gì"_ (What) mà app làm, không phải _"Làm như thế nào"_ (How).
- Hoàn toàn độc lập với Flutter, API, DB (Dependency Rule).

## Quy tắc
- **Không phụ thuộc**: Domain không được import `application`, `infrastructure`, hay `presentation`.
- **Pure Dart**: Nên chỉ sử dụng code Dart thuần túy.

