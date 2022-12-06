import 'package:equatable/equatable.dart';

class SplashEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class SplashProcessing extends SplashEvent {
  
}
class SplashGetConnectionError extends SplashEvent {}
class SplashProcessed extends SplashEvent {}


