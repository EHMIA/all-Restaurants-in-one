import 'package:equatable/equatable.dart';

class AuthRouteState extends Equatable {
  final int selectedIndex;
  final bool isAnimating;

  const AuthRouteState({this.selectedIndex = 0, this.isAnimating = false});

  AuthRouteState copyWith({int? selectedIndex, bool? isAnimating}) {
    return AuthRouteState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isAnimating: isAnimating ?? this.isAnimating,
    );
  }
  
  @override
  List<Object?> get props => [selectedIndex, isAnimating];
}
