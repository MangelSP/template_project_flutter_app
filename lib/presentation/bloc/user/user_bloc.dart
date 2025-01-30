import 'package:finance_connect_app/domain/entities/user_entity.dart';
import 'package:finance_connect_app/domain/usecases/get_user_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserData getUserData;

  UserBloc({required this.getUserData}) : super(UserInitial()) {
    on<LoadUserData>((event, emit) async {
      emit(UserLoading());
      final result = await getUserData();
      result.fold(
        (failure) => emit(UserError(failure.message)),
        (user) => emit(UserLoaded(user)),
      );
    });
  }
}
