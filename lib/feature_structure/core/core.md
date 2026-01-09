# Feature Core
Nơi chứa các thành phần dùng chung (shared) chỉ trong phạm vi của feature này.

## Cấu trúc
- **Widgets**: Các widget dùng chung cho nhiều page trong feature này (Shared Widgets).
- **Utils**: Các hàm tiện ích (Helpers).
- **Constants**: Các hằng số (Strings, Assets path) của feature.
- **Extensions**: Các extension method bổ trợ.

## Lưu ý
- Nếu một thành phần được sử dụng bởi nhiều feature khác nhau, hãy cân nhắc đưa nó vào `lib/core` (App Core) thay vì ở đây.
- Đây không phải là nơi chứa Business Logic.

