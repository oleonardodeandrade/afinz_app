import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ProfileEvent {}

class ToggleValueVisibility extends ProfileEvent {}

class ProfileState {
  final bool isValueVisible;

  ProfileState({this.isValueVisible = true});

  ProfileState copyWith({bool? isValueVisible}) {
    return ProfileState(
      isValueVisible: isValueVisible ?? this.isValueVisible,
    );
  }
}

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState()) {
    on<ToggleValueVisibility>((event, emit) {
      emit(state.copyWith(isValueVisible: !state.isValueVisible));
    });
  }
} 