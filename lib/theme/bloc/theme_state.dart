// ignore_for_file: sort_constructors_first

part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  const ThemeState(this.mode);
  final ThemeMode mode;

  @override
  List<Object> get props => [mode];

  factory ThemeState.fromJson(Map<String, dynamic> map) {
    return ThemeState(
      map['mode'] as ThemeMode,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mode': mode.name,
    };
  }
}