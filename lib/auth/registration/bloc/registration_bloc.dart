import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_9_1/auth/registration/bloc/registration_event.dart';
import 'package:lab_9_1/auth/registration/bloc/registration_state.dart';
import 'package:lab_9_1/auth/registration/repository/registration_repository.dart';

class RegistrationBloc
    extends Bloc<RegistrationEvent, RegistrationState> {
  final RegistrationRepository _repo;
  RegistrationBloc(this._repo) : super(RegistrationInitial()) {
    on<RegistrationSubmitted>(_onSubmit);
  }

  Future<void> _onSubmit(
      RegistrationSubmitted event,
      Emitter<RegistrationState> emit,
  ) async {
    emit(RegistrationLoading());
    try {
      await _repo.registerUser(
        fullName: event.fullName,
        email: event.email,
        phone: event.phone,
      );
      emit(RegistrationSuccess());
    } catch (e) {
      emit(RegistrationFailure(e.toString()));
    }
  }
}