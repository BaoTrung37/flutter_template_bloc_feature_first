# Feature Core

Nơi chứa các thành phần tiện ích, dùng chung **chỉ trong phạm vi của feature này**.

## Cấu trúc gợi ý

- **`utils/`**: Các hàm tiện ích (Helpers) cụ thể cho feature.
- **`constants/`**: Các hằng số (Strings, Assets path, Keys).
- **`extensions/`**: Các extension method bổ trợ.

## Lưu ý

- **Feature Scope**: Chỉ đặt những thứ chỉ dùng riêng cho feature này.
- **Global Scope**: Nếu một thành phần được sử dụng bởi feature khác, hãy đưa nó vào `lib/core` (App Core).
- **No Business Logic**: Đây không phải là nơi chứa logic nghiệp vụ quan trọng.
