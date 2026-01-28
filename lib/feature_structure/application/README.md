# Application Layer

Layer này đóng vai trò cầu nối giữa UI (Presentation) và Logic nghiệp vụ (Domain). Nó quản lý trạng thái của ứng dụng (State Management).

## Cấu trúc thư mục

- **`bloc/`** (hoặc `cubit/`):
  - Chứa các file Bloc/Cubit: `events`, `states`, và `bloc` class.
  - Quản lý logic presentation, mapping từ Event sang State.

## Nhiệm vụ

- **Nhận Event**: Lắng nghe các hành động từ UI.
- **Thực thi Logic**: Gọi xuống Domain Layer (UseCases hoặc Repository Interfaces) để xử lý nghiệp vụ.
- **Quản lý State**: Phát ra (emit) các State mới (Loading, Success, Failure) để UI cập nhật.

## Quy tắc

- **Không chứa UI Code**: Không import `flutter/material.dart`, không dùng `BuildContext` trong Bloc.
- **Biến đổi dữ liệu**: Chuyển đổi dữ liệu từ Domain (Entities, Failures) thành dữ liệu phù hợp cho UI (ViewModel hoặc State).

## Ví dụ

```dart
// bloc/home_bloc.dart
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUserUseCase getUser;

  HomeBloc(this.getUser) : super(HomeInitial()) {
    on<LoadUserEvent>((event, emit) async {
      emit(HomeLoading());
      final result = await getUser(event.userId);
      result.fold(
        (failure) => emit(HomeError(failure.message)),
        (user) => emit(HomeLoaded(user)),
      );
    });
  }
}
```
