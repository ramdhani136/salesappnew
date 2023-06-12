import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salesappnew/models/User';
import 'package:salesappnew/repositories/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  bool isPasswordVisible = false;
  final UserRepositiory repository;
  AuthBloc(this.repository) : super(AuthInitial()) {
    on<AuthEvent>(
      (event, emit) async {
        if (event is OnLogin) {
          emit(AuthLoading());
          try {
            final isLogin =
                await repository.loginUser("administrator", "!Etms000!");

            print(isLogin);

            emit(AuthSuccess(isLogin));
          } catch (error) {
            emit(AuthFailure(error.toString()));
          }
        } else if (event is TogglePasswordVisibility) {
          isPasswordVisible = !isPasswordVisible;
          emit(AuthInitial());
        }
      },
    );
  }
}
