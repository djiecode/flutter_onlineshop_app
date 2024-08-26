// // profile_event.dart
// part of 'auth_bloc.dart';

// abstract class ProfileEvent extends Equatable {
//   const ProfileEvent();

//   @override
//   List<Object> get props => [];
// }

// class LoadUserProfile extends ProfileEvent {}

// // profile_state.dart

// abstract class ProfileState extends Equatable {
//   const ProfileState();

//   @override
//   List<Object> get props => [];
// }

// class ProfileInitial extends ProfileState {}

// class ProfileLoading extends ProfileState {}

// class ProfileLoaded extends ProfileState {
//   final AuthResponseModel authResponse;

//   const ProfileLoaded(this.authResponse);

//   @override
//   List<Object> get props => [authResponse];
// }

// class ProfileError extends ProfileState {
//   final String message;

//   const ProfileError(this.message);

//   @override
//   List<Object> get props => [message];
// }
