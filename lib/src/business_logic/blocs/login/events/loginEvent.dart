import 'package:equatable/equatable.dart';

class LoginEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoginGetConnection extends LoginEvent {}
class LoginNoConnection extends LoginEvent {}

class LoginExecutedError extends LoginEvent {}

class LoginValidatingCredentials extends LoginEvent {}
class LoginExecutedSuccess extends LoginEvent {}

class LoginProcessing extends LoginEvent {}
class LoginProcessing1 extends LoginEvent {}
