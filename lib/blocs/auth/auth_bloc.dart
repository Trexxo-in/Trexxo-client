import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trexxo_mobility/blocs/auth/auth_event.dart';
import 'package:trexxo_mobility/blocs/auth/auth_state.dart';
import 'package:trexxo_mobility/services/firebase_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseService firebaseService;

  AuthBloc({required this.firebaseService}) : super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      if (firebaseService.isLoggedIn) {
        emit(Authenticated(firebaseService.currentUser!.uid));
      } else {
        emit(Unauthenticated());
      }
    });

    on<LoggedIn>((event, emit) {
      emit(Authenticated(firebaseService.currentUser!.uid));
    });

    on<LoggedOut>((event, emit) async {
      await firebaseService.signOut();
      emit(Unauthenticated());
    });
  }
}
