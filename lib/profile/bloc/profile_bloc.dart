import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lab_9_1/models/profile.dart';
import 'package:lab_9_1/profile/repository/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _repository = ProfileRepository();
  ProfileBloc() : super(ProfileInitial()) {
    on<FetchedProfileEvent>(_repository.getProfileData);
  }
}
