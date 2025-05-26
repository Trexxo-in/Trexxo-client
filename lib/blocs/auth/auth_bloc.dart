import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trexxo_mobility/blocs/auth/auth_event.dart';
import 'package:trexxo_mobility/blocs/auth/auth_state.dart';
import 'package:trexxo_mobility/services/auth_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc({required this.authService}) : super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      final user = authService.currentUser();
      if (user != null) {
        emit(Authenticated(user.uid));
      } else {
        emit(Unauthenticated());
      }
    });

    on<LoggedIn>((event, emit) {
      final user = authService.currentUser();
      if (user != null) {
        emit(Authenticated(user.uid));
      } else {
        emit(Unauthenticated());
      }
    });

    on<LoggedOut>((event, emit) async {
      await authService.signOut();
      emit(Unauthenticated());
    });
  }
}
