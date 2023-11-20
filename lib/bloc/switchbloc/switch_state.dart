part of 'switch_bloc.dart';
 class SwitchState extends Equatable {
  final bool switchvalue;
  const SwitchState({required this.switchvalue});
  
  @override
  List<Object> get props => [switchvalue];
}

final class SwitchInitial extends SwitchState {
  SwitchInitial({required super.switchvalue});

}
