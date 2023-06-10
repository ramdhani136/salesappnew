import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

enum ColorEvent { ColorToAmberEvent, ColorToBlueEvent }

// Event untuk perubahan warna
// abstract class ColorEvent {}
// class ColorToAmberEvent extends ColorEvent {}

// class ColorToBlueEvent extends ColorEvent {}

// State untuk status warna

class ColorBloc extends Bloc<ColorEvent, Color> {
  ColorBloc() : super(Colors.amber) {
    on<ColorEvent>((event, emit) => {
          if (event == ColorEvent.ColorToAmberEvent)
            {emit(Colors.amber)}
          else
            {emit(Colors.lightBlue)}
        });
  }
}
