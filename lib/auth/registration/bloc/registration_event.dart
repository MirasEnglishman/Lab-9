import 'package:equatable/equatable.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();
  @override List<Object?> get props => [];
}

class RegistrationSubmitted extends RegistrationEvent {
  final String fullName, email, phone;
  const RegistrationSubmitted({
    required this.fullName,
    required this.email,
    required this.phone,
  });
  @override List<Object?> get props => [fullName, email, phone];
}
