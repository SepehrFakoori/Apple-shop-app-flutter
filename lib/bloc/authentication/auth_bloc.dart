import 'package:ecommerce_flutter_application/bloc/authentication/auth_event.dart';
import 'package:ecommerce_flutter_application/bloc/authentication/auth_state.dart';
import 'package:ecommerce_flutter_application/data/repository/authentication_repository.dart';
import 'package:ecommerce_flutter_application/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _repository = locator.get();

  AuthBloc() : super(AuthInitiateState()) {
    on<AuthLoginRequestEvent>(
      ((event, emit) async {
        emit(AuthLoadingState());
        var response = await _repository.login(event.username, event.password);
        emit(AuthResponseState(response));
      }),
    );

    on<AuthRegisterRequestEvent>(
      ((event, emit) async {
        emit(AuthLoadingState());
        var response = await _repository.register(event.username, event.password, event.passwordConfirm);
        emit(AuthResponseState(response));
      }),
    );
  }
}
