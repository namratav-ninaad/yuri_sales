import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuri_sale/features/home/presentation/bloc/home_event.dart';
import 'package:yuri_sale/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<ChangeBottomNavEvent>(_changeBottomNav);
    on<ResetBottomNavEvent>(_resetBottomNav);
  }

  void _changeBottomNav(ChangeBottomNavEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(selectedIndex: event.index));
  }

  void _resetBottomNav(ResetBottomNavEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(selectedIndex: 0));
  }
}
