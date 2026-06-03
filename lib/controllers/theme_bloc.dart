import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class ThemeEvent {}

class ThemeToggled extends ThemeEvent {
  final Brightness current;
  ThemeToggled(this.current);
}

class ThemeBloc extends Bloc<ThemeEvent, ThemeMode> {
  ThemeBloc() : super(ThemeMode.light) {
    on<ThemeToggled>((event, emit) {
      emit(event.current == Brightness.dark ? ThemeMode.light : ThemeMode.dark);
    });
  }
}
