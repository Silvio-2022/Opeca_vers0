import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginNormalState extends LoginState {
  final bool isConnected;
  LoginNormalState([this.isConnected = false]);
}

class LoginErrorState extends LoginState {
  final String message;
  LoginErrorState({required this.message});
}

class LoginErrorConectionState extends LoginState {
  final String message;
  LoginErrorConectionState({required this.message});
}

class LoginSucessedState extends LoginState {}

class ButtonLoginPressedState extends LoginState {
  final bool isConnected;
  ButtonLoginPressedState({required this.isConnected});
}
class ButtonLoginPressedProcessingState extends LoginState {
  final bool isConnected;
  ButtonLoginPressedProcessingState({required this.isConnected});
}

class ButtonLoginState extends LoginState {}
