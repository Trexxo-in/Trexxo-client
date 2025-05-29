import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trexxo_mobility/blocs/auth/auth_event.dart';
import 'package:trexxo_mobility/blocs/auth/auth_state.dart';
import 'package:trexxo_mobility/services/firebase_service.dart';
import 'package:trexxo_mobility/models/user_model.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseService firebaseService;

  // private variable to hold current user
  UserModel? _currentUser;

  // public getter to access current user if needed
  UserModel? get currentUser => _currentUser;

  AuthBloc({required this.firebaseService}) : super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      if (firebaseService.isLoggedIn) {
        final user = await firebaseService.fetchUserModel();
        if (user != null) {
          _currentUser = user; // update current user variable
          emit(Authenticated(user));
        } else {
          _currentUser = null;
          emit(Unauthenticated());
        }
      } else {
        _currentUser = null;
        emit(Unauthenticated());
      }
    });

    on<LoggedIn>((event, emit) async {
      final user = await firebaseService.fetchUserModel();
      if (user != null) {
        _currentUser = user; // update current user variable
        emit(Authenticated(user));
      } else {
        _currentUser = null;
        emit(Unauthenticated());
      }
    });

    on<LoggedOut>((event, emit) async {
      await firebaseService.signOut();
      _currentUser = null; // clear current user on logout
      emit(Unauthenticated());
    });
  }
}
