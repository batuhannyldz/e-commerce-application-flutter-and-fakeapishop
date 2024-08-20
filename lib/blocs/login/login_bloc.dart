import 'package:fakeapi/models/login_model.dart';
import 'package:fakeapi/repositores/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  // LoginButtonPressed event handler
  Future<void> _onLoginButtonPressed(LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      final User user = await authRepository.login(event.username, event.password);
      emit(LoginSuccess(token: user.token));
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }
}