import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class ChangeBottomNavEvent extends HomeEvent {
  final int index;

  const ChangeBottomNavEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class ResetBottomNavEvent extends HomeEvent {}