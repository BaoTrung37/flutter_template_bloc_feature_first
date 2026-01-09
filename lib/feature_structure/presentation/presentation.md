# Presentation Layer

Layer này chịu trách nhiệm hiển thị UI và xử lý tương tác người dùng.

## Cấu trúc
- **Pages**: Các màn hình chính (Screens) của feature.
- **Widgets**: Các UI components nhỏ hơn, được tách ra để tái sử dụng trong feature.

## Nhiệm vụ
- Lắng nghe state từ `Application Layer` (Bloc/Cubit) để render UI.
- Gửi sự kiện (Event) xuống `Application Layer` khi người dùng tương tác.
- Điều hướng (Navigation) (có thể dùng GoRouter hoặc Navigator).

## Quy tắc
- **Dumb Components**: UI nên "ngu" nhất có thể, không chứa business logic phức tạp.
- **Stateless/Stateful**: Sử dụng linh hoạt, nhưng logic state phức tạp nên đẩy xuống Bloc.

