import 'package:equatable/equatable.dart';

class MainEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class MainOpenning extends MainEvent {}

class MainGetConnectionError extends MainEvent {}

class MainGetConnectionSuccess extends MainEvent {}
