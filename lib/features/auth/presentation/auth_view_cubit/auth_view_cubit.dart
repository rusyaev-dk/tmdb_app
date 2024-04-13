import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movies_app/core/domain/repositories/repository_failure.dart';
import 'package:movies_app/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:movies_app/core/data/api/api_exceptions.dart';

part 'auth_view_state.dart';

class AuthViewCubit extends Cubit<AuthViewState> {
  late final AuthBloc _authBloc;
  late final StreamSubscription<AuthState> _authBlocSubscription;

  AuthViewCubit({
    required AuthViewState initialState,
    required AuthBloc authBloc,
  })  : _authBloc = authBloc,
        super(initialState) {
    _onState(authBloc.state);
    _authBlocSubscription = authBloc.stream.listen(_onState);
  }

  onAuth({required String login, required String password}) {
    if (!_inputDataValidation(login, password)) {
      return emit(AuthViewErrorState('Fill in your login and/or password'));
    }
    _authBloc.add(AuthLoginEvent(login: login, password: password));
  }

  void _onState(AuthState state) {
    if (state is AuthUnauthorizedState) {
      emit(AuthViewFormFillInProgressState());
    } else if (state is AuthAuthorizedState) {
      _authBlocSubscription.cancel();
      emit(AuthViewSuccessState());
    } else if (state is AuthFailureState) {
      final message = _mapErrorToMessage(state.error);
      emit(AuthViewErrorState(message));
    } else if (state is AuthInProgressState) {
      emit(AuthViewAuthInProgressState());
    } else if (state is AuthStatusCheckInProgressState) {
      emit(AuthViewAuthInProgressState());
    }
  }

  String _mapErrorToMessage(Object error) {
    if (error is! ApiRepositoryFailure) {
      return 'Unknown error, please try again...';
    }
    switch (error.type) {
      case ApiClientExceptionType.network:
        return 'Server is not available. Check your internet connection';
      case ApiClientExceptionType.auth:
        return 'Invalid login and/or password';
      case ApiClientExceptionType.sessionExpired:
      case ApiClientExceptionType.jsonKey:
      case ApiClientExceptionType.unknown:
        return 'An undefined error has occurred. Try again...';
    }
  }

  bool _inputDataValidation(String login, String password) =>
      login.trim().isNotEmpty && password.trim().isNotEmpty;

  @override
  Future<void> close() {
    _authBlocSubscription.cancel();
    return super.close();
  }
}
