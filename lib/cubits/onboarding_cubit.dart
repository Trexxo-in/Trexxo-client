import 'package:hydrated_bloc/hydrated_bloc.dart';

class OnboardingCubit extends HydratedCubit<bool> {
  OnboardingCubit() : super(true);

  void completeOnboarding() => emit(false);

  @override
  bool fromJson(Map<String, dynamic> json) {
    return json['firstTime'] as bool? ?? true;
  }

  @override
  Map<String, dynamic> toJson(bool state) {
    return {'firstTime': state};
  }
}
