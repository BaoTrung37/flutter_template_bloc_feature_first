# Presentation Layer

Layer này chịu trách nhiệm hiển thị UI và xử lý tương tác người dùng. Nó là bộ mặt của Feature.

## Cấu trúc thư mục

- **`pages/`**:
  - Chứa các màn hình chính (Screens/Pages).
  - Thường là nơi khởi tạo Bloc (nếu scope là page) và cấu trúc Scaffold.
  - Ví dụ: `HomePage`, `ProductDetailPage`.

- **`widgets/`**:
  - Chứa các UI components nhỏ, có thể tái sử dụng **trong phạm vi feature này**.
  - Nếu widget dùng chung cho cả app, hãy đưa vào `lib/core/presentation/widgets`.
  - Ví dụ: `ProductCard`, `FilterButton`.

## Nhiệm vụ

- **Render UI**: Hiển thị dữ liệu dựa trên State nhận được từ Application Layer.
- **Handle User Input**: Nhận input (tap, scroll, form) và gửi Event tới Application Layer.
- **Navigation**: Điều hướng giữa các trang.

## Quy tắc

- **Passive View**: UI không nên chứa Business Logic. Nó chỉ nên hiển thị những gì được bảo và báo cáo những gì user làm.
- **Dependency**: Chỉ phụ thuộc vào Application Layer (Bloc/Cubit) và Domain Layer (Entities - để hiển thị dữ liệu).

## Ví dụ

```dart
// pages/home_page.dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc()..add(LoadHomeEvent()),
      child: Scaffold(
        body: HomeView(),
      ),
    );
  }
}

// widgets/user_info_card.dart
class UserInfoCard extends StatelessWidget {
  final User user; // Entity từ Domain
  ...
}
```
