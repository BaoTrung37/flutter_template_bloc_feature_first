# Application Layer
Layer này chứa State Management logic của feature (thường là Bloc hoặc Cubit).

## Cấu trúc
- **Blocs/Cubits**: Quản lý trạng thái UI.
- **Micro-Providers**: (Optional) Các provider nhỏ nếu cần.

## Nhiệm vụ
- Nhận events/actions từ `Presentation Layer`.
- Thực thi business logic (thường bằng cách gọi xuống `Domain Layer` hoặc `Infrastructure Layer` thông qua Repository Interfaces).
- Emit (phát ra) state mới để `Presentation Layer` cập nhật UI.

## Quy tắc
- Không nên chứa code UI (Flutter Widgets, BuildContext).
- Nên chuyển đổi các Exception từ lớp dưới thành các Failures/Error State thân thiện với UI.

