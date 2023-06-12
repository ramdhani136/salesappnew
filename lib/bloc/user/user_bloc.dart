import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:salesappnew/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is LoadUsers) {}
      emit(UserLoading());
      final users = await UserRepositiory().getUsers();
      print(users);
      emit(UserLoaded([]));
    });
  }
}
